#
# Makefile for PO merging and MO generation. More info in the README.
#
# Run make help to list available targets
#
DOMAIN = $(shell ruby -rrubygems -e 'puts Gem::Specification::load(Dir.glob("../*.gemspec").first).name')
VERSION = $(shell ruby -rrubygems -e 'puts Gem::Specification::load(Dir.glob("../*.gemspec").first).version')
MAIN_MAKEFILE = $(shell bundle exec ruby -e 'require "hammer_cli"; puts HammerCLI::I18n.main_makefile')

include $(MAIN_MAKEFILE)
