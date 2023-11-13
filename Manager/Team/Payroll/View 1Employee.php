<?php
require_once '../../../Config/config.php';

$PayrollRecords = array();

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["EmployeeId"];
    $Id = $_POST['Id'];
    $sql3 = "SELECT * FROM payroll WHERE Employee_Id='$Id'";
    $result3 = $connection->query($sql3);
    if ($result3->num_rows > 0) {
        while ($row = $result3->fetch_assoc()) {
            $PayrollRecords[] = $row;
        }
    }
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Employee Payroll page</title>

    <style>
        body {
            background-image: url('../../../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: left;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="View 1Employee.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
        <h1>Payroll of Employee</h1>
    </div>
    <div class="table-container">
        <table align="left">
            <tr>
                <th>Pay Slip No</th>
                <th>Name</th>
                <th>Date</th>
                <th>Salary</th>
                <th>Bonus</th>
                <th>Allowance</th>
            </tr>
            <?php foreach ($PayrollRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Pay_slip_No']; ?></td>
                    <td>
                        <?php 
                            $ID= $record['Employee_Id']; 
                            $sql4="SELECT Name FROM employee WHERE Employee_Id='$ID' ";
                            $result4 = $connection->query($sql4);
                            $row4 = $result4->fetch_assoc();
                            $Name = $row4['Name'];
                            echo $Name;
                        ?>
                    </td>
                    <td><?php echo $record['Date']; ?></td>
                    <td><?php echo $record['Salary']; ?></td>
                    <td><?php echo $record['Bonus']; ?></td>
                    <td><?php echo $record['Allowance']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
        <div style="display: flex; justify-content: space-between;">
            <form action="./Payroll.php" method="post" style="width: 65%;">
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <button type="submit" class="btn info">Back</button>
            </form>
        </div>
</div>

</body>
</html>