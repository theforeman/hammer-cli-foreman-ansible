module HammerCLIForemanAnsible
  module ResolverExtension
    def create_ansible_roles_search_options(options, mode = nil)
      if defined? HammerCLIKatello::IdResolver
        create_search_options_without_katello_api(options, api.resource(:ansible_roles), mode)
      else
        create_search_options(options, api.resource(:ansible_roles), mode)
      end
    end
  end

  ::HammerCLIForeman::IdResolver.instance_eval do
    include ResolverExtension
  end
end
