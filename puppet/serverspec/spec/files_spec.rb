require "spec_helper"

describe file('/etc/apache2/') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/apache2/sites-available/25-leodis.ac.uk.conf') do
  it { should exist }
  it { should be_file }
  it { should contain 'VirtualHost *:80' }
  it { should contain 'ServerName www.leodis.ac.uk' }
  it { should contain 'ServerAlias leodis.ac.uk' }
  it { should contain 'ServerAlias leodis.co.uk' }
  it { should contain 'ServerAlias www.leodis.co.uk' }
  it { should contain 'ServerAlias leodis.net' }
  it { should contain 'ServerAlias www.leodis.net' }
  it { should contain 'ProxyPass / http://localhost:1337/' }
  it { should contain 'ProxyPassReverse / http://localhost:1337/' }
end

describe file('/etc/apache2/sites-enabled/25-leodis.ac.uk.conf') do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to '/etc/apache2/sites-available/25-leodis.ac.uk.conf' }
end
