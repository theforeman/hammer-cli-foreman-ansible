lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hammer_cli_foreman_ansible/version'

Gem::Specification.new do |spec|
  spec.name          = 'hammer_cli_foreman_ansible'
  spec.version       = HammerCLIForemanAnsible.version.dup
  spec.authors       = ['Oleh Fedorenko']
  spec.email         = ['ofedoren@redhat.com']
  spec.homepage      = 'https://github.com/theforeman/hammer-cli-foreman-ansible'
  spec.license       = 'GPL-3.0-only'

  spec.platform      = Gem::Platform::RUBY
  spec.summary       = 'Foreman Ansible plugin for Hammer CLI'

  spec.files         = Dir['{lib,config}/**/*', 'LICENSE', 'README*'] + Dir["locale/**/*.{po,pot,mo}"]
  spec.require_paths = ['lib']
  spec.test_files    = Dir['{test}/**/*']

  spec.required_ruby_version = '>= 2.7', '< 4'

  spec.add_dependency 'hammer_cli_foreman', '~> 3.10'
  spec.add_dependency 'hammer_cli_foreman_remote_execution', '~> 0.3.0'
end
