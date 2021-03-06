class php (
  $packages = [
    'php5',
    'php5-cli',
    'php5-common',
    'php5-mysql',
    'php5-gd',
    'php5-curl',
    'php5-dev',
    'php5-mcrypt',
    'php-pear',
    'build-essential',
    'php5-sqlite',
    'libapache2-mod-php5',
    'php-apc',
    'php5-intl'
  ],
  $conf_files = [
    'apache2/php.ini',
    'cli/php.ini',
    'conf.d/curl.ini',
    'conf.d/gd.ini',
    'conf.d/memcache.ini',
    'conf.d/mysqli.ini',
    'conf.d/mysql.ini',
    'conf.d/pdo.ini',
    'conf.d/pdo_mysql.ini',
    'conf.d/security',
    'conf.d/uploadprogress.ini',
  ],
  $pecl_packages = [
    'uploadprogress',
  ],
  $development = true,
){

 package { $packages:
    ensure => installed,
  }

 php::pecl_package { $pecl_packages: }
 
 if $development {
    php::pecl_package { "xdebug":}
    php::conf_file { ["conf.d/dev.ini"]:}
 }
 
 php::conf_file { $conf_files:
    require => Package['php5']
 }
 Package { require => Exec['apt-get update']} 
}