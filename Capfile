# Cargar capistrano y sus tareas.
require 'capistrano/setup'
require 'capistrano/deploy'

# Usar Git.
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Verificar que exista la versión de ruby.
require 'capistrano/rbenv'
# Instalar las gemas.
require 'capistrano/bundler'
# Correr las migraciones de ActiveRecord.
require 'capistrano/rails/migrations'

# Cargar las tareas propias.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
