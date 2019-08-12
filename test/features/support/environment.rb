module Environment
  @tier = "server"

  def self.getTier
    return @tier
  end

  def self.setTier tier
    if tier == "local"
      require_relative './env_local.rb'
    elsif tier == "server"
      require_relative './env_int.rb'
    else tier == "stage"
      require_relative './env_stage.rb'
    end
    @tier = tier
    if(tier)
      puts "environment set to tier [" + tier.to_s + "]"
    end
  end
end