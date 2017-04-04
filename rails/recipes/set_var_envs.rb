Chef::Log.info("Running deploy/after_restart.rb")

contents = []

node[:deploy].each do |application, deploy|
  deploy[:environment_variables].each do |key, value|
    contents << "export #{key}=\"'#{value}'\""
  end
end


Chef::Log.info("Adding the environment variables to /etc/profile.d/startup_env_config.sh")

bash "create_startup_env_config.sh" do
  user "root"
  cwd  "/etc/profile.d"
  code <<-EOH
    echo \''#{contents.join(" ")}\'' > startup_env_config.sh
    source startup_env_config.sh
    cd #{release_path}

  EOH
end
