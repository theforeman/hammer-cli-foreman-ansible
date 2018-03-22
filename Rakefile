require 'rake/testtask'
require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

namespace :gettext do
  desc 'Update pot file'
  task :setup do
    require 'hammer_cli_foreman_ansible/version'
    require 'hammer_cli_foreman_ansible/i18n'
    require 'gettext/tools/task'

    domain = HammerCLIForemanAnsible::I18n::LocaleDomain.new
    GetText::Tools::Task.define do |task|
      task.package_name = domain.domain_name
      task.package_version = HammerCLIForemanAnsible.version.to_s
      task.domain = domain.domain_name
      task.mo_base_directory = domain.locale_dir
      task.po_base_directory = domain.locale_dir
      task.files = domain.translated_files
    end
  end

  desc 'Update pot file'
  task find: [:setup] do
    Rake::Task['gettext:po:update'].invoke
  end
end

namespace :pkg do
  desc 'Generate package source gem'
  task generate_source: :build
end
