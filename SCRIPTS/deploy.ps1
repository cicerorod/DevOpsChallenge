$location = "BrazilSouth"
$resourceGroup = "RG-CiceroRodDevOpsChallenge"
$planName="Plan-CiceroRodDevOpsChallenge"
$appName="App-CiceroRodDevOpsChallenge"
$gitrepo="https://github.com/cicerorod/DevOpsChallenge"


echo "Passo 1/5 -> Criando resource group"
# create a resource group
az group create -l $location -n $resourceGroup


echo "Passo 2/5 -> Criando App Service plan"
# create an app service plan
az appservice plan create -n $planName -g $resourceGroup -l $location --sku FREE


echo "Passo 3/5 -> Criando web app"
# create a web app
az webapp create -n $appName -g $resourceGroup --plan $planName


echo "Passo 4/5 -> Deploy do Site"
# deploy from GitHub
az webapp deployment source config -n $appName -g $resourceGroup `
    --repo-url $gitrepo --branch master --manual-integration

echo "Passo 5/5 -> Acessando o Site. Aguarde..."
# launch the website in a browser
$site = az webapp show -n $appName -g $resourceGroup --query "defaultHostName" -o tsv
Start-Process https://$site

echo ""
echo ""
echo ""
echo "Pronto. Deploy realizado com sucesso!"
echo ""
echo ""
echo ""



#az group delete --name $resourceGroup -F