# System identification banners (/etc/issue, /etc/issue.net)

echo "Authorized access only." | sudo tee /etc/issue /etc/issue.net

# Default umask

echo "umask 027" | sudo tee -a /etc/profile
echo "umask 027" | sudo tee -a /etc/bash.bashrc

# Log martians

sudo sysctl -w net.ipv4.conf.all.log_martians=1
sudo sysctl -w net.ipv4.conf.default.log_martians=1

echo "net.ipv4.conf.all.log_martians=1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.log_martians=1" | sudo tee -a /etc/sysctl.conf

# Disable ICMP redirect sending

sudo sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -w net.ipv4.conf.default.send_redirects=0

echo "net.ipv4.conf.all.send_redirects=0" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects=0" | sudo tee -a /etc/sysctl.conf
