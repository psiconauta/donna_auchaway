# Deploy en entorno de producción.
set :deploy_user, ENV['DONNA_DEPLOY_USER']
set :deploy_to, ENV['DONNA_DEPLOY_PATH']

# Agregar grupos a ignorar (se:concatenan:así).
append :bundle_without, ':deploy'

server ENV['DONNA_DEPLOY_SERVER'],
  user: fetch(:deploy_user),
  roles: %w[app web db]
