<?php include("password_protect.php"); ?>
<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <title>SpecRep Tracker</title>
    <script src="https://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
	<script src="https://use.fontawesome.com/182479f241.js"></script>

    
    <link rel="stylesheet" href="css/reset.css">

    
    <link rel="stylesheet" href="css/style.css">

    
    
    
  </head>

  <body>

  
  

    <div class="container">
          <h1 class="heading-primary" style="font-weight:bold;color:white;font-size:40px;">SPECREP TRACKER<br/>
		  
		
		  
		  
		  </h1>
		  
		  
		  
		
		
		
		  <div style="color:white;line-height:25px;font-size:13px;"><i class="fa fa-exclamation-circle" aria-hidden="true"></i> = Disqualification</div>
		  <div style="color:white;line-height:25px;font-size:13px;"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> = Warning</div>
		  <div style="color:white;line-height:25px;font-size:13px;"><i class="fa fa-wifi" aria-hidden="true"></i> = Using WiFi</div>
          <div style="color:white;line-height:25px;font-size:13px;"><i class="fa fa-usb" aria-hidden="true"></i> = USB Wifi/Eth Adapter</div>
		  <div style="margin-left:431px;margin-bottom:15px;"><a class="btn" href=".">REFRESH</a></div>
		  
          <div class="accordion">
            <dl>
			

			
			
			
		<?php
			
				
			
			
				$iterator = new GlobIterator('agents/*.txt');
				$counter = $iterator->count();
				
				$qualified = 0;
				$nonqualified = 0;
				$cpuqualified = 0;
				$ramqualified = 0;
				$wirelessocc = 0;


				
		foreach (glob("agents/*.txt") as $filename) {
			
			$agentname = basename($filename, ".txt");
			$fileContent = file($filename, FILE_IGNORE_NEW_LINES);
		
		
			
            echo '<dt>';
            echo '<a href="#accordion1" aria-expanded="false" aria-controls="accordion1" class="accordion-title accordionTitle js-accordionTrigger">';
			echo strtoupper($agentname);
			echo ' ';

			if ($fileContent[2] < 2 || $fileContent[4] < 2 || $fileContent[5] < 3 || $fileContent[10] == "No" || $fileContent[11] == "No" || $fileContent[12] == "No" || $fileContent[0] == "Windows Vista" || $fileContent[0] == "Windows XP" || $fileContent[0] == "Windows Server 2016" || $fileContent[0] == "Windows Server 2012" || $fileContent[0] == "Windows Server 2008" || $fileContent[0] == "Windows Server 2003" || strpos($fileContent[6], 'Apple') !== false) {
				
				echo '<i class="fa fa-exclamation-';
				
				if ($fileContent[2] >= 3 && $fileContent[4] < 2){
					$qualified = $qualified + 1;
					$nonqualified = $nonqualified - 1;
					echo 'triangle';
					
				}else{
					echo 'circle';
				}
				
				echo '" aria-hidden="true"></i> ';
				
			}
			
			if (strpos($fileContent[6], 'Wi-Fi') !== false || strpos($fileContent[6], 'Wireless') !== false || strpos($fileContent[6], 'WLAN') !== false || strpos($fileContent[6], 'WiFi') !== false || strpos($fileContent[6], 'Centrino') !== false || strpos($fileContent[6], '802.11') !== false || strpos($fileContent[6], 'USB') !== false) {
				
				echo '<i class="fa fa-wifi" aria-hidden="true"></i> ';
				
			}
            
            if ( strpos($fileContent[6], 'USB') !== false  ){
                echo ' <i class="fa fa-usb" aria-hidden="true"></i>';
            }
			
			echo '</a>';
            echo  '</dt>
              <dd class="accordion-content accordionItem is-collapsed" id="accordion1" aria-hidden="true">';
            echo  '<p>
			
							<span style="font-weight:bold;;">Date: '.date("F d, Y", filemtime($filename)).'</span><br/>
							<span style="font-weight:bold;">Time: '.date("H:i", filemtime($filename)).' CST</span><br/><br/>
			
			
							OperSys: <span style="font-weight:bold;';
							
							if ($fileContent[0] == "Windows Vista" || $fileContent[0] == "Windows XP" || $fileContent[0] == "Windows Server 2016" || $fileContent[0] == "Windows Server 2012" || $fileContent[0] == "Windows Server 2008" || $fileContent[0] == "Windows Server 2003"){
								
								echo 'color:red;';
								
							}
							
							echo '">'.$fileContent[0].'</span><br/>
							CPU NAME: <span style="font-weight:bold;">'.$fileContent[1].'</span><br/>
							PHYSICAL CORES: <span style="font-weight:bold;';
							
							if ($fileContent[2] < 2){
								echo 'color:red;';
							}
							
							echo '">'.$fileContent[2].'</span><br/>
							LOGICAL CORES: <span style="font-weight:bold;">'.$fileContent[3].'</span><br/>
							CPU SPEED: <span style="font-weight:bold;';
							
							if ($fileContent[4] < 2){
								echo 'color:red;';
							}
							
							echo '">'.$fileContent[4].' GHz</span><br/>
							RAM: <span style="font-weight:bold;';
							
							if ($fileContent[5] < 3){
								echo 'color:red;';
							}
							
							echo '">'.$fileContent[5].' GB</span><br/>
							Internet Adapter: <span style="font-weight:bold;';
							
							if(strpos($fileContent[6], 'Apple') !== false) {
								
								echo 'color:red;';
								
							}
							
							
							echo '">'.$fileContent[6].'</span><br/>
							Machine Type: <span style="font-weight:bold;">'.$fileContent[7].'</span><br/>
							IE Version: <span style="font-weight:bold;">'.$fileContent[8].'</span><br/>
							Chrome Version: <span style="font-weight:bold;">'.$fileContent[9].'</span><br/>
							USB Headset: <span style="font-weight:bold;';
							
							if ($fileContent[10] == "No"){
								
								echo 'color:red;';
								
							}
							
							echo '">'.$fileContent[10].'</span><br/>
							
							
							15" Monitor: <span style="font-weight:bold;';
							
							if ($fileContent[11] == "No"){
								
								echo 'color:red;';
								
							}
							
							echo '">'.$fileContent[11].'</span><br/>
							WebCam: <span style="font-weight:bold;';
							
							if ($fileContent[12] == "No"){
								
								echo 'color:red;';
								
							}
							
							echo '">'.$fileContent[12].'</span><br/>
                            
                            Antivirus: <span style="font-weight:bold;">'.$fileContent[13].'</span><br/>
							
			
				   </p>
				   <br/>
              </dd>';
             
			
			
			if ($fileContent[2] >= 2 && $fileContent[4] >= 2 && $fileContent[5] >= 3 && $fileContent[10] == "Yes" && $fileContent[11] == "Yes" && $fileContent[12] == "Yes" && strpos($fileContent[6], 'Apple') !== true) {
				
				$qualified = $qualified + 1;
				
			} else {
				
				
				$nonqualified = $nonqualified + 1;
				
			}
			
			
			
			if (strpos($fileContent[6], 'Wi-Fi') !== false || strpos($fileContent[6], 'Wireless') !== false || strpos($fileContent[6], 'WLAN') !== false || strpos($fileContent[6], 'WiFi') !== false || strpos($fileContent[6], 'Centrino') !== false) {
				
				$wirelessocc = $wirelessocc + 1;
				
			}
			
			$qualPerc = $qualified / $counter * 100;
			$nonqualPerc = $nonqualified / $counter * 100;
			$wifiPerc = $wirelessocc / $counter * 100;
			//$complPerc = $counter / $newhireamount * 100;
			 
		} ?>
			 
            </dl>

          </div>

		
		 

</div>
<div></div> 
		
		<div id="#stats" style="width:275px;color:white;background:#5F799D;padding:1em;line-height:20px;">
		New Hire Entries: <?php echo $counter ?><br/>
		Qualified Percentage: <?php echo round($qualPerc, 0); ?>%<br/>
		WiFi Usage Percentage: <?php echo round($wifiPerc, 0); ?>%</br>
		Non-Qualified Percentage: <?php echo round ($nonqualPerc, 0); ?>%<br/>
    </div>
	<div></div> 
        <script src="js/index.js"></script>

    
    
    
  </body>
</html>
