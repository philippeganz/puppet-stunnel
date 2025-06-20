# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      context 'empty parameters' do
        case os_facts[:os]['family']
        when 'Debian'
          it { is_expected.to contain_package('stunnel4') }
          it { is_expected.to contain_package('lsb-base') }
        when 'RedHat'
          it { is_expected.to contain_package('stunnel') }
          if os_facts[:os]['release']['major'] != '9'
            it { is_expected.to contain_package('redhat-lsb') }
          end
        when 'Suse'
          it { is_expected.to contain_package('stunnel') }
        when 'windows'
          it { is_expected.to contain_package('stunnel').with({ provider: 'chocolatey', }) }
          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\certs')
              .with({ owner: 'Administrators', group: nil, mode: '0775', })
          }
          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\config')
              .with({ owner: 'Administrators', group: nil, mode: '0775', })
          }
          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\log')
              .with({ owner: 'Administrators', group: nil, mode: '0775', })
          }
        end
        if os_facts[:kernel] == 'Linux'
          it {
            is_expected.to contain_file('/etc/stunnel/certs')
              .with({ owner: 'root', group: 'root', mode: '0775', })
          }
          it {
            is_expected.to contain_file('/etc/stunnel')
              .with({ owner: 'root', group: 'root', mode: '0775', })
          }
          if os_facts[:os]['family'] == 'Debian'
            it {
              is_expected.to contain_file('/var/log/stunnel4')
                .with({ owner: 'root', group: 'root', mode: '0775', })
            }
          else
            it {
              is_expected.to contain_file('/var/log/stunnel')
                .with({ owner: 'root', group: 'root', mode: '0775', })
            }
          end
        end
      end
    end
  end
end
