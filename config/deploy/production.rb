# Deploy en entorno de producción.
set :deploy_user, ENV['DONNA_DEPLOY_USER']
set :deploy_to, ENV['DONNA_DEPLOY_PATH']

# Sobreescribir grupos a ignorar (se:concatenan:así), manteniendo los
# existentes.
set :bundle_without, [fetch(:bundle_without), 'deploy'].join(':')

server ENV['DONNA_DEPLOY_SERVER'],
  user: fetch(:deploy_user),
  roles: %w[app web db]
