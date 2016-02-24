#!/bin/bash

echo "Create a token"
/opt/puppetlabs/puppet/bin/curl -k -X POST -H 'Content-Type: application/json' \
	-d '{"login": "deploy", "password": "puppetlabs", "lifetime": "0"}' \
	https://`facter fqdn`:4433/rbac-api/v1/auth/token \
	| /opt/puppetlabs/puppet/bin/ruby -e 'require "json"; puts JSON.load(STDIN.read)["token"]' \
	> /etc/puppetlabs/puppetserver/.puppetlabs/deploy_token

echo "Invoking a deployment... "
# -w 'response: %{http_code} \n'
curl -v -k -X POST -H 'Content-Type: application/json' \
	https://`facter fqdn`:8170/code-manager/v1/deploys?token=`cat /etc/puppetlabs/puppetserver/.puppetlabs/deploy_token` \
	-d '{"environments": ["production"], "wait": true}' | cat
