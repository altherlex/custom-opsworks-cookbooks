deploy 'capistrano' do
  repo 'git@dev.rhsoftware.com.br:dental-cloud/tools.git'
  deploy_to '/tmp'
  action :deploy
end