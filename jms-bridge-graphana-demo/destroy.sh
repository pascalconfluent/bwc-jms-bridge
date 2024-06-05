#!/usr/bin/env sh

# Stop Docker containers
echo "[+] Stopping Docker containers"
docker-compose -p psycopate-jms down

# Destroy Docker image
echo "[+] Destroying Docker image"
docker rmi jms-bridge

echo "[+] Destroying Confluent Cloud resources"
terraform destroy -auto-approve -var-file=values.tfvars
if [ $? -ne 0 ]; then
  echo "[-] Failed to destroy resources"
  exit 1
fi

echo "[+] Cleaning up"
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
echo "[+] Done"
