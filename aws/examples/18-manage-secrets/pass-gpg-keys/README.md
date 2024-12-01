# Pass Utility
The `pass` utility is a password manager that stores, retrieves, generates, and synchronizes passwords securely using GPG encryption. It is a command-line utility that is easy to use and can be integrated with other tools.

## Installation
To install the `pass` utility on Ubuntu, run the following command:
```bash
brew install pass
```

## Get started
**Step 1:** To start using pass utility, you need to configure it first. 
```bash
gpg --gen-key # Generate a new GPG key

Provide the following information:
- Real name: Your Name
- Email address:
```

**Step 2:** Add passphrase to the GPG key
Use passphrase to protect the GPG key. It can be a password or a passphrase.

**Step 3:** Using pass init command to initialize the password store. Take the GPG key ID from the output of the previous command in step 2.

Step 4: Initialize the password store
```bash
pass insert <db_username>
```

Step 4: To get the password use pass command and provide password
```bash
pass <db_username>
```

Step 5: Use this value as env variable for terraform
```bash
export TF_VAR_db_password=$(pass <db_username>)
```


To delete the password, use the following command:
```bash
pass rm <db_username>
```
