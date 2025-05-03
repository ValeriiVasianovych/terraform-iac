#!/bin/bash

sudo apt-get update
sudo apt-get install -y nginx
suro rm -rf /var/www/html/index.html
sudo bash -c 'cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stuff</title>
</head>
<style>
    body {
        background-color: red;
        color: white;
        font-size: 48px;
        text-align: center;
        margin-top: 200px;
        font-weight: bold;
    }
</style>
<body>
    <h1>DevOps Team</h1>
	<p>Deployed by Terraform</p>
	<p>Owner: ${f_name} ${l_name} Age: ${age}</p>
    <p>${f_name} ${l_name} personal Email: ${email}</p><br>
	
	%{ for x in team ~}
	Employers in our team ${f_name}:<br>
    <p>${x} and ${x}</p>
	%{ endfor ~}
</body>
</html>
EOF

