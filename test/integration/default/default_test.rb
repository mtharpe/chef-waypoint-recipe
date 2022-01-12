# InSpec test for recipe waypoint_server::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe file('/etc/apt/sources.list.d/hashicorp.list') do
  it { should exist }
end

describe package('waypoint') do
  it { should be_installed }
end

describe file('/etc/systemd/system/waypoint.service') do
  it { should exist }
end

describe service('waypoint') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/run/waypoint.out') do
  it { should exist }
end

%w(9701 9702).each do |ports|
  describe port(ports) do
    it { should be_listening }
    its('processes') { should include 'waypoint' }
  end
end
