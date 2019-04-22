az group create --location uksouth --name localterra

az storage account create --name terrastore321 --resource-group localterra --location uksouth --sku Standard_LRS

az storage container create --name terraform --account-name terrastore321

$key=(Get-AzStorageAccountKey -ResourceGroupName localterra -AccountName terrastore321).Value[0]

# Create the Kubernetes config file using the AKS module’s kube_config output
umask 022
mkdir ~/.kube
echo "$(terraform output kube_config)" > ~/.kube/config

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

kubectl get nodes