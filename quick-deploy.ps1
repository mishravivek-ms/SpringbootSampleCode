# Quick Azure Deployment Script for Spring Boot
# Usage: .\quick-deploy.ps1 -AppName "your-app-name" -ResourceGroup "your-rg-name"

param(
    [Parameter(Mandatory=$true)]
    [string]$AppName,
    
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroup,
    
    [Parameter(Mandatory=$false)]
    [string]$Location = "East US"
)

Write-Host "Quick deploying $AppName to Azure..." -ForegroundColor Green

# Build the app
Write-Host "Building application..." -ForegroundColor Yellow
mvn clean package -DskipTests

# Create resources and deploy
az group create --name $ResourceGroup --location $Location
az appservice plan create --name "$AppName-plan" --resource-group $ResourceGroup --sku B1 --is-linux
az webapp create --name $AppName --resource-group $ResourceGroup --plan "$AppName-plan" --runtime "JAVA:17-java17"
az webapp config appsettings set --resource-group $ResourceGroup --name $AppName --settings WEBSITES_PORT=8080

# Deploy JAR
$jarFile = Get-ChildItem -Path "target" -Name "*.jar" -Exclude "*sources.jar" | Select-Object -First 1
az webapp deploy --resource-group $ResourceGroup --name $AppName --src-path "target/$jarFile" --type jar

Write-Host "Deployment complete! App URL: https://$AppName.azurewebsites.net" -ForegroundColor Green