<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DataTrack</title>
    </head>
    <body>
        <?php
        //error_reporting(E_ALL);
        //ini_set('display_errors', 1);
		
		if( $_SERVER['HTTP_USER_AGENT'] == "b4omBYq$3n#FlMV7;A6r^kyjeZiWJd@Kt5wpUg!us&~xazfIcL-X&%rL1FOWfwapyTG5QoB:9l*;E7gbP!3eK@snYHV=^6uxzDmdJ" ){
			
			//echo $username . "<br/>";
			//echo $agentOS . "<br/>";
			//echo $ProcName . "<br/>";
			//echo $ProcPCores . "<br/>";
			//echo $ProcLCores . "<br/>";
			//echo $ProcSpeed . "<br/>";
			//echo $RAM . "<br/>";
			//echo $InetAdapter . "<br/>";
			//echo $MachType . "<br/>";
			//echo $IEVer . "<br/>";
			//echo $ChromeVer . "<br/>";
			//echo $USBHeadSet . "<br/>";
			//echo $MonitSize . "<br/>";
			//echo $WebCamAns;
			
			$username = htmlspecialchars($_GET["username"]);
            $agentOS = htmlspecialchars($_GET["os"]);
			$ProcName = htmlspecialchars($_GET["procname"]);
			$ProcPCores = htmlspecialchars($_GET["pcores"]);
			$ProcLCores = htmlspecialchars($_GET["lcores"]);
			$ProcSpeed = htmlspecialchars($_GET["procspeed"]);
			$RAM = htmlspecialchars($_GET["ram"]);
			$InetAdapter = htmlspecialchars($_GET["inetadapter"]);
			$MachType = htmlspecialchars($_GET["machtype"]);
			$IEVer = htmlspecialchars($_GET["iever"]);
			$ChromeVer = htmlspecialchars($_GET["chromever"]);
			$USBHeadSet = htmlspecialchars($_GET["usbhead"]);
			$MonitSize = htmlspecialchars($_GET["monitsize"]);
			$WebCamAns = htmlspecialchars($_GET["webcamans"]);
            $AVAnswer = htmlspecialchars($_GET["avanswer"]);
            
            if(empty($username) || empty($agentOS) || empty($ProcName) || empty($ProcPCores) || empty($ProcLCores) || empty($ProcSpeed) || empty($RAM) || empty($InetAdapter) || empty($MachType) || empty($IEVer) || empty($ChromeVer) || empty($USBHeadSet) || empty($MonitSize) || empty($WebCamAns) || empty($AVAnswer)){
                echo "Nice try. You don't belong here.";
            }else{
				

				
            $agentFile = fopen("agents/" . $username . ".txt", "w");
            fwrite($agentFile, $agentOS . "\n");
			fwrite($agentFile, $ProcName . "\n");
			fwrite($agentFile, $ProcPCores . "\n");
			fwrite($agentFile, $ProcLCores . "\n");
			fwrite($agentFile, $ProcSpeed . "\n");
			fwrite($agentFile, $RAM . "\n");
			fwrite($agentFile, $InetAdapter . "\n");
			fwrite($agentFile, $MachType . "\n");
			fwrite($agentFile, $IEVer . "\n");
			fwrite($agentFile, $ChromeVer . "\n");
			fwrite($agentFile, $USBHeadSet . "\n");
			fwrite($agentFile, $MonitSize . "\n");
			fwrite($agentFile, $WebCamAns . "\n");
            fwrite($agentFile, $AVAnswer);
            fclose($agentFile);
            }
			
		}else{
			echo "Nice try. You don't belong here.";
		}
        ?>
    </body>
</html>
