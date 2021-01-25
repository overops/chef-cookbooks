default["overops"]["user"] = 'overops'
default["overops"]["install_path"] = '/opt'
default["overops"]["storage_path"] = '/opt/takipi-storage/storage'
default["overops"]["log_path"] = '/opt/takipi-storage/log'

# Settings are described here: https://doc.overops.com/docs/storage-server-cleanup-task-to-free-up-space
default["overops"]["max_used_storage_percentage"] = '0.95'
default["overops"]["retention_period_days"] = '92'
default["overops"]["cleanup_job_enabled"] = 'true'
default["overops"]["cleanup_interval"] = '6h'

default["overops"]["install_as_service"] = 'true' 
default["overops"]["java_path"] = '/usr/bin/java'