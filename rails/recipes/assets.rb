execute 'bundle exec rake assets:precompile' do
  user config[:user]
  group config[:group]
  cwd current_path
  environment config['environment_variables'].merge('RAILS_GROUPS' => 'assets')
end
