namespace :load do
  task :defaults do
    set :crono_monit_conf_dir, -> { "/etc/monit/conf.d/#{crono_monit_service_name}.conf" }
    set :crono_monit_use_sudo, true
    set :crono_monit_bin, '/usr/bin/monit'
  end
end

namespace :crono do
  namespace :monit do
    desc 'Config Crono monit-service'
    task :config do
      on roles(fetch(:crono_role)) do |role|
        @role = role
        template_crono 'crono_monit.conf', "#{fetch(:tmp_dir)}/crono_monit.conf"
        sudo_if_needed "mv #{fetch(:tmp_dir)}/crono_monit.conf #{fetch(:crono_monit_conf_dir)}"
        sudo_if_needed "#{fetch(:crono_monit_bin)} reload"
      end
    end

    desc 'Monitor Crono monit-service'
    task :monitor do
      on roles(fetch(:crono_role)) do
        begin
          sudo_if_needed "#{fetch(:crono_monit_bin)} monitor #{crono_monit_service_name}"
        rescue
          invoke 'crono:monit:config'
          sudo_if_needed "#{fetch(:crono_monit_bin)} monitor #{crono_monit_service_name}"
        end
      end
    end

    desc 'Unmonitor Crono monit-service'
    task :unmonitor do
      on roles(fetch(:crono_role)) do
        begin
          sudo_if_needed "#{fetch(:crono_monit_bin)} unmonitor #{crono_monit_service_name}"
        rescue
          # no worries here (still no monitoring)
        end
      end
    end

    desc 'Start Crono monit-service'
    task :start do
      on roles(fetch(:crono_role)) do
        sudo_if_needed "#{fetch(:crono_monit_bin)} start #{crono_monit_service_name}"
      end
    end

    desc 'Stop Crono monit-service'
    task :stop do
      on roles(fetch(:crono_role)) do
        sudo_if_needed "#{fetch(:crono_monit_bin)}  stop #{crono_monit_service_name}"
      end
    end

    desc 'Restart Crono monit-service'
    task :restart do
      on roles(fetch(:crono_role)) do
        sudo_if_needed "#{fetch(:crono_monit_bin)} restart #{crono_monit_service_name}"
      end
    end

    before 'deploy:updating', 'crono:monit:unmonitor'
    after 'deploy:published', 'crono:monit:monitor'

    def crono_monit_service_name
      fetch(:crono_monit_service_name, "crono_#{fetch(:application)}_#{fetch(:stage)}")
    end

    def sudo_if_needed(command)
      if fetch(:crono_monit_use_sudo)
        sudo command
      else
        execute command
      end
    end

  end
end

def template_crono(from, to)
  [
      "lib/capistrano/templates/#{from}.erb",
      "config/deploy/templates/#{from}.erb",
      File.expand_path("../../templates/#{from}.erb", __FILE__)
  ].each do |path|
    if File.file?(path)
      erb = File.read(path)
      upload! StringIO.new(ERB.new(erb, nil, '-').result(binding)), to
      break
    end
  end
end