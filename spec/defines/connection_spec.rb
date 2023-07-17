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
          it {
            is_expected.to contain_file('/etc/stunnel/puppetlabs_server.conf')
              .with({ owner: 'root', group: 'root', mode: '0664', })
              .with_content(%r{\[puppetlabs_server\]})
          }
        when 'windows'
          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\config\\puppetlabs_server.conf')
              .with({ owner: 'Administrators', group: nil, mode: '0664', })
              .with_content(%r{\[puppetlabs_server\]})
          }
        end
      end

      context 'basic parameters with title puppetlabs_server' do
        let(:params) do
          {
            'enable' => true,
            'active' => true,
            'client' => 'yes',
            'timeoutidle' => 86_400,
            'accept' => 30_000,
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
            is_expected.to contain_file('/etc/stunnel/puppetlabs_server.conf')
              .with({ owner: 'root', group: 'root', mode: '0664', })
              .with_content(%r{; Stunnel config file for puppetlabs_server})
              .with_content(%r{debug = 7})
              .with_content(%r{service = puppetlabs_server})
              .with_content(%r{foreground = yes})
              .with_content(%r{\[puppetlabs_server\]})
              .with_content(%r{client = yes})
              .with_content(%r{accept = 30000})
              .with_content(%r{connect = 123.123.123.123:443})
              .with_content(%r{CAfile = /etc/stunnel/certs/puppetlabs_server_CA.pem})
              .with_content(%r{cert = /etc/stunnel/certs/puppetlabs_server_cert.pem})
              .with_content(%r{key = /etc/stunnel/certs/puppetlabs_server.key})
              .with_content(%r{TIMEOUTidle = 86400})
            is_expected.to contain_service('stunnel-puppetlabs_server.service')
              .with({ ensure: true, enable: true })
            is_expected.to contain_systemd__manage_unit('stunnel-puppetlabs_server.service')
            is_expected.to contain_file('/etc/stunnel/certs/puppetlabs_server_CA.pem')
              .with({ owner: 'root', group: 'root', mode: '0640', })
            is_expected.to contain_file('/etc/stunnel/certs/puppetlabs_server_cert.pem')
              .with({ owner: 'root', group: 'root', mode: '0640', })
            is_expected.to contain_file('/etc/stunnel/certs/puppetlabs_server.key')
              .with({ owner: 'root', group: 'root', mode: '0600', })
          end
        when 'windows'
          it do
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\config\\puppetlabs_server.conf')
              .with({ owner: 'Administrators', group: nil, mode: '0664', })
              .with_content(%r{; Stunnel config file for puppetlabs_server})
              .with_content(%r{debug = 7})
              .with_content(%r{\[puppetlabs_server\]})
              .with_content(%r{client = yes})
              .with_content(%r{accept = 30000})
              .with_content(%r{connect = 123.123.123.123:443})
              .with_content(%r{CAfile = C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server_CA.pem})
              .with_content(%r{cert = C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server_cert.pem})
              .with_content(%r{key = C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server.key})
              .with_content(%r{TIMEOUTidle = 86400})
            is_expected.to contain_service('stunnel-puppetlabs_server')
              .with({ ensure: true, enable: true })
            is_expected.to contain_exec('Create service stunnel-puppetlabs_server')
            is_expected.to contain_file("C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server_CA.pem")
              .with({ owner: 'Administrators', group: nil, mode: '0640', })
            is_expected.to contain_file("C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server_cert.pem")
              .with({ owner: 'Administrators', group: nil, mode: '0640', })
            is_expected.to contain_file("C:\\Program Files \(x86\)\\stunnel\\certs\\puppetlabs_server.key")
              .with({ owner: 'Administrators', group: nil, mode: '0600', })
          end
        end
      end
    end
  end
end
