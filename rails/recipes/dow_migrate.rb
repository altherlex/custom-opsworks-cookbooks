include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  if first_instance?
    execute 'bundle exec rake dow:migrate' do
      user deploy[:user]
      group deploy[:group]
      cwd "#{deploy[:deploy_to]}/current"
      environment deploy['environment_variables']
    end
  end

end
