include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  railsenv = deploy['environment_variables']['RAILS_ENV'] || 'production'
  execute "cd #{deploy[:deploy_to]}/shared/scripts && ./unicorn restart"
end

