include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  ruby_block "append_to_database_yaml" do
    block do
      require 'yaml'
      open("#{deploy[:deploy_to]}/shared/config/database.yml", 'a') { |f|
        f << deploy[:database][:append].to_hash.to_yaml.sub("!ruby/hash:Chef::Node::ImmutableMash","").sub("---","")
        f << "\n"
      }
    end

    # not_if "grep '#{deploy[:database][:append].keys.first.to_s}' #{deploy[:deploy_to]}/shared/config/database.yml"

    Chef::Log.info deploy[:database][:append].inspect
    Chef::Log.info File.directory?("#{deploy[:deploy_to]}/shared/config/").inspect

    # only_if do
    #   deploy[:database][:append].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
    # end
  end

  execute "unicorn_stopping" do
    user deploy[:user]
    group deploy[:group]
    command "ps aux | grep 'unicorn' | awk '{print $2}' | xargs sudo kill -9"
  end

  execute "unicorn_restarting" do
    user deploy[:user]
    group deploy[:group]
    cwd "#{deploy[:deploy_to]}/shared/scripts"
    command './unicorn start'
    environment deploy['environment_variables']
  end  
end