<?php 

require_once '../Config/config.php' ;

?>

<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup page</title>

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

    <link rel="stylesheet" type="text/css"  href="signup.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
  <form action="hi.php" method="post" style="border:1px solid #ccc">
  <div class="container">
    <div class="header">
    <h1>Sign Up</h1>
    <p>Please fill in this form to create an account.</p>
    </div>
    <br>
    <label for="Employee_Id"><b>Employee_Id</b></label>
    <input type="text" placeholder="Enter Employee ID" name="employee_Id" maxlength="12" required>

    <label for="User Name"><b>User Name</b></label>
    <input type="text" placeholder="Enter User Name" name="User_Name" maxlength="20" required>
    
    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" maxlength="20" required>
    </form>  
    <label>
      <input type="checkbox" checked="checked" name="remember" style="margin-bottom:15px"> Remember me
    </label>

    <div class="clearfix">
      <button type="button" class="cancel-btn">Cancel</button>
      <button type="submit" class="signup-btn">Sign Up</button>
    </div>
  </div>
  
</body>
</html>