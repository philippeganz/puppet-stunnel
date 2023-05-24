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
# @param pid_dir
#   Path to the directory containing the pid file. 
#   Linux only.
# 
# @param service_init_system
#   System service responsible to launch the stunnel service.
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
  Optional[Stdlib::Absolutepath] $pid_dir             = undef,
  Optional[String]               $service_init_system = undef,
  Optional[String]               $user                = undef,
  Optional[String]               $group               = undef,
) {
  ensure_packages( $packages )

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
