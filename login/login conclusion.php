<?php 

require_once '../Config/config.php' ;

if($_SERVER['REQUEST_METHOD'] === "POST"){
    $username = $_POST["uname"];
    $password = $_POST["psw"];
    $remember = $_POST["remember"];

    $sql1="SELECT Employee_Id FROM login WHERE User_Name='$username' AND Password='$password' ";

    $result1= $connection->query($sql1);
    if($result1->num_rows > 0){
        $row = $result1->fetch_assoc();
        $employeeId = $row['Employee_Id'];

        $sql2="SELECT Job_Id FROM Employee WHERE Employee_Id='$employeeId'";
        $result2 = $connection->query($sql2);
        $row2 = $result2->fetch_assoc();
        $jobId = $row2['Job_Id'];
        if($jobId == 41){
            $url = "../Manager/Manager.php?variableToPass=" . urlencode($employeeId);
            header("Location: $url");
            exit;
        }
        elseif($jobId == 1 || $jobId == 2 || $jobId == 3 || $jobId == 4 || $jobId == 5){
            $url = "../HrStaff/Hr Staff.php?variableToPass=" . urlencode($employeeId);
            header("Location: $url");
            exit;
        }
        else{
            $url = "../Employee/Employee.php?variableToPass=" . urlencode($employeeId);
            header("Location: $url");
            exit;
        }
    }
    else{
        echo 'Wrong password or username';
        header('Location: ../login/login.php');
        exit;
    }
}

elseif (isset($_GET['variableToPass'])) {
    $receivedVariable = $_GET['variableToPass'];
    $employeeId= $receivedVariable;
    $sql2="SELECT Job_Id FROM Employee WHERE Employee_Id='$employeeId'";
    $result2 = $connection->query($sql2);
    $row2 = $result2->fetch_assoc();
    $jobId = $row2['Job_Id'];
    if($jobId == 41){
        $url = "../Manager/Manager.php?variableToPass=" . urlencode($employeeId) . "&EmployeeId=" . urlencode($receivedVariable);
        header("Location: $url");
        exit;
        
    }
    elseif($jobId == 1 || $jobId == 2 || $jobId == 3 || $jobId == 4 || $jobId == 5){
        $url = "../HrStaff/Hr Staff.php?variableToPass=" . urlencode($employeeId) . "&EmployeeId=" . urlencode($receivedVariable);
        header("Location: $url");
        exit;
    }
    else{
        $url = "../Employee/Employee.php?variableToPass=" . urlencode($employeeId) . "&EmployeeId=" . urlencode($receivedVariable);
        header("Location: $url");
        exit;
    }
}
?>


<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login conclusion page</title>

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

</body>
</html>