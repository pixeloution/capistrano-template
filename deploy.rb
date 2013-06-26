# IMPORTANT: 
# run cap deploy:setup before first deploy, cap deploy:check to check for issues

# this option allows capistrano to accept the key from bitbucket and put it
# in your known_hosts file
set :default_run_options, {:pty => true}

# application name (meaningless)
set :application, "myApplication"

# repository address (SSH) and type of repository. it will guess if you don't specify
# the :scm option
set :repository,  "git@bitbucket.org:pixeloution/twittersift.git"
set :scm, :git

# when capistrano deploys, it creates a timestamped folder and symlinks the latest;
# this specifies how many deploys to keep
set :keep_releases, 5

# directory you want the project to deploy to. cap will create a folder
# called 'current' within this directory which is a simlink to the
# latest deploy
set :deploy_to, '/var/www/my-folder'

# this is the user your local machine can log into the server as
# you must log into the server at least once so your machine has
# the remote in your known_hosts file
set :user, 'ubuntu'

# this should be the remote address of the web server
role :web, "192.81.xxx.xxx"                   

# Agent forwarding can make key management much simpler as it uses 
# your local keys instead of keys installed on the server. This also requires
# an entry in .ssh/config under the proper host: FowardAgent yes
set :ssh_options, { :forward_agent => true }

# tells capistrano what branch to use for deployments
set :branch, 'master'

# we want to deploy as few files as possible - this causes capistrano
# to keep a git repo of the project on the remote and uses git to pull changes
set :deploy_via, :remote_cache


namespace :deploy do
   # called by update_code after the basic deploy finishes. It assumes a Rails 
   # project was deployed so override. normally changes permissions, sets timestamps
   # via touch. not sure if I want to do anything here
   task :finalize_update, :except => { :no_release => true } do
      # doing nothing
   end

   task :migrate do
      # also do nothing, although we could in future run laravel's migrate
   end
      
   task :restart, :roles => :app, :except => { :no_release => true } do
      # do nothing
   end
end
