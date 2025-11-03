# Azure Spring Boot Application Deployment Script
# This script deploys a Spring Boot application to Azure App Service

param(
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    
    [Parameter(Mandatory=$true)]
    [string]$AppName,
    
    [Parameter(Mandatory=$false)]
    [string]$Location = "East US",
    
    [Parameter(Mandatory=$false)]
    [string]$AppServicePlan = "$AppName-plan",
    
    [Parameter(Mandatory=$false)]
    [string]$Sku = "B1",
    
    [Parameter(Mandatory=$false)]
    [string]$JavaVersion = "17",
    
    [Parameter(Mandatory=$false)]
    [string]$JarFile = "target/*.jar"
)

# Set error action preference
$ErrorActionPreference = "Stop"

Write-Host "Starting Azure deployment for Spring Boot application..." -ForegroundColor Green

try {
    # Check if Azure CLI is installed
    Write-Host "Checking Azure CLI installation..." -ForegroundColor Yellow
    $azVersion = az version --output tsv 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Azure CLI is not installed or not in PATH. Please install Azure CLI first."
    }
    Write-Host "Azure CLI is installed." -ForegroundColor Green

    # Login check
    Write-Host "Checking Azure login status..." -ForegroundColor Yellow
    $loginStatus = az account show --output tsv 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Not logged in to Azure. Please login..." -ForegroundColor Red
        az login
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to login to Azure"
        }
    }
    Write-Host "Successfully authenticated with Azure." -ForegroundColor Green

    # Build the application
    Write-Host "Building Spring Boot application..." -ForegroundColor Yellow
    if (Test-Path "pom.xml") {
        mvn clean package -DskipTests
        if ($LASTEXITCODE -ne 0) {
            throw "Maven build failed"
        }
    } elseif (Test-Path "build.gradle") {
        ./gradlew build -x test
        if ($LASTEXITCODE -ne 0) {
            throw "Gradle build failed"
        }
    } else {
        throw "No Maven pom.xml or Gradle build.gradle found"
    }
    Write-Host "Application built successfully." -ForegroundColor Green

    # Create resource group
    Write-Host "Creating resource group: $ResourceGroupName..." -ForegroundColor Yellow
    az group create --name $ResourceGroupName --location $Location --output table
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Resource group created or already exists." -ForegroundColor Green
    } else {
        throw "Failed to create resource group"
    }

    # Create App Service Plan
    Write-Host "Creating App Service Plan: $AppServicePlan..." -ForegroundColor Yellow
    az appservice plan create `
        --name $AppServicePlan `
        --resource-group $ResourceGroupName `
        --location $Location `
        --sku $Sku `
        --is-linux `
        --output table
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "App Service Plan created or already exists." -ForegroundColor Green
    } else {
        throw "Failed to create App Service Plan"
    }

    # Create Web App
    Write-Host "Creating Web App: $AppName..." -ForegroundColor Yellow
    az webapp create `
        --name $AppName `
        --resource-group $ResourceGroupName `
        --plan $AppServicePlan `
        --runtime "JAVA:$JavaVersion-java$JavaVersion" `
        --output table
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Web App created successfully." -ForegroundColor Green
    } else {
        throw "Failed to create Web App"
    }

    # Configure app settings for Spring Boot
    Write-Host "Configuring application settings..." -ForegroundColor Yellow
    az webapp config appsettings set `
        --resource-group $ResourceGroupName `
        --name $AppName `
        --settings WEBSITES_PORT=8080 `
        --output table

    # Find the JAR file
    $jarFiles = Get-ChildItem -Path "target" -Name "*.jar" -Exclude "*sources.jar", "*javadoc.jar" 2>$null
    if (-not $jarFiles) {
        $jarFiles = Get-ChildItem -Path "build/libs" -Name "*.jar" -Exclude "*sources.jar", "*javadoc.jar" 2>$null
    }
    
    if (-not $jarFiles) {
        throw "No JAR file found in target/ or build/libs/ directory"
    }
    
    $jarPath = if (Test-Path "target") { "target/$($jarFiles[0])" } else { "build/libs/$($jarFiles[0])" }
    Write-Host "Found JAR file: $jarPath" -ForegroundColor Green

    # Deploy the application
    Write-Host "Deploying application to Azure App Service..." -ForegroundColor Yellow
    az webapp deploy `
        --resource-group $ResourceGroupName `
        --name $AppName `
        --src-path $jarPath `
        --type jar `
        --output table
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Application deployed successfully!" -ForegroundColor Green
    } else {
        throw "Failed to deploy application"
    }

    # Get the application URL
    $appUrl = az webapp show --resource-group $ResourceGroupName --name $AppName --query "defaultHostName" --output tsv
    
    Write-Host ""
    Write-Host "=================================================" -ForegroundColor Green
    Write-Host "Deployment completed successfully!" -ForegroundColor Green
    Write-Host "Application URL: https://$appUrl" -ForegroundColor Green
    Write-Host "API Endpoint: https://$appUrl/api" -ForegroundColor Green
    Write-Host "Days Between Endpoint: https://$appUrl/api/daysBetween?startDate=2024-01-01&endDate=2024-12-31" -ForegroundColor Green
    Write-Host "=================================================" -ForegroundColor Green

} catch {
    Write-Host ""
    Write-Host "Deployment failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please check the error messages above and retry." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Deployment script completed." -ForegroundColor Green