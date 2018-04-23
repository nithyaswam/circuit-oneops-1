if node['platform_family'] == 'windows'

baas_package = node['baas-windows']

package_name = baas_package['package_name']
repository_url = baas_package['repository_url']
physical_path = baas_package["physical_path"]
version = baas_package['version']
install_directory = baas_package['install_dir']
driverId = baas_package['driverid']
jobId = baas_package['jobid']
pathToExe = baas_package['pathtoexe']

nugetpackage package_name do
  action                :install
  repository_url        repository_url
  physical_path         physical_path
  version               version
  deployment_directory  install_directory
end

if node[:workorder][:services].has_key?('dotnet-platform')

  cloud = node.workorder.cloud.ciName
  chocolatey_package_details = JSON.parse(node[:workorder][:services]["dotnet-platform"][cloud]['ciAttributes']['baas_package_details'])
  chocolatey_package_source = node[:workorder][:services]['dotnet-platform'][cloud]['ciAttributes']['chocolatey_package_source']

  mirror_svc = node[:workorder][:services][:mirror]
  if !mirror_svc.nil?
    mirror = JSON.parse(mirror_svc[cloud][:ciAttributes][:mirrors])
    mirror_pkg_source_url = mirror['chocorepo']
  end

  mirror_url_nil_or_empty = mirror_pkg_source_url.nil? || mirror_pkg_source_url.empty?
  package_source_url = mirror_url_nil_or_empty ? chocolatey_package_source : mirror_pkg_source_url


  locationExe = "#{physical_path}\\#{package_name}\\#{version}\\#{pathToExe}"

  Chef::Log.info("#{locationExe} #{driverId} #{jobId}")

  params = "\"/InstallDir: \"#{locationExe}\" /DriverId:\"#{driverId}\" /JobId:#{jobId}\""

  Chef::Log.info("Using chocolatey repo #{package_source_url}")

  chocolatey_package_details.each do |package_name, package_version|
    Chef::Log.info("installing #{package_name}")
    chocolatey_package package_name do
      source package_source_url
      options "--ignore-package-exit-codes=3010 --package-parameters #{params} "
      version package_version
      action :install
    end
  end

end

else
  Chef::Log.fatal("BaaS component is not supported on #{node['platform_family']}")
end
