#env_local
ENV['TIER'] = "local"


case ENV['TIER']
when "local"
  ENV['GATEWAY_HOSTNAME'] = "http://localhost:8090"
  ENV['API'] = "api"
when "aws"
  ENV['GATEWAY_HOSTNAME'] = "http://aws_url"
  ENV['API'] = "api"
else
  raise "Current env tier has been set to: [ #{ENV['TIER']} ], please check your env tier"
end

ENV['BDSO_GATEWAY'] = "#{ENV['GATEWAY_HOSTNAME']}/#{ENV['API']}"
ENV['HEALTH'] = "health"
ENV['USERS'] = "users"
ENV['SINGLE_USER'] = "userid"
ENV['ALL_USER'] = "all"
ENV['LOGGED_IN_USER'] = "ME"




