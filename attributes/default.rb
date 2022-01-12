#
# Cookbook:: waypoint_server
# Attributes::default
#

default['waypoint_server']['codename'] = (node['lsb'] || {})['codename']
default['waypoint_server']['db_path'] = '/var/run/waypoint'
default['waypoint_server']['waypoint_bootstrap_out'] = nil
