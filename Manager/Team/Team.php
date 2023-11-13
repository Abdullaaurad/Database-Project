<?php
    require_once '../../Config/config.php';

if (isset($_GET['variableToPass'])) {
    $receivedVariable = $_GET['variableToPass'];
    $EmployeeId = $receivedVariable;
}

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["EmployeeId"];
    $receivedVariable=$EmployeeId;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Team page</title>

    <style>
        body {
            background-image: url('../../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>


    <link rel="stylesheet" type="text/css" href="Team.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
    <h1>Team</h1>
    <form action="./Attendance/Attendance.php" method="post" >
        <input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
        <button class="btn info">Info</button>
    </form>
    </div>
    <br>
    <div class="w3-container">
    <div class="w3-card-4" style="width:40%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>Profiles</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View team member details</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Members/Team member.php" method="post">
                <button type="submit" class="btn info">View</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>

    <div class="w3-card-4" style="width:40%; float: left;">
        <header class="w3-container w3-green">
            <h2>Attendance</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>Attendance of Team members</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="../Team/Attendance/Attendance.php" method="post">
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
            <H4>View Payment info of Team members</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Payroll/Payroll.php" method="post">
                <button type="submit" class="btn info">View</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>
    <div class="w3-card-4" style="width:40%; float: left;">
        <header class="w3-container w3-green">
            <h2>Leave</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View Team old and new leave requests</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Leave/New Leave.php" method="post" style="display: inline-block;">
                <button type="submit" class="btn info">New</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <form action="./Leave/Old Leave.php" method="post" style="display: inline-block;">
                <button type="submit" class="btn info">Old</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
            </form>
            <br>
        </footer>
    </div>
    </div>
    <br><br>
    <form action="../Manager.php" method="post" style="text-align: right;">
        <input type="hidden" name="EmployeeId" value="<?php echo $receivedVariable; ?>">
        <button class="btn view" text-align="right";>Back</button>
    </form>
    <br>
</body>
</html>
