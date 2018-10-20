# Package Metadata Types

#### Table of Contents

1. [Description](#description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Description

This module provides Puppet types which leverage the package metadata found in certain
package management systems.

Some package management systems retain a database of metadata about installed packages.
This often includes a list of files belonging to that package, sometimes including
checksums, and sometimes including additional attributes such as the intended
file owner or permissions.

The types in this module intend to provide a way to leverage some of that metadata
though mechanisms already in Puppet to do things such as:

* Verify checksums listed in the package database match the checksums on the filesystem
* Generate "placeholder" `file` types to prevent Puppet's purging of otherwise unmanaged
  files provided by the package.
* Use owner, group, and mode permissions associated with files in the package database
  to set the associated attributes on Puppet `file` resources.

Initial support will focus on the RPM package management system, as it is well-established
and maintains a rich database of metadata on the files it manages.

## Usage

### Protect files from purging

```
package_files_protect { '/etc/cron.d': }
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

Initial support is for RPM. Minimal Deb support is planned, within the limitations
of the package system.

## Development

Contributions for bug fixes or from people with expertise in a particular package
management system welcomed. Please fill issues or PRs at
https://github.com/seanmil/package_metadata_types
