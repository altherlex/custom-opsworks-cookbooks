def first_instance?
  if node['opsworks']['instance']['layers'].include?('application')
    instances = node['opsworks']['layers']['application']['instances'].keys
    current_instance = node['opsworks']['instance']['hostname']

    !instances.first || instances.first == current_instance
  end
end