# RPM Metadata Types

#### Table of Contents

1. [Description](#description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Description

This module provides Puppet types which leverage the package metadata found in RPM.

RPM retains a database of metadata about installed packages which includes a list
of files belonging to that package, checksums, and additional attributes such
as the intended file owner or permissions.

The types in this module intend to provide a way to leverage some of that metadata
though mechanisms already in Puppet to do things such as:

* Verify checksums listed in the package database match the checksums on the filesystem
* Generate "placeholder" `file` types to prevent Puppet's purging of otherwise unmanaged
  files provided by the package.
* Use owner, group, and mode permissions associated with files in the package database
  to set the associated attributes on Puppet `file` resources.

## Usage

### Protect files from purging

```
rpm_files_protect { '/etc/cron.d': }
```

This will generate stub `file` resources to prevent purging for all files under `/etc/cron.d/*`
that are known to the package management system.

### Verify installed package integrity

```
verify_rpm { 'package': }
```

Use RPM's verify functionality to ensure that the installed package matches the package
system's expectations and raise a Puppet resource error if not.

## Limitations

Only RPM is supported. A quick look at Deb showed that it didn't seem to have many
of the capabilities of RPM in terms of package metadata.

## Development

Patches and bug reports welcomed. Please fill issues or PRs at
https://github.com/seanmil/rpm_metadata_types
