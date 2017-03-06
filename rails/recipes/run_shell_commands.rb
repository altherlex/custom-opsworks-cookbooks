node[:deploy].each do |application, deploy|
  
  deploy = node[:deploy][application]

  node[:run_shell_commands].each do |cmd|

    execute "running #{cmd}" do
      cwd deploy[:current_path]
      user deploy[:user]
      group deploy[:group]
      environment deploy[:environment_variables]
      command cmd
      action :run
    end  
  end
end