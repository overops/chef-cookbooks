#
# Cookbook:: takipi_storage
# Recipe:: default
#
# Copyright:: 2021, OverOps, All Rights Reserved.
log "welcome_message" do
    message "Running takipi_storage default recipe"
    level :info
  end

app_path = ::File.join(node["overops"]["install_path"], "takipi-storage")
jar_path = ::File.join(app_path, "lib", "takipi-storage.jar" )
settings_file = ::File.join(app_path, "storage-settings.yaml")
service_name = "takipi-storage"

# Create OverOps user
user node["overops"]["user"] do
    system true
    manage_home false
end

# Create Install Path if Needed
directory node["overops"]["install_path"] do
    owner node["overops"]["user"]
    group node["overops"]["user"]    
    action :create
    only_if {!::File.directory?(node['overops']['install_path'])}
end


# Download tar
remote_file '/tmp/takipi-storage-latest.tar.gz' do
    source 'https://app-takipi-com.s3.amazonaws.com/deploy/takipi-storage/takipi-storage-latest.tar.gz'
    mode '0755'
    action :create
end

# Unarchive
archive_file 'takipi-storage-latest.tar.gz' do
    path '/tmp/takipi-storage-latest.tar.gz'
    destination node["overops"]["install_path"]
    owner node["overops"]["user"]
    group node["overops"]["user"]
    overwrite true
    action :extract
end

# Create Storage Directory
directory node["overops"]["storage_path"] do
    owner node["overops"]["user"]
    group node["overops"]["user"]    
    action :create
end

# Create Log Directory
directory node["overops"]["log_path"] do
    owner node["overops"]["user"]
    group node["overops"]["user"]    
    action :create
end

template settings_file do
    source "settings.erb"
    mode "0644"
    owner node["overops"]["user"]
    group node["overops"]["user"]
    variables(
        storage_path: node["overops"]["storage_path"],
        log_path: node["overops"]["log_path"],
        max_used_storage_percentage: node["overops"]["max_used_storage_percentage"],
        retention_period_days: node["overops"]["retention_period_days"],
        cleanup_job_enabled: node["overops"]["cleanup_job_enabled"],
        cleanup_interval: node["overops"]["cleanup_interval"])
end

if node["overops"]["install_as_service"] == "true"
    case node["init_package"]
        when "systemd"
            template "/usr/lib/systemd/system/#{service_name}.service" do
                source "init/takipi-storage-systemd.erb"
                mode "0644"
                variables(
                    username: node["overops"]["user"],
                    java_path: node["overops"]["java_path"],
                    app_path: jar_path,
                    setting_path: settings_file)
            end
            service service_name do
                action [:enable, :start]
            end
        end
end

# Cleanup
file '/tmp/takipi-storage-latest.tar.gz' do
    action :delete
end