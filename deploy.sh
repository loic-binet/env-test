#deploy VM with terraform
terraform init
terraform validate
terraform plan -lock=false
terraform apply -auto-approve -lock=false
terraform plan -lock=false
terraform apply -auto-approve -lock=false

# Recovers VM IP and hostname for ansible
file="output.txt"
terraform output > $file
ip=$(echo $(sed -n '3p' $file)| cut -d\" -f 2)
user=$(echo $(sed -n '1p' $file)| cut -d\" -f 2)
host=$(echo $user"@"$ip)
echo $host > /etc/ansible/hosts
rm output.txt

# deploy App with Ansible
ansible-playbook -i /etc/ansible/hosts playbook.yml
