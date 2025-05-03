#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y

PUBLIC_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS Server Created with Terraform</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: green;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 50px 0;
            text-align: center;
        }
        h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            line-height: 1.6;
        }
        .ip-address {
            font-size: 24px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>AWS Server Created with Terraform</h1>
        <p>Congratulations! You have successfully created a server using Terraform on AWS.</p>
        <p>This server is now running nginx and serving this webpage.</p>
        <p>Your server's static IP address is:</p>
        <div class="ip-address">
           <p>$PUBLIC_IP</p>
        </div>
    </div>
</body>
</html>
EOF

sudo nginx -t
sudo service nginx start


