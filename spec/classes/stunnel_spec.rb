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

        when 'RedHat', 'Suse'
          it { is_expected.to contain_package('stunnel') }

        when 'windows'
          it { is_expected.to contain_package('stunnel').with({ provider: 'chocolatey' }) }

          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\certs')
              .with({ owner: 'Administrators', group: nil, mode: '0775' })
          }

          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\config')
              .with({ owner: 'Administrators', group: nil, mode: '0775' })
          }

          it {
            is_expected.to contain_file('C:\\Program Files (x86)\\stunnel\\log')
              .with({ owner: 'Administrators', group: nil, mode: '0775' })
          }
        end

        if os_facts[:kernel] == 'Linux'
          it {
            is_expected.to contain_file('/etc/stunnel/certs')
              .with({ owner: 'root', group: 'root', mode: '0775' })
          }

          it {
            is_expected.to contain_file('/etc/stunnel')
              .with({ owner: 'root', group: 'root', mode: '0775' })
          }

          if os_facts[:os]['family'] == 'Debian'
            it {
              is_expected.to contain_file('/var/log/stunnel4')
                .with({ owner: 'root', group: 'root', mode: '0775' })
            }
          else
            it {
              is_expected.to contain_file('/var/log/stunnel')
                .with({ owner: 'root', group: 'root', mode: '0775' })
            }
          end

          it {
            is_expected.to contain_file('/var/run/stunnel')
              .with({ owner: 'root', group: 'root', mode: '0775' })
          }

          it {
            is_expected.to contain_file('/var/run/stunnel//run')
              .with({ ensure: 'directory', owner: 'root', group: 'root', mode: '0755' })
          }
        end
      end

      if os_facts[:kernel] == 'Linux'
        context 'with manage_selinux => true' do
          let(:params) { { manage_selinux: true, chroot_enable: true } }

          if os_facts.dig(:os, 'selinux', 'enabled')
            it { is_expected.to contain_selinux__fcontext('/etc/stunnel/certs(/.*)?').with_seltype('stunnel_etc_t') }
            it { is_expected.to contain_selinux__fcontext('/etc/stunnel(/.*)?').with_seltype('stunnel_etc_t') }

            if os_facts[:os]['family'] == 'Debian'
              it { is_expected.to contain_selinux__fcontext('/var/log/stunnel4(/.*)?').with_seltype('stunnel_log_t') }
            else
              it { is_expected.to contain_selinux__fcontext('/var/log/stunnel(/.*)?').with_seltype('stunnel_log_t') }
            end
            it { is_expected.to contain_selinux__fcontext('/var/run/stunnel(/.*)?').with_seltype('stunnel_var_run_t') }
          else
            it { is_expected.not_to contain_selinux__fcontext('/etc/stunnel/certs(/.*)?') }
          end
        end
      end
    end
  end
end
