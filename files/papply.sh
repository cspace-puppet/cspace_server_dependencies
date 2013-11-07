#!/bin/sh
site="/etc/puppet/manifests/site.pp"

if [ -f $site ]; then
    sudo puppet apply $site --modulepath=/etc/puppet/modules $*
else
    echo Missing $site
fi
