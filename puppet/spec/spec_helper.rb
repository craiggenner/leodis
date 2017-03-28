require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.after(:suite) do
    #RSpec::Puppet::Coverage.report!(95) - code coverage to be at least 95%.
    RSpec::Puppet::Coverage.report!
  end
end
