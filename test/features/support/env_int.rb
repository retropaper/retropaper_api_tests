#env_int

#env_local
ENV['TIER'] = "server"


case ENV['TIER']
when "local"
  ENV['SERVER_HOSTNAME'] = "http://localhost:8090"
  ENV['API'] = "api"
  ENV['APPLICANT_HOSTNAME'] = "applicant"
when "server"
  ENV['SERVER_HOSTNAME'] = "https://gateway.jets-biometrics.sevatecdemo.com"
  ENV['API'] = "api"
  ENV['APPLICANT_HOSTNAME'] = "applicant"
else
  raise "Current env tier has been set to: [ #{ENV['TIER']} ], please check your env tier"
end

ENV['BDSO_APPLICANT_API'] = "#{ENV['SERVER_HOSTNAME']}/#{ENV['API']}/#{ENV['APPLICANT_HOSTNAME']}"
ENV['HEALTH'] = "health"
ENV['USERS'] = "users"
ENV['SINGLE_USER'] = "userid"
ENV['ALL_USER'] = "all"
ENV['LOGGED_IN_USER'] = "ME"






