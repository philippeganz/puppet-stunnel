# 
# @summary 
#   Basic Stunnel config. 
#   Installs the packages and creates essential directories.
# 
# @param bin_name
#   Name of the stunnel executable.
# 
# @param bin_path
#   Path to the directory containing the stunnel executable.
# 
# @param cert_dir
#   Path to the directory containing the certificates.
# 
# @param config_dir
#   Path to the directory containing the configuration files.
# 
# @param log_dir
#   Path to the directory containing the output files.
# 
# @param packages
#   List of packages to install.
# 
# @param packages_ensure
#   If packages should be updated or not.
# 
# @param packages_provider
#   Provider to use to install the packages. Mandatory on Windows.
# 
# @param pid_dir
#   Path to the directory containing the pid file. 
#   Linux only.
# 
# @param user
#   User that will own the files and run the service.
# 
# @param group
#   Group that will own the files and run the service.
# 
# @example Basic usage
#   include stunnel
#   
# @author 
#   Aaron Russo
#   Stephen Hoekstra
#   Philippe Ganz
#
# @api public
#
# @since 0.0.0
# 
class stunnel (
  Optional[String]               $bin_name            = undef,
  Optional[Stdlib::Absolutepath] $bin_path            = undef,
  Optional[Stdlib::Absolutepath] $cert_dir            = undef,
  Optional[Stdlib::Absolutepath] $config_dir          = undef,
  Optional[Stdlib::Absolutepath] $log_dir             = undef,
  Optional[Array]                $packages            = undef,
  Optional[Enum[
      'present',
      'latest'
  ]]                             $packages_ensure     = undef,
  Optional[String]               $packages_provider   = undef,
  Optional[Stdlib::Absolutepath] $pid_dir             = undef,
  Optional[String]               $user                = undef,
  Optional[String]               $group               = undef,
) {
  package { $packages:
    ensure   => $packages_ensure,
    provider => $packages_provider,
  }

  $stunnel_dirs = [
    $cert_dir,
    $config_dir,
    $log_dir,
  ]

  file { $stunnel_dirs:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }
}
