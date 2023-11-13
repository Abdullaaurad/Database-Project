<?php 

require_once '../Config/config.php' ;
?>

<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogIn page</title>

    <style>
        body {
            background-image: url('../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<form action="./login conclusion.php" method="post">
  <div class="img-container">
    <img src="../Image/Avatar.jpg" alt="Avatar" class="avatar">
  </div>

  <div class="container">
    <label for="uname"><b>Username</b></label>
    <input type="text" placeholder="Enter Username" id="username" name="uname" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" id="password" name="psw" maxlength="10" required>

    <button type="submit">Login</button>
    <label>
      <input type="checkbox" checked="checked" name="remember"> Remember me
    </label>
  </div>
    <div class="container" style="background-color:#f1f1f1">
    <button type="button" class="cancel-btn" id="cancelButton">Cancel</button>
    <span class="psw">Forgot <a href="#">password?</a></span>
  </div>
</form>
<script>
        const cancelButton = document.getElementById('cancelButton');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');

        cancelButton.addEventListener('click', function() {
            usernameInput.value = '';
            passwordInput.value = '';
        });
    </script>
</body>
</html>