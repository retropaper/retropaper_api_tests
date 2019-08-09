@Library('shared-libs')
import groovy.transform.Field;
import sevatec.GithubIssue;
import sevatec.GithubStatus;

def worker_label = "worker-${UUID.randomUUID().toString()}"

@Field String orgName = 'SevatecInc'
@Field String repoName = 'bdso_bdd_api'
@Field String gitCommit = null
def shortGitCommit = null
def containerImage  = "jets-biometrics/bdso-bdd-api"
def previousGitCommit = null
@Field String buildUrl = null
def containerTag = null
@Field String gitUrl = null
@Field String ghprbPullTitle = ''
@Field String slackUrl = "https://teamsevatec-uscisbdso.slack.com/services/hooks/jenkins-ci"
@Field String slackToken = "bdso-slack-token"
@Field String slackChannel = '#jenkins-notifications'
@Field String slackdomain = "teamsevatec-uscisbdso"

def makeStatus(String stage, String status) {

	println "***============= MAKE STATUS ${stage} ${status} ============***"
	println "GIT COMMIT: ${gitCommit}"
	println "BUILD URL: ${buildUrl}"
	println "GIT URL: ${gitUrl}"

	withCredentials([string(credentialsId: 'ghprb', variable: 'TOKEN')]) {
		GithubStatus githubStatus = new GithubStatus()
		githubStatus.setToken(TOKEN)
		githubStatus.setStatus(status)
		githubStatus.setDescription("${stage}:${status}")
		githubStatus.setStatusContext(stage)
		githubStatus.setGitUrl(gitUrl)
		githubStatus.setOrgName(orgName)
		githubStatus.setGitCommit(gitCommit)
		githubStatus.setBuildUrl(buildUrl)
		githubStatus.createStatus()
		githubStatus.setRepoName(repoName)
		githubStatus.setServiceUser('tics-bot')
	}
}

def makeIssue(String stage) {
	withCredentials([string(credentialsId: 'ghprb', variable: 'TOKEN')]) {
		GithubIssue githubIssue = new GithubIssue()
		githubIssue.setToken(TOKEN)
		githubIssue.setIssueBody("Error during ${stage}, see ${buildUrl}")
		githubIssue.setIssueTitle("${ghprbSourceBranch} ${stage} Failure")
		githubIssue.setAuthor([ghprbPullAuthorLogin])
		githubIssue.setGitUrl(gitUrl)
		githubIssue.setOrgName(orgName)
		githubIssue.createIssue()
	}
}

tag = ''
branchName = ''

def output(String stage, String status) {
	def slackColor = ''
	def slackMessage = ''
	if (status == 'success') {
		slackColor = 'good'
	}
	else {
		slackColor = 'danger'
	}
	try {
		makeStatus(stage, status)
		println "***========= STATUS MADE ${status} : ${stage} =======***"
		if (status == 'failure'){
			slackMessage = "BDSO-API-TestCases Master: Build ${env.BUILD_ID} ${status} during ${stage}. See ${env.BUILD_URL}"
			//makeIssue(stage)
		}
		else {
			slackMessage = "BDSO-API-TestCases Master: Build ${env.BUILD_ID} ${status} during ${stage}."
		}

		slackSend baseUrl: slackUrl, teamDomain: slackdomain, tokenCredentialId: slackToken, channel: slackChannel, color: slackColor, message: slackMessage
	}
	catch(err) {
		println 'Issue communicating with Github'
		println err
	}
}

podTemplate(
		label: worker_label, yaml: """
kind: Pod
metadata:
  name: bdso-bdd-api-master-build
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  - name: docker
    image: docker:18.06.1-ce-dind
    imagePullPolicy: Always
    securityContext:
      runAsUser: 1000
    command:
    - cat
    tty: true
    volumeMounts:
      - name: docker-sock-volume
        mountPath: /var/run/docker.sock
  - name: ruby
    image: circleci/ruby:latest
    imagePullPolicy: Always
    command:
    - cat
    tty: true
  - name: jq
    image: endeveit/docker-jq
    imagePullPolicy: Always
    command:
    - cat
    tty: true
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: gcr-jets-biometrics-dockercfg
          items:
            - key: .dockerconfigjson
              path: config.json
  - name: docker-sock-volume
    securityContext:
      privileged: true
    hostPath:
      path: /var/run/docker.sock
  - name: kaniko-secret
    secret:
      secretName: stic-gcr-secret
"""
		)
{
	node(worker_label) {

		stage('Prepare') {
			scmInfo = checkout scm
			echo "scm : ${scmInfo}"
			gitCommit = scmInfo.GIT_COMMIT
			shortGitCommit = gitCommit[0..10]
			previousGitCommit = scmInfo.GIT_PREVIOUS_COMMIT
			buildUrl = env.BUILD_URL
			containerTag = "master-${shortGitCommit}"
			gitUrl = scmInfo.GIT_URL
			currentBuild.displayName = containerTag

			def commit_message = sh(returnStdout: true, script: "git log -n 1 ${gitCommit} | tail -1")
			currentBuild.description = commit_message

			container('ruby') {
				sh """
                    echo "BUILD_URL=${buildUrl}"
                    echo "GIT_COMMIT=${gitCommit}"
                    echo "SHORT_GIT_COMMIT=${shortGitCommit}"
                """
			}

		}

		stage('Code Compile') {

			try {
				container('ruby') {
					sh """
					    ruby -v
						cucumber -v
					    bundle install
					    cd test
						cucumber --i18n help
                    """
				}
				output('Compile', 'success')
			}
			catch(err) {
				output('Compile', 'failure')
				throw err
			}
		}

		stage('Run API Test Cases') {

			try {
				container('ruby') {
					sh """
                        cd test
						cucumber -t @HIGH
                    """
				}
				output('Run Test APIs', 'success')
				publishHTML (target: [
					allowMissing: false,
					alwaysLinkToLastBuild: false,
					keepAll: true,
					reportDir: 'target/surefire-reports',
					reportFiles: 'index.html',
					reportName: "API test cases report"
				])
			}
			catch(err) {
				output('Run Test APIs', 'failure')
				publishHTML (target: [
					allowMissing: false,
					alwaysLinkToLastBuild: false,
					keepAll: true,
					reportDir: 'target/surefire-reports',
					reportFiles: 'index.html',
					reportName: "API test cases report"
				])
				throw err
			}
		}
	}
}

