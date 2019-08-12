Before do |scenario|
  print("Scenario: #{scenario.name}\n")
  unless $dunit
    Environment.setTier ENV['TIER']
    p "Tier set to: #{ENV['TIER']}"
    #$driver = UI_Helper_Methods.getDriver (ENV["Browser"])
    $dunit = true
  end
end