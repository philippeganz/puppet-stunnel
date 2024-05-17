# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com), and this project adheres to [Semantic Versioning](https://semver.org).

## [3.1.1] - 2024-05-17

### Changed

* Upgrade PDK to version 3.2.0

## [3.1.0] - 2024-05-03

### Added

* Add Puppet 8 validations

### Changed

* Add support for RHEL 9, Ubuntu 24, Debian 10, 11 & 12
* Add support for Puppet 8
* Upgrade to PDK 3.0.1

### Removed

* Drop support for Debian 7 & 8

### Fixed

* Services are now correctly notified on cert changes
* Ensure absent now correctly removes the service on linux

## [3.0.1] - 2023-07-17

### Fixed

* New release for Puppet Forge

## [3.0.0] - 2023-07-14

### Added

* Support for Windows platform
* Puppet 7 support
* Hiera 5 data
* PDK stack for syntax validation and unit testing

### Changed

* Stunnel class has a new interface to tune configuration
* Tun define has been renamed to connection with following new features
  * New interface
  * OS service management
  * Certificate as content or path
* Stunnel config template has been rewritten in epp

### Removed

* Certificate concatenation functionnality
* Config class has been moved to init class
* Data class has been moved to hiera 5 data
* Install class has been moved to init class

## [2.2.0] - 2016-04-08

* stunnel::tun options parameter now handles an array for multiple options (mjs510)
* support uninstalling stunnel::tun resources (mjs510)
* update documentation to show disabling of SSLv3 by default (mjs510)
* fix: make cert param optional if client == true (mjs510)
* fix: actually use a custom stunnel::tun template if provided (albustax)
* fix: anchor regex pattern validating failover param (mjs510)

## [2.1.1] - 2015-02-19

* stop testing puppet 3.3 and 3.4, test 3.6 and 3.7 (with and w/o future parser)
* fix syntax error in metadata.json causing puppet to fail

## [2.1.0] - 2015-02-19

* only install lsb-base on debian based systems (kronos-pbrideau)
* allow management of tunnel service (kronos-pbrideau)
* add failover support (shoekstra)
* only fill in "options" config key if present (mighq)
* preserve order of options hash to prevent unnecessary changes (mighq)
* add support for global_opts (choffee)
* add native support for CAFile option per-tunnel

## [2.0.0] - 2014-09-17

* convert string representations of booleans into valid booleans (#13,14) (fgouteroux)
* sort options in the tun file to prevent constant puppet change notifications (choffee)

## [1.2.0] - 2014-05-08

* match stunnel defaults w/debug=5 (#8)
* add parameter to specify location of output (logging) (#8)
* add global_opts and service_opts parameters to stunnel::tun to allow
  specifying additional global and service parameters (#8)
* bugfix: properly implement timeoutidle (#9)

## [1.1.1] - 2014-03-31

* issue #6 : improved README documentation (ross-williams)

## [1.1.0] - 2014-03-20

* issue #5 : add parameter to setup client tunnels

## [1.0.1] - 2014-03-17

* Ensure lsb is installed
* bugfix: we weren't installing the right package on Debian systems

## [1.0.0] - 2013-08-26

* Debian/Ubuntu support (yvigara)

## [0.0.2] - 2013-08-16

* Added initscript for each tunnel
* moved away from multi-services per tunnel
* moar examples!

## [0.0.1] - 2013-08-12

* Initial Release
