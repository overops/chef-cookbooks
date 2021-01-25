# takipi_storage

Description
===========
OverOps analyzes your application in real-time, providing code-level insights in QA, Staging and Production. Monitor your applications, not your logs. Visit [overops.com](https://www.overops.com/) to learn more.

Installing Overops Storage daemon using Chef (Current cookbook is only for Linux!)

https://doc.overops.com/docs/hybrid-installation 

Requirements
============
Java ( >=1.8 )

Attributes
==========

Overops storage server cookbook will work using the default attributes but can be customized based on installation preferences:
```
{
  "overops": {
    "user": "overops",
    "install_path": "/opt",
    "storage_path": "/opt/takipi-storage/storage",
    "log_path": "/opt/takipi-storage/log",
  }
}
```

Usage
=====
For more information on using OverOps Storage Server: 

https://doc.overops.com/docs/install-storage-server