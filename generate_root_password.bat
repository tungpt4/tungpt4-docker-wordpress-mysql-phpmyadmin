@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "$randomPassword = (openssl rand -base64 24).ToString(); $envFile = Get-Content .env; $updatedEnvFile = $envFile -replace '^MYSQL_ROOT_PASSWORD=.*', ('MYSQL_ROOT_PASSWORD=' + $randomPassword); $updatedEnvFile | Set-Content .env; Write-Host 'Password updated successfully!'; Write-Host 'New password:' $randomPassword"
pause
