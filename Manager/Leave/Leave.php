<?php
    require_once '../../Config/config.php';

    $employeeId = '';
    $leaveRecords = array();

    if (isset($_GET['variableToPass'])) {
        $EmployeeId = $_GET['variableToPass'];
        $sql1 = "SELECT * FROM employee_leave WHERE Employee_Id='$EmployeeId' ";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            $employeeId = $EmployeeId;
            while ($row = $result1->fetch_assoc()) {
                $leaveRecords[] = $row;
            }
        } 
    }
    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];

        $sql1 = "SELECT * FROM employee_leave WHERE Employee_Id='$EmployeeId' ";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            $employeeId = $EmployeeId;
            while ($row = $result1->fetch_assoc()) {
                $leaveRecords[] = $row;
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
    <title>Leave page</title>

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
    <link rel="stylesheet" type="text/css" href="leave.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
    <h1 class="center">Leave Details of Employee</h1>
    </div>
    <div class="table-container">
        <table align="left">
            <tr>
                <th>Commencement Date</th>
                <th>Conclusion Date</th>
                <th>Type</th>
                <th>Acceptance</th>
            </tr>
            <?php foreach ($leaveRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Commencement_Date']; ?></td>
                    <td><?php echo $record['Conclusion_Date']; ?></td>
                    <td><?php echo $record['Type']; ?></td>
                    <td><?php echo $record['Acceptance']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    <div>
    <form action="../Employee.php" method="post" style="display: inline-block; width: 10%;">
        <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        <button type="submit" class="btn info" style="width: 100%;">Back</button>
    </form>
    <span style="display: inline-block; width: 10%;">&nbsp;</span>
    <form action="New leave.php" method="post" style="display: inline-block; width: 20%;">
        <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        <button type="submit" class="btn info" style="width: 100%;">Request Leave</button>
    </form>
    </div>
    </div>
</body>
</html>