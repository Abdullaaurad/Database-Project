<?php 

require_once '../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["employee_Id"];
    $Username = $_POST["User_Name"];
    $password = $_POST["psw"];
}

// Check if Employee ID exists in the 'employee' table
$sql1 = "SELECT * FROM employee WHERE Employee_Id='$EmployeeId'";
$result1 = $connection->query($sql1);

if ($result1->num_rows > 0) {
    $sql3 = "SELECT * FROM login WHERE Employee_Id='$EmployeeId'";
    $result3 = $connection->query($sql3);
    if ($result3->num_rows > 0) {
        echo "EmployeeID is already taken by another user";
    } else {
        // Check if the Username is already taken in the 'login' table
        $sql2 = "SELECT * FROM login WHERE User_Name='$Username'";
        $result2 = $connection->query($sql2);

        if ($result2->num_rows > 0) {
            echo "User Name is already taken";
        } else {
            // Fix the SQL query: Remove single quotes around table name 'login'
            $sql3 = "INSERT INTO login (User_Name, Password, Employee_Id) VALUES ('$Username', '$password', '$EmployeeId')";
            $result4 = $connection->query($sql3);

            if ($result4) {
                $url = "../login/login conclusion.php?variableToPass=" . urlencode($EmployeeId);
                header("Location: $url");
                exit;
            } else {
                echo "Adding unsuccessful";
            }
        }
    }
} else {
    echo "EmployeeId is Incorrect";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup conclusion page</title>

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
</head>
<body>
    <form action="../Signup/signup.php">
        <button type="submit">Return to Signup Page</button>
    </form>
</body>
</html>
