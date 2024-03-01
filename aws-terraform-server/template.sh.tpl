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
    <title>Document</title>
</head>
<style>
    body {
        background-color: blue;
        color: gold;
        font-size: 48px;
        text-align: center;
        margin-top: 200px;
        font-weight: bold;
    }
</style>
<body>
    <h1>Terraform is Awesome</h1>
	<p>Deployed by Terraform</p>
	<p>Owner: ${f_name} ${l_name} ${age} ${email}</p> <br>
	
	%{ for x in friends ~}
	Hello to ${x} from ${f_name} ${l_name} <br>
	%{ endfor ~}

</body>
</html>
EOF'

