require 'vagrant/errors'
require 'oscar'
require 'vagrant-hosts'
require 'pe_build/version'
require 'config_builder/version'

module PuppetDebuggingKit
  module PluginChecks
    class DebugKitBadVersion < Vagrant::Errors::VagrantError
      def initialize(plugin, required, actual)
        @error_message = "Outdated debugging kit dependency: #{plugin}\nMinimum required version is: #{required}\nInstalled version is: #{actual}\nTry running: vagrant plugin update"

        super @error_message
      end

      def error_message; @error_message; end
    end

    REQUIRED_HOSTS          = Gem::Version.new('2.6.0')
    REQUIRED_OSCAR          = Gem::Version.new('0.4.0')
    REQUIRED_PEBUILD        = Gem::Version.new('0.13.0')
    REQUIRED_CONFIGBUILD    = Gem::Version.new('0.15.0')

    # Performs sanity checks on required plugins.
    def self.run
      vagrant_version        = Gem::Version.new(Vagrant::VERSION)
      oscar_version          = Gem::Version.new(Oscar::VERSION)
      hosts_version          = Gem::Version.new(VagrantHosts::VERSION)
      pebuild_version        = Gem::Version.new(PEBuild::VERSION)
      configbuild_version    = Gem::Version.new(ConfigBuilder::VERSION)

      if oscar_version < REQUIRED_OSCAR
        raise DebugKitBadVersion.new('oscar', REQUIRED_OSCAR, oscar_version)
      end

      if pebuild_version < REQUIRED_PEBUILD
        raise DebugKitBadVersion.new('vagrant-pe_build', REQUIRED_PEBUILD, pebuild_version)
      end

      if configbuild_version < REQUIRED_CONFIGBUILD
        raise DebugKitBadVersion.new('vagrant-config_builder', REQUIRED_CONFIGBUILD, configbuild_version)
      end

      if vagrant_version >= Gem::Version.new('1.5.0') && hosts_version < REQUIRED_HOSTS
        raise DebugKitBadVersion.new('vagrant-hosts', REQUIRED_HOSTS, hosts_version)
      end
    end
  end
end
