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

    only_if do
      deploy[:database][:append].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end