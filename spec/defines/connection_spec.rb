# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel::connection' do

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:title) { 'puppetlabs_server' }

      context 'empty parameters with title puppetlabs_server' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('stunnel') }
        case os_facts[:kernel]
        when 'Linux'
          it { is_expected.to contain_file('/etc/stunnel/puppetlabs_server.conf').with({:owner => 'root', :group => 'root', :mode => '0664', }).with_content(/\[puppetlabs_server\]/)}
        when 'windows'
          it { is_expected.to contain_file("C:\\Program Files (x86)\\stunnel\\config\\puppetlabs_server.conf").with({:owner => 'Administrators', :group => nil, :mode => '0664', }).with_content(/\[puppetlabs_server\]/)}
        end
      end

      context 'basic parameters with title puppetlabs_server' do
        let(:params) do {
          'enable' => true,
          'active' => true,
          'client' => 'yes',
          'timeoutidle' => 86400,
          'accept' => 30000,
          'connect' => '123.123.123.123:443',
          'ca_file_content' => 'test ca content',
          'cert_file_content' => 'test cert content',
          'key_file_content' => 'test key content',
          'debug_level' => 7,
        }
        end
        it { is_expected.to compile.with_all_deps }
        case os_facts[:kernel]
        when 'Linux'
          it do 
            is_expected.to contain_file('/etc/stunnel/puppetlabs_server.conf').with({:owner => 'root', :group => 'root', :mode => '0664', })
              .with_content(/; Stunnel config file for puppetlabs_server/)
              .with_content(/debug = 7/)
              .with_content(/service = puppetlabs_server/)
              .with_content(/foreground = yes/)
              .with_content(/\[puppetlabs_server\]/)
              .with_content(/client = yes/)
              .with_content(/accept = 30000/)
              .with_content(/connect = 123.123.123.123:443/)
              .with_content(/CAfile = \/etc\/stunnel\/certs\/puppetlabs_server_CA.pem/)
              .with_content(/cert = \/etc\/stunnel\/certs\/puppetlabs_server_cert.pem/)
              .with_content(/key = \/etc\/stunnel\/certs\/puppetlabs_server.key/)
              .with_content(/TIMEOUTidle = 86400/)
          end
        when 'windows'
          it do 
            is_expected.to contain_file("C:\\Program Files (x86)\\stunnel\\config\\puppetlabs_server.conf").with({:owner => 'Administrators', :group => nil, :mode => '0664', })
              .with_content(/; Stunnel config file for puppetlabs_server/)
              .with_content(/debug = 7/)
              .with_content(/\[puppetlabs_server\]/)
              .with_content(/client = yes/)
              .with_content(/accept = 30000/)
              .with_content(/connect = 123.123.123.123:443/)
              .with_content(/CAfile = C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server_CA.pem/)
              .with_content(/cert = C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server_cert.pem/)
              .with_content(/key = C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server.key/)
              .with_content(/TIMEOUTidle = 86400/)
          end
        end
      end
    end
  end
end
