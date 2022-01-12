#
# Cookbook:: waypoint_server
# Recipe:: default
#

execute 'setup_apt_key' do
  command 'curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -'
  action :run
  not_if 'apt-key list |grep HashiCorp'
end

apt_repository 'hashicorp' do
  uri 'https://apt.releases.hashicorp.com'
  distribution node['waypoint_server']['codename']
  components   ['main']
  keyserver 'apt.releases.hashicorp.com/gpg'
  action :add
end

package 'waypoint' do
  action :install
  not_if 'dpkg -l |grep waypoint'
end

template '/etc/systemd/system/waypoint.service' do
  source 'waypoint.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :restart, 'service[waypoint]', :immediately
  notifies :run, 'execute[bootstrap_waypoint]', :delayed
end

service 'waypoint' do
  action [:enable, :start]
  supports status: true
end

execute 'bootstrap_waypoint' do
  command 'waypoint server bootstrap -server-addr=127.0.0.1:9701 -server-tls-skip-verify > /var/run/waypoint.out'
  action :nothing
  notifies :run, 'ruby_block[waypoint_auth]', :delayed
end

ruby_block 'waypoint_auth' do
  only_if { ::File.exist?('/var/run/waypoint.out') }
  block do
    print "\n"
    print "  * Waypoint Auth Token: \n      - #{File.read('/var/run/waypoint.out')}"
  end
end
