describe 'testhost.example.com', :type => 'host' do
  context "On server" do
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

    it { should contain_Class('Leodis::Roles::Server') }
    it { should contain_node('default') }
  end
end
