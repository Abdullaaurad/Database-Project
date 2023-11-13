<?php
    require_once '../Config/config.php';

if (isset($_GET['variableToPass'])) {
    $receivedVariable = $_GET['variableToPass'];
    $EmployeeId = $receivedVariable;
    $sql1="SELECT * FROM employee WHERE Employee_Id='$EmployeeId' ";
    $result1= $connection->query($sql1);
    if($result1->num_rows >0){
        $row = $result1->fetch_assoc();
        $Email = $row['Email'];
    }
}

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["EmployeeId"];
    $receivedVariable=$EmployeeId;
    $sql1="SELECT * FROM employee WHERE Employee_Id='$EmployeeId' ";
    $result1= $connection->query($sql1);
    if($result1->num_rows >0){
        $row = $result1->fetch_assoc();
        $Email = $row['Email'];
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Employee page</title>

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

    <link rel="stylesheet" type="text/css" href="Employee.css">
</head>
<body>
    <div class="header">
    <h1>Employee</h1>
    <form action="../Info/About.php" method="post">
        <input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
        <button class="btn info">Info</button>
    </form>
    </div>
    <br>
    <div class="w3-container">
    <div class="w3-card-4" style="width:40%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>Attendance</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View Attendance</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="Attendance/Attendance.php" method="post">
                <button type="submit" class="btn info">View</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>

    <div class="w3-card-4" style="width:40%; float: left;">
        <header class="w3-container w3-green">
            <h2>Leave</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>Request new leave or view old</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="Leave/Leave.php" method="post">
                <button type="submit" class="btn info">View</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>
    </div>
    <br>
    <div class="w3-container">
    <div class="w3-card-4" style="width:40%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>Payroll</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View Payment info</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="Payroll/Payroll.php" method="post">
                <button type="submit" class="btn info">View</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>
    <div class="w3-card-4" style="width:40%; float: left;">
        <header class="w3-container w3-green">
            <h2>Department</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View All the Departments</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="Department/Department.php" method="post">
                <button type="submit" class="btn info">View</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>
    </div>
    <br>
    <div class="w3-container">
    <div class="w3-card-4" style="width:40%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>Vacancy</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View all Vacancies</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="Vacancy/Vacancy.php" method="post">
                <button type="submit" class="btn info">View</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>
    <div class="w3-card-4" style="width:40%; float: left;">
        <header class="w3-container w3-green">
            <h2>Job Application</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View Applied Job Applications</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Job Application/Job Application.php" method="post">
                <button type="submit" class="btn info">View</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
                <Input type="hidden" name="Email" value="<?php echo $Email; ?>">
            </form>
            <br>
        </footer>
    </div>
    </div>
</body>
</html>
