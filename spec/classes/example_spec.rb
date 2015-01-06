require 'spec_helper'

describe 'gogs', :type => :class do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gogs class without any parameters on #{osfamily}" do
        let(:params) do
          { }
        end
        let(:facts) do
          {
            :osfamily => osfamily,
          }
        end
        it { is_expected.to contain_class('gogs::params') }
        it { is_expected.to contain_class('gogs::install') }
        it { is_expected.to contain_class('gogs::config') }
        it { is_expected.to contain_class('gogs::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'gogs class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}
      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
