#!/bin/bash
sed -i 's/#master: salt/master: 127.0.0.1/g' /etc/salt/minion
#service salt-minion start
#service salt-master start
salt-master -d
salt-minion -d
echo "Sleeping 20 seconds to allow salt keys to generate..."
sleep 20 #allow keygen
echo "Begin master --> local minion key comparison..."
/root/./keys.py #compare/approve keys
tail -f /var/log/salt/minion -f /var/log/salt/master