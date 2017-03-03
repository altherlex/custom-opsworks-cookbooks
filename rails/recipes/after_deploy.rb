include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  deploy = node[:deploy][application]

  # script "install_something" do
  #   interpreter "bash"
  #   user "root"
  #   cwd "/tmp"
  #   code <<-EOH
  #     #insert bash script
  #   EOH
  # end

  ruby_block "append_to_database_yaml" do
    block do
      require 'yaml'
      open("#{deploy[:deploy_to]}/shared/config/database.yml", 'a') { |f|
        f << YAML.dump(deploy[:database][:append])
      }
    end

    only_if do
      deploy[:database][:append].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
    end
  end

  # execute "echo #{deploy[:database][:append]} >> #{deploy[:deploy_to]}/shared/config/database.yml" do
  #   user deploy[:user]
  #   group deploy[:group]

  #   only_if do
  #     deploy[:database][:append].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
  #   end
  # end

  # execute "bundle exec shoryuken -C config/shoryuken.yml -L log/shoryuken.log --rails &" do
  #   cwd current_path
  #   environment deploy['environment_variables']
  # end

end