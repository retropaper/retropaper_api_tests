
$select_env = ENV['SELECT_ENV'] || "server"

case $select_env
when "local"
  ENV['SERVER_HOSTNAME'] = "http://localhost:8090"
  ENV['API'] = "api"
  ENV['VERSION'] = "v1"
  ENV['PERSON_API'] = "person"
  ENV['MOVIE_API'] = "movie"
when "server"
  ENV['PERSON_SERVER_HOSTNAME'] = "https://retropaper-person-service.apps.openshift.sevatecdemo.com"
  ENV['MOVIE_SERVER_HOSTNAME'] = "https://retropaper-person-service.apps.openshift.sevatecdemo.com"
  ENV['API'] = "api"
  ENV['VERSION'] = "v1"
  ENV['PERSON_API'] = "person"
  ENV['MOVIE_API'] = "movie"
else
  raise "Current env tier has been set to: [ #{ENV['TIER']} ], please check your env tier"
end

ENV['PERSON_API'] = "#{ENV['PERSON_SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['VERSION']}/#{ENV['PERSON_API']}"
ENV['MOVIE_API'] = "#{ENV['MOVIE_SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['VERSION']}/#{ENV['MOVIE_API']}"

#COMMON
ENV['AMPERSAND'] = "&"
ENV['BAD_REQUEST'] = "!#@#$#^$#%&^%*%&*(^&*"

#PERSON API
ENV['PARAM_PERSON_ALL'] = "all"
ENV['PARAM_PERSON_ID'] = ""
ENV['PARAM_PERSON_NAME'] = "name/"
ENV['PARAM_PERSON_SEARCH'] = "search?"
ENV['PARAM_PERSON_TERM'] = "term="

#MOVIE API
ENV['PARAM_MOVIE_ALL'] = "all"
ENV['PARAM_MOVIE_ID'] = "id="
ENV['PARAM_MOVIE_SEARCH'] = "search?"
ENV['PARAM_MOVIE_TITLE'] = "title="
ENV['PARAM_MOVIE_YEAR'] = "year="

#DOSSIER API
ENV['DOSSIER_ALL'] = "all"
ENV['DOSSIER_CREATE_NEW'] = "dossier"
ENV['DOSSIER_MY'] = "my"
ENV['DOSSIER_ID'] = "id"
ENV['DOSSIER_UPDATE'] = "update"


