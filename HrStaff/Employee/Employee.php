<?php
    require_once '../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["EmployeeId"];
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>All Employee page</title>

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

    <link rel="stylesheet" type="text/css" href="Employee.css">
</head>
<body>
    <div class="header">
    <h1>Employee Details</h1>
    <form action="../Hr Staff.php" method="post" style="text-align: right;">
        <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        <button class="btn view" text-align="right";>Back</button>
    </form>
    </div>
    <br>
    <div class="w3-container">
    <div class="w3-card-4" style="width:40%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>Employee Info</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>View all Employee details</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Info/Info.php" method="post">
                <button type="submit" class="btn info">View</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            </form>
            <br>
        </footer>
    </div>
    <div class="w3-card-4" style="width:40%; float: left;">
        <header class="w3-container w3-green">
            <h2>Employee Leave</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>To Edit View leave requests</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Leave/New Leave.php" method="post" style="display: inline-block;">
                <button type="submit" class="btn info">New</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            </form>
            <form action="./Leave/Old Leave.php" method="post" style="display: inline-block;">
                <button type="submit" class="btn info">Old</button>
                <Input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            </form>
            <br>
            <br>
        </footer>
    </div>
    </div>
    <br>
    <div class="w3-container">
    <div class="w3-card-4" style="width:40%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>Employee Payroll</h2>
        </header>

        <div class="w3-container w3-white">
            <H4>To Edit View Add Payroll</H4>
        </div>
        <footer class="w3-container w3-white" style="text-align: right;">
            <br>
            <form action="./Payroll/Payroll.php" method="post">
                <button type="submit" class="btn info">View</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            </form>
            <br>
        </footer>
    </div>
    </div>
</body>
</html>
