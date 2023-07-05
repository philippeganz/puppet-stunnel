# Changelog

All notable changes to this project will be documented in this file.

## 2016-04-08 Aaron Russo <arusso@berkeley.edu> - 2.2.0

* stunnel::tun options parameter now handles an array for multiple options (mjs510)
* support uninstalling stunnel::tun resources (mjs510)
* update documentation to show disabling of SSLv3 by default (mjs510)
* fix: make cert param optional if client == true (mjs510)
* fix: actually use a custom stunnel::tun template if provided (albustax)
* fix: anchor regex pattern validating failover param (mjs510)

## 2015-02-19 Aaron Russo <arusso@berkeley.edu> - 2.1.1

* stop testing puppet 3.3 and 3.4, test 3.6 and 3.7 (with and w/o future parser)
* fix syntax error in metadata.json causing puppet to fail

## 2015-02-19 Aaron Russo <arusso@berkeley.edu> - 2.1.0

* only install lsb-base on debian based systems (kronos-pbrideau)
* allow management of tunnel service (kronos-pbrideau)
* add failover support (shoekstra)
* only fill in "options" config key if present (mighq)
* preserve order of options hash to prevent unnecessary changes (mighq)
* add support for global_opts (choffee)
* add native support for CAFile option per-tunnel

## 2014-09-17 Aaron Russo <arusso@berkeley.edu> - 2.0.0

* convert string representations of booleans into valid booleans (#13,14) (fgouteroux)
* sort options in the tun file to prevent constant puppet change notifications (choffee)

## 2014-05-08 Aaron Russo <arusso@berkeley.edu> - 1.2.0

* match stunnel defaults w/debug=5 (#8)
* add parameter to specify location of output (logging) (#8)
* add global_opts and service_opts parameters to stunnel::tun to allow
  specifying additional global and service parameters (#8)
* bugfix: properly implement timeoutidle (#9)

## 2014-03-31 Aaron Russo <arusso@berkeley.edu> - 1.1.1

* issue #6 : improved README documentation (ross-williams)

## 2014-03-20 Aaron Russo <arusso@berkeley.edu> - 1.1.0

* issue #5 : add parameter to setup client tunnels

## 2014-03-17 Aaron Russo <arusso@berkeley.edu> - 1.0.1

* Ensure lsb is installed
* bugfix: we weren't installing the right package on Debian systems

## 2013-08-26 Aaron Russo <arusso@berkeley.edu> - 1.0.0

* Debian/Ubuntu support (yvigara)

## 2013-08-16 Aaron Russo <arusso@berkeley.edu> - 0.0.2

* Added initscript for each tunnel
* moved away from multi-services per tunnel
* moar examples!

## 2013-08-12 Aaron Russo <arusso@berkeley.edu> - 0.0.1

* Initial Release
