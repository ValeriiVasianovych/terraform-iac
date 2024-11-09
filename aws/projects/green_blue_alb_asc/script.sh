#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PRIVATE_IP=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Green Blue Deployment ALB ASC page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #2f74c0, #00bfb3);
            color: white;
            text-align: center;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.2em;
            margin-bottom: 40px;
        }
    </style>
</head>

<body>
    <div>
        <h1>Green Blue Deployment ALB ASC page</h1>
        <p>This is an example of a Green Blue Deployment page.</p>
        <p>Current IP: $PRIVATE_IP</p>
    </div>
</body>
</html>
EOF

sudo systemctl enable nginx
sudo systemctl start nginx
