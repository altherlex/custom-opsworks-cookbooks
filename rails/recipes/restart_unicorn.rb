include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  execute "unicorn_stopping" do
    user deploy[:user]
    group deploy[:group]
    command "ps aux | grep 'unicorn' | awk '{print $2}' | xargs sudo kill -9 | exit 0"
  end

  execute "unicorn_restarting" do
    user deploy[:user]
    group deploy[:group]
    cwd "#{deploy[:deploy_to]}/shared/scripts"
    command './unicorn start'
    environment deploy['environment_variables']
  end  

end

