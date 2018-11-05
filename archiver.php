<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <title>SpecRep Tracker</title>
    <script src="https://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
	<script src="https://use.fontawesome.com/182479f241.js"></script>
	<script src="js/index.js"></script>
    
    <link rel="stylesheet" href="css/reset.css">

    
        <link rel="stylesheet" href="css/style.css">

    
    
    
  </head>

  <body>
  
  <?php
  
				if (file_exists("/tmp/new_hire_specrep_amount.txt")){
					
					$newhireamount = file_get_contents("/tmp/new_hire_specrep_amount.txt");
					
				}
				
				
				
	?>
  
  
  <table style="color:white;" id='tracker'>
    <tr>
    <th style='width:25%'>Agent Name</th>
	<th style='width:25%'>Date</th>
	<th style='width:25%'>Time</th>
    <th style='width:25%'>Specifications</th>

  </tr>
  

  
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
  
  
			echo "<tr>";
			
			echo "<td>";
			echo $agentname;
			echo "</td>";
			
			echo "<td>";
			echo date("F d Y", filemtime($filename));
			echo "</td>";
			
			echo "<td>";
			echo date("H:i", filemtime($filename));
			echo ' CST';
			echo "</td>";
			
			if ($fileContent[2] >= 3 && $fileContent[4] < 2){
					$qualified = $qualified + 1;
					$nonqualified = $nonqualified - 1;
				}
			
echo "<td>";
echo '
OperSys: '.$fileContent[0].'</span><br/>
CPU NAME: '.$fileContent[1].'</span><br/>
PHYSICAL CORES: '.$fileContent[2].'</span><br/>
LOGICAL CORES: '.$fileContent[3].'</span><br/>
CPU SPEED: '.$fileContent[4].' GHz</span><br/>
RAM: '.$fileContent[5].' GB</span><br/>
Internet Adapter: '.$fileContent[6].'</span><br/>
Machine Type: '.$fileContent[7].'</span><br/>
IE Version: '.$fileContent[8].'</span><br/>
Chrome Version: '.$fileContent[9].'</span><br/>
USB Headset: '.$fileContent[10].'</span><br/>
15 Inch Monitor: '.$fileContent[11].'</span><br/>
WebCam: '.$fileContent[12].'</span> ';echo "</td>";

  			if ($fileContent[2] >= 2 && $fileContent[4] >= 2 && $fileContent[5] >= 3 && $fileContent[10] == "Yes" && $fileContent[11] == "Yes" && $fileContent[12] == "Yes") {
				
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
			$complPerc = $counter / $newhireamount * 100;
  
  
		}?>
  
  </tr>
  </table>
  
  
<table>
<tr>
<td> <div style="font-weight:bold;">New Hire Entries: <?php echo $counter ?> </div>
	<div style="font-weight:bold;">Completion Percentage: <?php echo round($complPerc, 0); ?>%</div>
<div style="font-weight:bold;">Qualified Percentage: <?php echo round($qualPerc, 0) ?>%</div>
<div style="font-weight:bold;">WiFi Usage Percentage: <?php echo round($wifiPerc, 0) ?>%</div>
<div style="font-weight:bold;">Non-Qualified Percentage: <?php echo round($nonqualPerc, 0); ?>%</div>
</tr>
</table>
  </body>
  </html>