require 'spec_helper_acceptance'

describe 'puppet::main::settings' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include profile::iac::repository_management
        include profile::iac::java_jdk
        include profile::iac::java::alternatives

        $scriptura_server               = hiera_hash('profile::iac::scriptura::server',{})
        $scriptura_additional_packages  = hiera_hash('profile::iac::scriptura::additional_packages',{})
        create_resources('scriptura::iac::server',$scriptura_server)
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/opt/scriptura/' do
      it { is_expected.to be_directory }
    end

  end
end

