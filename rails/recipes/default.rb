include_recipe 'deploy'

gem_package 'bundler' do
  action :install
end
