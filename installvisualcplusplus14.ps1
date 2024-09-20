# Define variables
$vcRedistUrl = "https://aka.ms/vs/16/release/vc_redist.x86.exe"  # URL for Visual C++ Redistributable 2015-2022 x86
$installerPath = "$env:TEMP\vc_redist.x86.exe"  # Path where the installer will be downloaded
$installerArgs = "/quiet /norestart"  # Arguments for silent installation

# Function to download the installer
function Download-File {
    param (
        [string]$url,
        [string]$destination
    )
    
    try {
        Write-Output "Downloading from $url to $destination"
        Invoke-WebRequest -Uri $url -OutFile $destination -ErrorAction Stop
        Write-Output "Download completed."
    } catch {
        Write-Error "Failed to download the file. $_"
        exit 1
    }
}

# Function to install the Redistributable silently
function Install-VCRedist {
    param (
        [string]$installer
    )
    
    try {
        Write-Output "Installing $installer"
        Start-Process -FilePath $installer -ArgumentList $installerArgs -Wait -ErrorAction Stop
        Write-Output "Installation completed successfully."
    } catch {
        Write-Error "Failed to install $installer. $_"
        exit 1
    }
}

# Download the installer
Download-File -url $vcRedistUrl -destination $installerPath

# Install the Redistributable
Install-VCRedist -installer $installerPath

# Clean up
Write-Output "Cleaning up..."
Remove-Item -Path $installerPath -Force
Write-Output "Installation and cleanup completed."
