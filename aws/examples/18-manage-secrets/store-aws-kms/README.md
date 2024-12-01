To use KMS for storing secrets, follow these steps:

1. **Create a KMS key:**
    - Open the [AWS Management Console](https://aws.amazon.com/console/).
    - In the search bar, type `KMS` and select `Key Management Service`.
    - Click on `Create key`.
    - Enter a name for the key and click on `Next`.
    - Select the key administrators and key users.
    - Click on `Next`.
    - Add tags (optional) and click on `Next`.
    - Review the key policy and click on `Finish`.
    - Copy the key ID and alias for the key.

2. **Create a file with credentials:**
    ```yaml
    db_username: admin
    db_password: admin123
    ```

3. **Encrypt the file using the KMS key:**
    ```bash
    aws kms encrypt \
    --key-id 7cca3a34-037e-4af8-8fa0-620196a1ee11 \
    --region us-east-1 \
    --plaintext fileb://db_creds.yaml \
    --output text \
    --query CiphertextBlob > db_creds.yaml.encrypted
    ```
