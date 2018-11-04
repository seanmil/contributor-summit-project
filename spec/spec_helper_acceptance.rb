require 'beaker-puppet'
require 'puppet'
require 'beaker-rspec/spec_helper'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_module_on(hosts)

RSpec.configure do |c|
  c.formatter = :documentation
end
