windows_service_name = "Walmart.Platform.BAASDriver"

windowsservice windows_service_name do
  action :start
  arguments         service_arguments
  wait_for_status   30
end
