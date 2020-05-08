#! /bin/bash

eval $(envkey-source -f $ATLANTIS_ENVKEY)
eval $(envkey-source -f $AWS_ENVKEY)

mkdir /home/atlantis/.ssh
echo -e "$SSH_KEY" > /home/atlantis/.ssh/id_rsa
chown -R atlantis:atlantis /home/atlantis/.ssh
chmod -R 700 /home/atlantis/.ssh

exec docker-entrypoint.sh $@
