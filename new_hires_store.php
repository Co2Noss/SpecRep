<?php
if(isset($_POST['numofhires'])) {
    $data = $_POST['numofhires'];
    $ret = file_put_contents('/tmp/new_hire_specrep_amount.txt', $data, FILE_APPEND | LOCK_EX);
    if($ret === false) {
        die('There was an error writing this file.');
    }
    else {
		
		echo "Success. Redirecting, please wait.";
echo "<script>setTimeout(\"location.href = 'https://specrep.net';\",4000);</script>";
    }
}
else {
		echo "Cannot submit empty value. Redirecting, please wait.";
echo "<script>setTimeout(\"location.href = 'https://specrep.net';\",4000);</script>";
}