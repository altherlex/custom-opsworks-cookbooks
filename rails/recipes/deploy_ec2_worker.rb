deploy 'capistrano' do
  repo 'git@dev.rhsoftware.com.br:dental-cloud/tools.git'
  user 'deploy'
  deploy_to '/tmp'
  action :deploy
end