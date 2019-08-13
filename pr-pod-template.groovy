@Library('shared-libs')
import groovy.transform.Field;
import sevatec.GithubIssue;
import sevatec.GithubStatus;

def worker_label = "worker-${UUID.randomUUID().toString()}"

@Field String orgName = 'retropaper'
@Field String repoName = 'retropaper_api_tests'
@Field String gitCommit = null
def shortGitCommit = null
def containerImage  = "jets-records/retropaper_api_tests"
def previousGitCommit = null
@Field String buildUrl = null
def containerTag = null
@Field String gitUrl = null
@Field String ghprbPullTitle = ''
@Field String slackUrl = "https://teamsevatec-uscisrdso.slack.com/services/hooks/jenkins-ci"
@Field String slackToken = "rdso-slack-token"
@Field String slackChannel = '#jenkins-notifications'
@Field String slackdomain = "teamsevatec-uscisrdso"

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
		githubStatus.setRepoName(repoName)
		githubStatus.createStatus()
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
			slackMessage = "retropaper-api-tests PR: Build ${env.BUILD_ID} ${status} during ${stage}. See ${env.BUILD_URL}"
			//makeIssue(stage)
		}
		else {
			slackMessage = "retropaper-api-tests PR: Build ${env.BUILD_ID} ${status} during ${stage}."
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
  name: retropaper-api-tests-pr-build
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
    image: ruby:2.3.7
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
          name: gcr-jets-records-dockercfg
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
			gitCommit = ghprbActualCommit
			shortGitCommit = gitCommit[0..10]
			previousGitCommit = scmInfo.GIT_PREVIOUS_COMMIT
			buildUrl = env.BUILD_URL
			containerTag = "pr-${shortGitCommit}"
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
					    bundle install
						cucumber --version
					    cd test
						cucumber --i18n help
                    """
				}
				output('Compile', 'success')
				cucumber buildStatus: 'UNSTABLE',
                fileIncludePattern: 'results/results_api_output.json',
                trendsLimit: 10,
                classifications: [
                    [
                        'key': 'API',
                        'value': 'Applicant'
                    ]
                ]
			}
			catch(err) {
				output('Compile', 'failure')
				cucumber buildStatus: 'UNSTABLE',
                fileIncludePattern: 'results/results_api_output.json',
                trendsLimit: 10,
                classifications: [
                    [
                        'key': 'API',
                        'value': 'Applicant'
                    ]
                ]
				throw err
			}
		}

		stage('Run API Test Cases') {

			try {
				container('ruby') {
					sh """
                        cd test
						cucumber features/ -t @HIGH --format json --out ../results/results_api_output.json --expand -f pretty
                    """
				}
				output('Run Test APIs', 'success')
			}
			catch(err) {
				output('Run Test APIs', 'failure')
				throw err
			}
		}
	}
}