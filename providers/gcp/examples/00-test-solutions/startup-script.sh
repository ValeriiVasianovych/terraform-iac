#!/bin/bash

sudo apt install nginx -y

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Cloud Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #862fc0, #bf0000);
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
        <h1>This is a WebServer on Google Cloud</h1>
        <h2>Owned by: <span style="color: #ffeb3b;">$(hostname)</span></h2>
        <p>Powered by <span style="color: #ffeb3b;">Nginx</span></p>
    </div>
</body>
</html>
EOF

sudo systemctl enable nginx
sudo systemctl start nginx
