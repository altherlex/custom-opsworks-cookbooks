include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  execute 'bundle exec rake assets:precompile' do
    user deploy[:user]
    group deploy[:group]
    cwd "#{deploy[:deploy_to]}/current"
    environment deploy['environment_variables'].merge('RAILS_GROUPS' => 'assets')

		# not_if !deploy[:assets]
  end

end