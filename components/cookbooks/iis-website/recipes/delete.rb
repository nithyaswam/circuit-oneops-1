site = node['iis-website']
binding_type = site.binding_type
site_name = node.workorder.box.ciName

iis_web_site site_name do
  action [:delete]
end

if binding_type == 'https' && site.cert_auto_provision == 'true'
  cloud_name = node[:workorder][:cloud][:ciName]
  provider = ""
  cert_service = node[:workorder][:services][:certificate]
  Chef::Log.info "Certificate Service - #{cloud_name} and  #{cert_service}"
  if !cert_service.nil? && !cert_service[cloud_name].nil?
    provider = node[:workorder][:services][:certificate][cloud_name][:ciClassName].gsub("cloud.service.","").downcase.split(".").last
  else
    Chef::Log.error("Certificate cloud service not defined for this cloud")
    exit 1
  end

  certificate = Hash.new
  certificate["common_name"] = site.cert_common_name
  certificate["san"] = site.cert_san
  certificate["external"] = "false"
  certificate["domain"] = site.cert_domain
  certificate["owner_email"] = site.cert_owner_email
  certificate["passphrase"] = site.cert_passphrase

  node.set[:certificate] = certificate
  include_recipe provider + "::delete_certificate"
end
