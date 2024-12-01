#!/bin/bash

sudo apt update -y
sudo apt install nginx -y

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PRIVATE_IP=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome to Terraform AWS Static Site</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #1e293b, #0f172a);
      background-size: 400% 400%;
      animation: gradientBackground 15s ease infinite;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      color: #fff;
    }

    @keyframes gradientBackground {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    .card {
      background: rgba(255, 255, 255, 0.1);
      border-radius: 15px;
      box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.3);
      padding: 20px 30px;
      text-align: center;
      animation: fadeIn 1.5s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }

    h1 {
      font-size: 2.5rem;
      margin-bottom: 15px;
    }

    p {
      font-size: 1.2rem;
      margin: 0;
    }

    .highlight {
      color: #38bdf8;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>Welcome to <span class="highlight">Terraform AWS</span></h1>
    <p>Terraform Remote State Project</p>
    <p>Explore the power of <span class="highlight">Infrastructure as Code</span>.</p>
    <p>Current Private iPv4: $PRIVATE_IP</p>
    <p>Current Public iPv4: $PUBLIC_IP</p>
  </div>
</body>
</html>
EOF

sudo systemctl enable nginx
sudo systemctl start nginx