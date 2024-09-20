# Define the DNS suffix to be added
$dnsSuffix = "cloudad.sdslimited.com"

# Get the network adapter(s)
$networkAdapters = Get-WmiObject -Query "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True"

# Loop through each adapter and set the DNS suffix
foreach ($adapter in $networkAdapters) {
    $adapter.SetDNSDomain($dnsSuffix)
}

# Confirmation message
Write-Host "DNS suffix has been set to $dnsSuffix"
