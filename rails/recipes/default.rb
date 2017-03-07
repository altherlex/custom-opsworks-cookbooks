include_recipe 'deploy'

gem_package 'bundler' do
  action :install
end

node[:deploy].each do |application, deploy|
  
  deploy = node[:deploy][application]

  shared_path = "#{deploy[:deploy_to]}/shared"
  execute "bundle check --path=#{shared_path}/bundle || bundle install --binstubs #{shared_path}/bin --path #{shared_path}/bundle --deployment --without development test" do
    user config[:user]
    group config[:group]
    cwd current_path
    environment config['environment_variables']
  end

end
