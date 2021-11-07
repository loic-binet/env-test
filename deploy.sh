sudo terraform validate
sudo terraform init
sudo terraform plan -lock=false
sudo terraform apply -auto-approve -lock=false
sudo terraform plan -lock=false
sudo terraform apply -auto-approve -lock=false

file="output.txt"
sudo terraform output > $file

ip=$(echo $(sed -n '3p' $file)| cut -d\" -f 2)
user=$(echo $(sed -n '1p' $file)| cut -d\" -f 2)
host=$(echo $user"@"$ip)

echo $host > /etc/ansible/hosts
rm output.txt

sudo ansible-playbook -i /etc/ansible/hosts playbook.yml
