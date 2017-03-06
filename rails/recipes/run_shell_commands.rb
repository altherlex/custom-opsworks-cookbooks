node[:deploy].each do |application, deploy|
  
  deploy = node[:deploy][application]

  node[:run_shell_commands].each do |cmd|

    # execute "foreman export upstart /etc/init -a #{app_name} -u #{config[:user]} -l /var/log/#{app_name}" do
    #   cwd current_path
    #   environment config['environment_variables']
    # end


    # Chef::Log.debug("[Run shell commands]: run #{cmd}")
    execute "running #{cmd}" do
      cwd deploy[:current_path]
      command cmd
      action :run
    end  
  end
end