name             'baas-windows'
maintainer       'Oneops'
maintainer_email 'support@oneops.com'
license          'Apache License, Version 2.0'
description      'This cookbook installs baas driver on windows VM'
version          '0.1.0'

supports 'windows'
depends 'nugetpackage'

grouping 'default',
  :access   => "global",
  :packages => [ 'base', 'mgmt.catalog', 'mgmt.manifest', 'catalog', 'manifest', 'bom' ]


  attribute 'repository_url',
    :description => "Repository URL",
    :required    => "required",
    :format      => {
      :help      => 'Base URL of the repository, Ex: https://www.nuget.org/api/v2/',
      :category  => '1.General',
      :order     => 1
    }

    attribute 'package_name',
      :description => "Package Name",
      :default     => '',
      :required    => 'required',
      :format      => {
        :help      => 'Add nuget package Name for BaaS',
        :category  => '2.Nuget Package Details',
        :order     => 1
      }

      attribute 'version',
        :description => "Package Version",
        :default     => '',
        :required    => 'required',
        :format      => {
          :help      => 'Add nuget package Version for BaaS',
          :category  => '2.Nuget Version Details',
          :order     => 2
        }

        attribute 'physical_path',
          :description => 'Application Directory',
          :default     => '',
          :required    => 'required',
          :format      => {
            :help      => 'The application directory where the package will be installed, Default value is set to e:\apps',
            :category  => '1.General',
            :order     => 2
          }

        attribute 'install_dir',
          :description => 'Install Directory',
          :default     => '',
          :required    => 'required',
          :format      => {
            :help      => 'The physical path on disk where the package will be deployed, Default value is set to e:\platform_deployment',
            :category  => '1.General',
            :order     => 3
          }

          attribute 'pathtoexe',
            :description => 'Path to the Job Exe',
            :default     => '',
            :required    => 'required',
            :format      => {
              :help      => 'Path to the exe file',
              :category  => '1.General',
              :order     => 4
            }


          attribute 'jobid',
            :description => 'Job ID',
            :default     => '',
            :required    => 'required',
            :format      => {
              :help      => 'Job ID for BaaS',
              :category  => '3.BaaS Details',
              :order     => 1
            }

            attribute 'driverid',
              :description => 'Driver ID',
              :default     => '',
              :required    => 'required',
              :format      => {
                :help      => 'Driver ID for BaaS',
                :category  => '3.BaaS Details',
                :order     => 2
              }
