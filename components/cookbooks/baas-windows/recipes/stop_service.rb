 cloud = node.workorder.cloud.ciName
if node[:workorder][:services].has_key?('dotnet-platform')
    chocolatey_package_details = JSON.parse(node[:workorder][:services]["dotnet-platform"][cloud]['ciAttributes']['baas_package_details'])

    Chef::Log.info(node[:workorder][:services]["dotnet-platform"][cloud]['ciAttributes']['baas_package_details'])
    if (chocolatey_package_details.has_key?('baasdriver'))
        windows_service_name = "baasdriver"

        windows_service windows_service_name do
                action :stop
        end
    end
end
