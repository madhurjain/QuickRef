# This script will Query the Uninstall Key on a computer specified in $computername and list the applications installed there
# $Branch contains the branch of the registry being accessed
#

# format of Computerlist.csv
# Line 1 - NameOfComputer
# Line 2 - An Actual name of a computer
#
# NameOfComputer
# localhost
# 127.0.0.1
#

$computers = Import-Csv "C:\Data\powershell\computerlist.csv"
$array = @()
foreach($pc in $computers){
    $computername=$pc.computername

    #Define the variable to hold the location of Currently Installed Programs
    $UninstallKey="SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall"

    #Create an instance of the Registry Object and open the HKLM base key
    $reg=[microsoft.win32.registrykey]::OpenRemoteBaseKey('LocalMachine',$computername)

    #Drill down into the Uninstall key using the OpenSubKey Method
    $regkey=$reg.OpenSubKey($UninstallKey)

    #Retrieve an array of string that contain all the subkey names
    $subkeys=$regkey.GetSubKeyNames()

    #Open each Subkey and use GetValue Method to return the required values for each
    foreach($key in $subkeys){

        $thisKey=$UninstallKey+"\\"+$key

        $thisSubKey=$reg.OpenSubKey($thisKey)

        $obj = New-Object PSObject
        $obj | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $computername
        $obj | Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $($thisSubKey.GetValue("DisplayName"))
        $obj | Add-Member -MemberType NoteProperty -Name "DisplayVersion" -Value $($thisSubKey.GetValue("DisplayVersion"))
        $obj | Add-Member -MemberType NoteProperty -Name "InstallLocation" -Value $($thisSubKey.GetValue("InstallLocation"))
        $obj | Add-Member -MemberType NoteProperty -Name "InstallDate" -Value $($thisSubKey.GetValue("InstallDate"))

        $obj | Add-Member -MemberType NoteProperty -Name "Publisher" -Value $($thisSubKey.GetValue("Publisher"))
        $array += $obj
    }

}
$array | Where-Object { $_.DisplayName } | select ComputerName, DisplayName, DisplayVersion, Publisher , InstallDate, InstallLocation| ft -auto
echo "==================================================================================================================="


