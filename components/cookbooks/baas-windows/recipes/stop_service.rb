 cloud = node.workorder.cloud.ciName
if node[:workorder][:services].has_key?('dotnet-platform')
    if node[:workorder][:services]["dotnet-platform"][cloud]['ciAttributes']['baas_package_details'].has_key?('baasdriver')
        windows_service_name = "baasdriver"

        windowsservice windows_service_name do
                action :stop
        end
    end
end
