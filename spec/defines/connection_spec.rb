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
    end
  end
end
