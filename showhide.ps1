Compare-Object -ReferenceObject `
(Get-Service | Select-Object -ExpandProperty Name | 
% { $_ -replace "_[0-9a-f]{2,8}$" })`
-DifferenceObject (gci -path hklm:\system\currentcontrolset\services | 
% { $_.Name -Replace "HKEY_LOCAL_MACHINE\\","HKLM:\" } | 
? { Get-ItemProperty -Path "$_" -name objectname -erroraction 'ignore' } | 
% { $_.substring(40) }) -PassThru | ?{$_.sideIndicator -eq "=>"}
