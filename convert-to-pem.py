# Use to convert an x509 certificate to a properly formated .pem certificate, commonly used in SAML configuration
# To Use:
# python convert-to-pem.py
# Answer input prompts

import os
def convert_to_pem(cert_path, pem_path):
    os.listdir()
    with open(cert_path, 'r') as f:
        content = f.read()

    # Check if certificate is already in PEM format
    if "-----BEGIN CERTIFICATE-----" in content:
        print("Certificate is already in PEM format!")
        return

    pem_content = "-----BEGIN CERTIFICATE-----\n"
    # Split the certificate content into 64 character long lines as per PEM format
    pem_content += '\n'.join([content[i:i + 64] for i in range(0, len(content), 64)])
    pem_content += "\n-----END CERTIFICATE-----\n"

    with open(pem_path, 'w') as f:
        f.write(pem_content)

    print(f"Converted certificate saved to {pem_path}")


if __name__ == "__main__":
    cert_path = input('Relative path of x509.crt: ').strip()
    pem_path = input('Destination for generated certificate: ').strip()
    convert_to_pem(cert_path, pem_path)
