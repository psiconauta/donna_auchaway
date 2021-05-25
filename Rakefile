# Lista de tareas para facilitar cosas.
require_relative 'boot'
# Cargar las tareas de ActiveRecord (namespace db).
load 'active_record/railties/databases.rake'

# Esta tarea configura el entorno para ActiveRecord, que normalmente daría
# Rails.
task :environment do
  include ActiveRecord::Tasks

  config = Donna::Config.instance

  DatabaseTasks.env = config.entorno
  DatabaseTasks.database_configuration = { config.entorno => config.db }
  DatabaseTasks.db_dir = File.expand_path('db')
  DatabaseTasks.migrations_paths = File.join(DatabaseTasks.db_dir, 'migrate')
  DatabaseTasks.root = File.dirname(__FILE__)
end
