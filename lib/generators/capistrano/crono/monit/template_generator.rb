module Capistrano
  module Crono
    module Monit
      module Generators
        class TemplateGenerator < Rails::Generators::Base

          namespace "capistrano:crono:monit:template"
          desc "Create local monitrc.erb, and erb files for monitored processes for customization"
          source_root File.expand_path('../../../../../capistrano/templates', __FILE__)
          argument :templates_path, type: :string,
            default: "config/deploy/templates",
            banner: "path to templates"

          def copy_template
            copy_file "crono_monit.conf.erb", "#{templates_path}/crono_monit.erb"
          end

        end
      end
    end
  end
end
