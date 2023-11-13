<?php 

require_once './Config/config.php' ;

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Home page</title>

    <style>
        body{
            background-image: url('./Image/04.jpg');
            display: flex;
            justify-content: center;
            align-items: center;
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }

        .w3-container {
            text-align: center;
            width: 70%;
            height: 80%;
        }


    </style>
    <link rel="stylesheet" type="text/css" href="Index.css">
</head>
<body>
    <br><br>
    <div class="w3-container" style="margin-right: 10px; background-image: url('./Image/01.jpg'); background-size: cover; height: 300px; width: 500px">
    <br><br>
            <form action="./login/login.php">
                <button class="btn info">LogIn</button>
            </form>
            <br><br><br>
            <form action="./Signup/signup.php">
                <button class="btn info">SignUp</button>
            </form>
    <br><br>
    </div>
    <br><br>
    <div class="buttons-container">
    <form action='./Vacancy/Vacancy.php'>
        <button class="btn view"> Vacancy </button>
    </form>
    <form action='./Apply/Apply.php'>
        <button class="btn view"> View sent Applications </button>
    </form>
    </div>
</body>
</html>