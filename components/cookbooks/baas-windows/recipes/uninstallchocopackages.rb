if node[:workorder][:services].has_key?('dotnet-platform')

  cloud = node.workorder.cloud.ciName
  chocolatey_package_details = JSON.parse(node[:workorder][:services]["dotnet-platform"][cloud]['ciAttributes']['baas_package_details'])

  chocolatey_package_details.each do |package_name, package_version|
    Chef::Log.info("Uninstalling #{package_name}")
    chocolatey_package package_name do

      action :uninstall
    end
  end
end
