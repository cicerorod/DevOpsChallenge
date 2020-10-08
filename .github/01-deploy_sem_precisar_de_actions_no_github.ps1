####################################################################
#                                                                  #
#                                                                  #
# Este script automatiza todo o processo de criação de recursos    #
# para implantação da aplicação e também cria o processo de CI/CD  #
# no Azure sem ter a necessidade de criar Actions no GitHub        #
#                                                                  #
#                                                                  #
# Passos:                                                          #   
# 1-> Criação do resource group                                    #   
# 2-> Criação do app service plan                                  #
# 3-> Criação do web app                                           #   
# 4-> Primeiro deploy da aplicação e Criação do processo de CI/CD  #
# 5-> Abre o site no browser                                       #
####################################################################


$location = "BrazilSouth"
$resourceGroup = "RG-DevOpsChallenge"
$planName="Plan-DevOpsChallenge"
$appName="App-DevOpsChallenge"
$gitrepo="https://github.com/cicerorod/DevOpsChallenge"


$token="135a9f07f202f2276533b44ccb9bd41d9718921d"


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
#az webapp deployment source config -n $appName -g $resourceGroup `
#     --repo-url $gitrepo --branch master --manual-integration

az webapp deployment source config -n $appName -g $resourceGroup `
     --repo-url $gitrepo --branch master --git-token $token


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


# Utilizar este comando para limpar todos os recursos criados para a aplicação
#az group delete --name $resourceGroup