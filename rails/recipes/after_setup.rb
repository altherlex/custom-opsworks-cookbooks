node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  execute 'Adding map to rh-soft git' do

    ssh_config=<<EOF

Host git.rhsoftware.com.br
  Hostname git.rhsoftware.com.br
  User git
  Port 18565

EOF
    command "echo #{ssh_config} >> ~/.ssh/config"
    user 'root'
  end
end