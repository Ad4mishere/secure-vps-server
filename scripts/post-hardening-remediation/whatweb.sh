# Edit file

sudo nano /etc/nginx/sites-enabled/default

# Add following to Port 80

# Add security headers also on redirect response
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Content-Security-Policy "default-src 'self'" always;


# Reset Nginx

sudo nginx -t
sudo systemctl reload nginx


