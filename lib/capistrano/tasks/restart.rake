desc 'Reinicia el service de systemd'
namespace :deploy do
  task :restart do
    on roles(:app) do
      sudo 'systemctl', 'restart', fetch(:systemd_service_name)
    end
  end
end
