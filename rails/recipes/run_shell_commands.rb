include_recipe 'deploy'

Chef::Log.info("******Running shell commands.******")

node[:deploy].each do |application, deploy|
  
  deploy = node[:deploy][application]

  node[:run_shell_commands].each do |config_cmd|

    execute "running: #{config_cmd}" do
      cwd deploy[:current_path]

      user config_cmd[:user]||deploy[:user]
      group deploy[:group]

      environment deploy[:environment_variables]

      command config_cmd[:name]
    end  
  end
end