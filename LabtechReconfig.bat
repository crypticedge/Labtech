taskkill /IM ltsvc* /f /T & taskkill /IM lttray* /f

reg delete HKLM\Software\LabTech\Service\ /v ID /f

reg delete HKLM\Software\LabTech\Service\ /v MAC /f

reg delete HKLM\Software\LabTech\Service\ /v Password /f

net start LTService
net start LTSvcMon
