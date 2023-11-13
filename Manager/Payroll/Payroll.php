<?php
    require_once '../../Config/config.php';

    $employeeId = '';
    $PayrollRecords = array();

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];

        $sql1 = "SELECT * FROM payroll WHERE Employee_Id='$EmployeeId' ";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            $employeeId = $EmployeeId;
            while ($row = $result1->fetch_assoc()) {
                $PayrollRecords[] = $row;
            }
        }
    }
?>

<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payroll page</title>

    <style>
         body {
            background-image: url('../../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: left;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../Payroll/payroll.css">
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
                <th>Date</th>
                <th>Salary</th>
                <th>Bonus</th>
                <th>Allowance</th>
            </tr>
            <?php foreach ($PayrollRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Pay_slip_No']; ?></td>
                    <td><?php echo $record['Date']; ?></td>
                    <td><?php echo $record['Salary']; ?></td>
                    <td><?php echo $record['Bonus']; ?></td>
                    <td><?php echo $record['Allowance']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    <form action="../Employee.php" method="post" style="display: inline-block; width: 10%;">
        <Input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        <button type="submit" class="btn info">Back</button>
    </form>
    </div>
</body>
</html>    