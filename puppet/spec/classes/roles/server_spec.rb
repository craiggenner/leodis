require 'spec_helper'

describe 'leodis::profiles::server', :type => 'class' do
  let(:facts) { {
    :osfamily               => 'Debian',
    :lsbdistid              => 'ubuntu',
    :lsbdistcodename        => 'xenial',
    :lsbmajdistrelease      => '14',
    :operatingsystem        => 'Ubuntu',
    :operatingsystemrelease => '14.04',
    :concat_basedir         => '/tmp',
    :processorcount         => '1',
  } }
  it { should compile.with_all_deps }
  it { should contain_class('leodis::roles::server') }
  it { should contain_class('leodis::profiles::server') }
end
