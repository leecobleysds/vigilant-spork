# Define variables
$vcRedistUrl_x86 = "https://aka.ms/highdpimfc2013x86enu"  # URL for Visual C++ Redistributable 2013 x86
$installerPath_x86 = "$env:TEMP\vc_redist_x86.exe"  # Path where the x86 installer will be downloaded
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
        Write-Error "Failed to download the file from $url. $_"
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

# Download the installers
Download-File -url $vcRedistUrl_x86 -destination $installerPath_x86

# Install the Redistributables
Install-VCRedist -installer $installerPath_x86

# Clean up
Write-Output "Cleaning up..."
Remove-Item -Path $installerPath_x86 -Force
Write-Output "Installation and cleanup completed."
