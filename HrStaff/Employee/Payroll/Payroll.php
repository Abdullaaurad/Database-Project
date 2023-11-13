<?php
    require_once '../../../Config/config.php';

    $PayrollRecords = array();
    if (isset($_GET['variableToPass'])) {
        $EmployeeId = $_GET['variableToPass'];
            $sql1 = "SELECT * FROM Payroll WHERE Employee_Id != '$EmployeeId' ";
            $result1 = $connection->query($sql1);

            if ($result1->num_rows > 0) {
                while ($row = $result1->fetch_assoc()) {
                    $Pay_slip_No = $row['Pay_slip_No'];
                    $Date = $row['Date'];
                    $Salary = $row['Salary'];
                    $Bonus = $row['Bonus'];
                    $Allowance = $row['Allowance'];
                    $Employee_Id = $row['Employee_Id'];
                    $PayrollRecords[] = $row;
                }
            }
    }

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];
        $sql1 = "SELECT * FROM Payroll WHERE Employee_Id != '$EmployeeId' ";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $Pay_slip_No = $row['Pay_slip_No'];
                $Date = $row['Date'];
                $Salary = $row['Salary'];
                $Bonus = $row['Bonus'];
                $Allowance = $row['Allowance'];
                $Employee_Id = $row['Employee_Id'];
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
    <title>Payroll page</title>

    <style>
        .button {
            margin-left: 30px;
            justify-content:first baseline;
        }
        table {
            table-layout: auto;
            width: 200px;
            align-items: 'left';
        }
        table td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

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
    <link rel="stylesheet" type="text/css" href="Payroll.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
        <h1>Employee Payroll</h1>
        <form action="./Add/Add.php" method="post" style="text-align: right; width: 65%;">
            <button type="submit" class="btn info">Add Job</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </form>
        <form action="../../Hr Staff.php" method="post" style="text-align: right; width: 10%">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <button class="btn info">Back</button>
        </form> 
    </div>
    <br>
<?php foreach ($PayrollRecords as $record): ?>
<div class="w3-container">
    <div class="w3-card-4" style="width: 70%; float: left; margin-right: 10px;">
        <div class="w3-container w3-white">
        <table>
                <tr>
                    <td>Pay Slip No:</td>
                    <td><?php echo $record['Pay_slip_No'];   $Pay_slip_No=$record['Pay_slip_No'] ;?></td>
                </tr>
                <tr>
                    <td>Date:</td>
                    <td><?php echo $record['Date']; ?></td>
                </tr>
                <tr>
                    <td>Salary:</td>
                    <td><?php echo "$".$record['Salary']; ?></td>
                </tr>
                <tr>
                    <td>Bonus:</td>
                    <td><?php echo "$".$record['Bonus']; ?></td>
                </tr>
                <tr>
                    <td>Allowance:</td>
                    <td><?php echo "$".$record['Allowance']; ?></td>
                </tr>
                <tr>
                    <td>Employee_Id:</td>
                    <td><?php echo $record['Employee_Id']; ?></td>
                </tr>
        </table>
        <footer class="w3-container w3-white">
            <form action="./Edit/Edit.php" method="post" style="text-align: right; display: inline-block; width: 90%;">
                <button type="submit" class="btn info">Edit</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <input type="hidden" name="Pay_slip_No" value="<?php echo $Pay_slip_No; ?>">
            </form>

            <form action="./Delete/Delete.php" method="post" style="text-align: right; display: inline-block; width: 2%;">
                <button type="submit" class="btn info">Delete</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <input type="hidden" name="Pay_slip_No" value="<?php echo $Pay_slip_No; ?>">
            </form>
            <br>
        </footer>

        </div>          
        <br>
        <br>
    </div>
</div>
<?php endforeach; ?>
</body>
</html>

