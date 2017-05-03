deploy 'capistrano' do
  repo 'git@dev.rhsoftware.com.br:dental-cloud/tools.git'
  user 'daploy'
  deploy_to '/tmp/tools'
  action :deploy
end