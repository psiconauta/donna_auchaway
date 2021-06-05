# Deploy en entorno de producción.
set :deploy_user, ENV['DONNA_DEPLOY_USER']
set :deploy_to, ENV['DONNA_DEPLOY_PATH']

server ENV['DONNA_DEPLOY_SERVER'], user: fetch(:deploy_user)
