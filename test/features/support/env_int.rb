
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
  ENV['MOVIE_SERVER_HOSTNAME'] = "https://retropaper-movie-service.apps.openshift.sevatecdemo.com"
  ENV['DOSSIER_SERVER_HOSTNAME'] = "https://retropaper-dossier-service.apps.openshift.sevatecdemo.com"
  ENV['API'] = "api"
  ENV['VERSION'] = "v1"
  ENV['PERSON_API'] = "person"
  ENV['MOVIE_API'] = "movie"
  ENV['DOSSIER_API'] = "dossier"
else
  raise "Current env tier has been set to: [ #{ENV['TIER']} ], please check your env tier"
end

ENV['PERSON_API'] = "#{ENV['PERSON_SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['VERSION']}/#{ENV['PERSON_API']}"
ENV['MOVIE_API'] = "#{ENV['MOVIE_SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['VERSION']}/#{ENV['MOVIE_API']}"
ENV['DOSSIER_API'] = "#{ENV['DOSSIER_SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['VERSION']}/#{ENV['DOSSIER_API']}"

#COMMON
ENV['AMPERSAND'] = "&"
ENV['BAD_REQUEST'] = "!#@#$#^$#%&^%*%&*(^&*"

#PERSON API
ENV['PARAM_PERSON_ALL'] = "all"
ENV['PARAM_PERSON_ID'] = ""
ENV['PARAM_PERSON_NAME'] = "name/"
ENV['PARAM_PERSON_SEARCH'] = "search?"
ENV['PARAM_PERSON_TERM'] = "term="
ENV['PARAM_PERSON_CREW'] = "crew/"
ENV['PARAM_PERSON_CHARACTERS'] = "characters/"

#Search Crew : /api/v1/person/crew/{movieId} - Returns the Person records for all of the crew in a given movie

#MOVIE API
ENV['PARAM_MOVIE_ALL'] = "all"
ENV['PARAM_MOVIE_ID'] = ""
ENV['PARAM_MOVIE_SEARCH'] = "search?"
ENV['PARAM_MOVIE_TITLE'] = "title="
ENV['PARAM_MOVIE_YEAR'] = "year="

#DOSSIER API
ENV['PARAM_DOSSIER_ALL'] = "all"
ENV['PARAM_DOSSIER_CREATE_NEW'] = "dossier"
ENV['PARAM_DOSSIER_MY'] = "my"
ENV['PARAM_DOSSIER_ID'] = ""
ENV['PARAM_DOSSIER_UPDATE'] = "update"


