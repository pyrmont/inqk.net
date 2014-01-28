default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :ssh_options, { :forward_agent => true }

set :application, "inqk.net"
set :domain,      "deploy.inqk.net"
set :repository,  "git@github.com:pyrmont/inqk.git"
set :deploy_to,   "/var/www/inqk.net"
set :shared_path, "#{deploy_to}/shared"
set :use_sudo,    false
 
set :scm,        :git
set :branch,     'master'
set :deploy_via, :remote_cache

role :web, domain
role :app, domain # this can be the same as the web server
role :db,  domain, :primary => true # this can be the same as the web server
 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end
end

namespace :deploy do
  task :create_symlinks, :roles => :web do
    run "ln -s #{shared_path}/weblog #{current_release}/weblog"
  end
end

after "deploy:finalize_update", "deploy:create_symlinks"