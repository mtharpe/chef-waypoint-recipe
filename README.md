![Chef Validation and Testing](https://github.com/mtharpe/chef-waypoint-recipe/workflows/Chef%20Validation%20and%20Testing/badge.svg)

# Description

Installs/Configures HashiCorp Waypoint as a standaone server.

# Requirements


## Chef Client:

* chef (>= 15.0) ()

## Platform:

* ubuntu (< 16.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['waypoint_server']['db_path']` -  Defaults to `/var/run/waypoint`.
* `node['waypoint_server']['waypoint_bootstrap_out']` -  Defaults to `nil`.

# Recipes

* waypoint_server::default

# License and Maintainer

Maintainer:: Michael Tharpe (<mtharpe@noemail.not>)

Source:: https://github.com/mtharpe/chef-waypoint-recipe

Issues:: https://github.com/mtharpe/chef-waypoint-recipe/issues

License:: Apache-2.0
