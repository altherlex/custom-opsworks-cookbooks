node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  Chef::Log.info("------ Starting adding rh-soft git config in ssh")
  execute 'Adding map to rh-soft git' do
    ssh_config=<<EOF

Host git.rhsoftware.com.br
  Hostname git.rhsoftware.com.br
  User git
  Port #{deploy['environment_variables']['GIT_REPO_PORT']}

EOF

    cmd = "echo -e \"#{ssh_config}\" >> /home/#{deploy[:user]}/.ssh/config"
    Chef::Log.info cmd
    command cmd

    # user deploy[:user]
    # group deploy[:group]
  end
end
