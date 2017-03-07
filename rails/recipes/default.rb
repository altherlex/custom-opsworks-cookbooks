include_recipe 'deploy'

gem_package 'bundler' do
  action :install
end

gem_package 'foreman' do
  action :install
end

if config['swap']['memory_size'].to_i > 0
  swap_file '/mnt/swap' do
    size config['swap']['memory_size']
  end
end

opsworks_deploy_dir do
  user config[:user]
  group config[:group]
  path config[:deploy_to]
end
