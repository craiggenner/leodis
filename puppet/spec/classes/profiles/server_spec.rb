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
  it { should contain_class('leodis::profiles::server') }
  it { should contain_class('apache') }
  it { should contain_Apache__Listen(80) }
  it { should contain_apache__vhost('leodis.ac.uk').with_port('80').with_servername('www.leodis.ac.uk').with_serveraliases(['leodis.ac.uk','leodis.co.uk','www.leodis.co.uk','leodis.net','www.leodis.net']).with_docroot('/var/www').with_proxy_pass('{"path"=>"/", "url"=>"http://localhost:1337/", "reverse_urls"=>["http://localhost:1337/"]}') }
end
