#!/usr/bin/env bash
set -e

# Configure host to use timezone
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html
echo "### Setting timezone to $TIMEZONE ###"
sudo tee /etc/sysconfig/clock << EOF > /dev/null
ZONE="$TIMEZONE"
UTC=true
EOF

sudo ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

# Enable NTP
sudo chkconfig ntpd on