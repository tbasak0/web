param (
    [Parameter(Mandatory=$true)]
    [string]$UrlListFilePath
)

if (-not (Test-Path -Path $UrlListFilePath)) {
    Write-Host "File not found: $UrlListFilePath"
    exit 1
}

function Fetch-Url {
    param (
        [string]$Url
    )

    try {
        $response = Invoke-WebRequest -Uri $Url -TimeoutSec 10
        Write-Host "URL: $Url -> Status code: $($response.StatusCode)"
    } catch {
        Write-Host "URL: $Url -> Failed to fetch. Error: $($_.Exception.Message)"
    }
}

while ($true) {
    Get-Content -Path $UrlListFilePath | ForEach-Object {
        Fetch-Url -Url $_
    }
}