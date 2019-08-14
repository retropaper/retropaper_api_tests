
$select_env = ENV['SELECT_ENV'] || "server"

case $select_env
when "local"
  ENV['SERVER_HOSTNAME'] = "http://localhost:8090"
  ENV['API'] = "api"
  ENV['PERSON_API'] = "person"
  ENV['MOVIE_API'] = "movie"
  ENV['MOVIE_API'] = "dossier"
when "server"
  ENV['SERVER_HOSTNAME'] = "https://gateway.jets-biometrics.sevatecdemo.com"
  ENV['API'] = "api"
  ENV['PERSON_API'] = "applicant"
  ENV['MOVIE_API'] = "applicant"
else
  raise "Current env tier has been set to: [ #{ENV['TIER']} ], please check your env tier"
end

ENV['PERSON_API'] = "#{ENV['SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['PERSON_API']}"
ENV['MOVIE_API'] = "#{ENV['SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['MOVIE_API']}"

#COMMON
ENV['AMPERSAND'] = "&"
ENV['BAD_REQUEST'] = "!#@#$#^$#%&^%*%&*(^&*"

#MOVIE API
ENV['MOVIE_ALL'] = "all"
ENV['MOVIE_ID'] = "id="
ENV['MOVIE_SEARCH'] = "search?"
ENV['MOVIE_TITLE'] = "title="
ENV['MOVIE_YEAR'] = "year="


#PERSON API
ENV['PERSON_ALL'] = "all"
ENV['PERSON_ID'] = "id="
ENV['PERSON_NAME'] = "name/"
ENV['PERSON_SEARCH'] = "search?"
ENV['PERSON_TERM'] = "term="


#DOSSIER API
ENV['DOSSIER_ALL'] = "all"
ENV['DOSSIER_CREATE_NEW'] = "dossier"
ENV['DOSSIER_MY'] = "my"
ENV['DOSSIER_ID'] = "id"
ENV['DOSSIER_UPDATE'] = "update"


