#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Our Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #282c34;
            color: #ddd;
        }

        .container {
            width: 80%;
            margin: auto;
            text-align: center;
            padding: 50px 0;
        }

        h1 {
            font-size: 3em;
            margin-bottom: 20px;
            color: #61afef;
        }

        p {
            font-size: 1.2em;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #61afef;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #528bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to static page</h1>
		<p>This is a simple HTML file hosted on AWS EC2 instance using Terraform.</p>
    </div>
</body>
</html>
EOF

sudo nginx -t
sudo service nginx start


