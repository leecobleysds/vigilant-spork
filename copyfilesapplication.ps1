# Define variables
$sourcePath = "\\sageserver.cloudad.sdslimited.com\Sage\Installers\Sage 200 Client\manual\application"  # The UNC path of the folder on the file server
$destinationPath = "C:\Program Files (x86)"        # The local path where you want to copy the contents
$username = "sageserver\sageshareuser"              # The username to access the file server
$password = "Ucsq3928Ucsq3928"                     # The password for the username

# Create a secure string for the password
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Create a PSCredential object
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

# Map the network drive with the specified credentials
$networkDrive = "J:"   # Choose a drive letter that's not in use
New-PSDrive -Name "TempDrive" -PSProvider FileSystem -Root $sourcePath -Credential $credential

# Check if the network drive was mapped successfully
if (Test-Path -Path "TempDrive:\") {
    # Copy the contents of the source folder to the local folder
    Copy-Item -Path "TempDrive:\*" -Destination $destinationPath -Recurse -Force

    # Remove the network drive mapping
    Remove-PSDrive -Name "TempDrive"
    
    Write-Output "Files copied successfully from $sourcePath to $destinationPath."
} else {
    Write-Error "Failed to map network drive $sourcePath."
}
