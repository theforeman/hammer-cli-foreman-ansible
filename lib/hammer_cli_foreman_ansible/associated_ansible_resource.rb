module HammerCLIForemanAnsible
  module AssociatedAnsibleResource
    def get_current_ids
      resources = HammerCLIForeman.record_to_common_format(resource.call(association_name(true), { id: get_identifier }))
      resources.map { |resource| resource['id'] || resource[:id] }
    end
  end
end
