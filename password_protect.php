<?php

$LOGIN_INFORMATION = array(
  'SPRep' => 'Q^s&ns!Frboc'
);


define('USE_USERNAME', true);


define('LOGOUT_URL', 'loggedout.php');


define('TIMEOUT_MINUTES', 60);


define('TIMEOUT_CHECK_ACTIVITY', true);






// show usage example
if(isset($_GET['help'])) {
  die('Include following code into every page you would like to protect, at the very beginning (first line):<br>&lt;?php include("' . str_replace('\\','\\\\',__FILE__) . '"); ?&gt;');
}

// timeout in seconds
$timeout = (TIMEOUT_MINUTES == 0 ? 0 : time() + TIMEOUT_MINUTES * 60);

// logout?
if(isset($_GET['logout'])) {
  setcookie("verify3", '', $timeout, '/'); // clear password;
  header('Location: ' . LOGOUT_URL);
  exit();
}

if(!function_exists('showLoginPasswordProtect')) {

// show login form
function showLoginPasswordProtect($error_msg) {
?>
<!DOCTYPE html>
<html>
<head>
 <title>SpecRep Tracker - Login</title>
 <link href="cssli/style.css" rel='stylesheet' type='text/css' />
  <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
  <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
  <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
		
		<link href='https://fonts.googleapis.com/css?family=Open+Sans:600italic,400,300,600,700' rel='stylesheet' type='text/css'>
</head>
<body>
 <div class="main">
		<div class="login-form">
			<h1>SpecRep Tracker Login</h1>
					<div class="head">
					</div>
				<form method="post">
    <font color="red"><?php echo $error_msg; ?></font><br /><br />
    Username:<br /><input type="text" name="access_login" /><br />
    Password:<br /><input type="password" name="access_password" /><p></p>
    <input type="submit" name="Submit" value="Login" />
  </form>
  <br />
  </div>
  
  
  <!--
  
  	 <div class="main">
		<div class="login-form">
			<h1>Member Login</h1>
					<div class="head">
						<img src="images/user.png" alt=""/>
					</div>
				<form>
						<input type="text" class="text" value="USERNAME" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'USERNAME';}" >
						<input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}">
						<div class="submit">
							<input type="submit" onclick="myFunction()" value="LOGIN" >
					</div>	
					<p><a href="#">Forgot Password ?</a></p>
				</form>
			</div>
			
		</div>
  
  
  -->
  
  
</body>
</html>

<?php
  // stop at this point
  die();
}
}

// user provided password
if (isset($_POST['access_password'])) {

  $login = isset($_POST['access_login']) ? $_POST['access_login'] : '';
  $pass = $_POST['access_password'];
  if (!USE_USERNAME && !in_array($pass, $LOGIN_INFORMATION)
  || (USE_USERNAME && ( !array_key_exists($login, $LOGIN_INFORMATION) || $LOGIN_INFORMATION[$login] != $pass ) ) 
  ) {
    showLoginPasswordProtect("Incorrect username or password.");
  }
  else {
    // set cookie if password was validated
    setcookie("verify3", md5($login.'%'.$pass), $timeout, '/');
    
    // Some programs (like Form1 Bilder) check $_POST array to see if parameters passed
    // So need to clear password protector variables
    unset($_POST['access_login']);
    unset($_POST['access_password']);
    unset($_POST['Submit']);
  }

}

else {

  // check if password cookie is set
  if (!isset($_COOKIE['verify3'])) {
    showLoginPasswordProtect("");
  }

  // check if cookie is good
  $found = false;
  foreach($LOGIN_INFORMATION as $key=>$val) {
    $lp = (USE_USERNAME ? $key : '') .'%'.$val;
    if ($_COOKIE['verify3'] == md5($lp)) {
      $found = true;
      // prolong timeout
      if (TIMEOUT_CHECK_ACTIVITY) {
        setcookie("verify3", md5($lp), $timeout, '/');
      }
      break;
    }
  }
  if (!$found) {
    showLoginPasswordProtect("");
  }

}



?>
