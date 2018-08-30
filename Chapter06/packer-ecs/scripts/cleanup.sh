#!/usr/bin/env bash
echo "### Performing final clean-up tasks ###"
sudo stop ecs
sudo docker system prune -f -a
sudo service docker stop
sudo chkconfig docker off
sudo rm -rf /var/log/docker /var/log/ecs/*