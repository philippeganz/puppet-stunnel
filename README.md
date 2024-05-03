# stunnel

[![Puppet 7 syntax](https://github.com/philippeganz/puppet-stunnel/actions/workflows/validate.yml/badge.svg)](https://github.com/philippeganz/puppet-stunnel/actions/workflows/puppet7_validate.yml)
[![Puppet 7 unit tests](https://github.com/philippeganz/puppet-stunnel/actions/workflows/test_unit.yml/badge.svg)](https://github.com/philippeganz/puppet-stunnel/actions/workflows/puppet7_test_unit.yml)
[![Puppet 8 syntax](https://github.com/philippeganz/puppet-stunnel/actions/workflows/validate.yml/badge.svg)](https://github.com/philippeganz/puppet-stunnel/actions/workflows/puppet8_validate.yml)
[![Puppet 8 unit tests](https://github.com/philippeganz/puppet-stunnel/actions/workflows/test_unit.yml/badge.svg)](https://github.com/philippeganz/puppet-stunnel/actions/workflows/puppet8_test_unit.yml)
[![MIT License](https://img.shields.io/github/license/philippeganz/puppet-stunnel.svg)](LICENSE)

## Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with puppet-stunnel](#setup)
   * [What puppet-stunnel affects](#what-puppet-stunnel-affects)
   * [Setup requirements](#setup-requirements)
   * [Beginning with puppet-stunnel](#beginning-with-puppet-stunnel)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Module Description

This module aims to provide a wrapper around the [stunnel](https://www.stunnel.org/) software.

It helps you put in place stunnel connections with only a few lines of yaml.

It does not aim at replacing the software nor take ownership for their code.

From the creator's description :

Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code. Its architecture is optimized for security, portability, and scalability (including load-balancing), making it suitable for large deployments.

Stunnel uses the OpenSSL library for cryptography, so it supports whatever cryptographic algorithms are compiled into the library. It can benefit from the FIPS 140-2 validation of the OpenSSL FIPS Provider, as long as the building process meets the OpenSSL FIPS 140-2 Security Policy. Our latest Windows installer includes the OpenSSL FIPS Provider.

### References

* <https://www.stunnel.org/>
* <http://en.wikipedia.org/wiki/Stunnel>
* <http://en.wikipedia.org/wiki/Secure_Sockets_Layer>

## Setup

### What puppet-stunnel affects

Depending on the parameter you provide, it might affect system services, system sockets, ports, and some local configuration files for stunnel.

### Setup requirements

You need to have the Stunnel software available in your favorite package manager, e.g. Chocolatey on Windows or yum on RHEL.

### Beginning with puppet-stunnel

Simply include the module in your control-repo. This will install the necessary piece of software needed to have you up and running with stunnel on your platform.

```puppet
include stunnel
```

## Usage

All options and possibilities can be found in the [REFERENCE](REFERENCE.md) file.

### Create a client-server connection

Having following layout

(32000) Client (Dynamic range) <--> (1564) Server (27000)

The client would look like this

```puppet
include stunnel

stunnel::connection {'my_tunnel':
  active        => true,
  enable        => true,
  client        => true,
  accept        => 32000,
  connect       => 'remote_url_or_ip:1564',
  debug_level   => 5,
  log_file      => "${stunnel::log_dir}/my_tunnel.log",
}
```

and the server like this

```puppet
include stunnel

stunnel::connection {'my_tunnel':
  active        => true,
  enable        => true,
  accept        => 1564,
  connect       => 'localhost:27000',
  debug_level   => 5,
  log_file      => "${stunnel::log_dir}/my_tunnel.log",
}
```

### Create a client stunnel connecting through a proxy

Now imagine you add a proxy in the middle

(32000) Client (Dynamic range) <--> (8080) Proxy (Dynamic range) <--> (1564) Server (27000)

```puppet
include stunnel

stunnel::connection {'my_tunnel':
  active        => true,
  enable        => true,
  client        => true,
  accept        => 32000,
  protocol      => connect,
  protocol_host => 'remote_url_or_ip:1564',
  connect       => 'my_proxy:8080',
  debug_level   => 5,
  log_file      => "${stunnel::log_dir}/my_tunnel.log",
}
```

## Limitations

Support for older operating system have not been ported from arusso's version.

This module depends greatly on features implemented by the stunnel team, no warranties on those, you'll have to deal with them if something isn't working as expected.

## Development

This module has been forked from arusso (thanks a lot for your work !).

It has been ported to Puppet 7 with modern dependencies and good practices.

Please do contribute if you're missing some features or create an issue.

### Contributors

* Yann Vigara
* Ross Williams
* John Cooper
* Francois Gouteroux
* Stephen Hoekstra
* mjs510
* Olivier Fontannaud
* Philippe Ganz
