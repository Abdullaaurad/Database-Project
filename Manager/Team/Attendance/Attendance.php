<?php
require_once '../../../Config/config.php';

$employeeId = '';
$EmployeeRecords = array();
$attendanceRecords = array();

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["EmployeeId"];

    $sql1 = "SELECT department FROM employee WHERE Employee_Id='$EmployeeId'";
    $result1 = $connection->query($sql1);
    $row1 = $result1->fetch_assoc();
    $Department = $row1['department'];

    $sql2 = "SELECT Employee_Id FROM employee WHERE Department='$Department'";
    $result2 = $connection->query($sql2);
    $EmployeeRecords = $result2->fetch_all(MYSQLI_ASSOC);

    foreach ($EmployeeRecords as $record1) :
        $EmployeeId = $record1['Employee_Id'];
        $sql3 = "SELECT * FROM attendance WHERE Employee_Id='$EmployeeId'";
        $result3 = $connection->query($sql3);

        if ($result3->num_rows > 0) {
            while ($row = $result3->fetch_assoc()) {
                $attendanceRecords[] = $row;
            }
        }
    endforeach;
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Attendance page</title>

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
    <link rel="stylesheet" type="text/css" href="Attendance.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
        <h1>Attendance details of Team members</h1>
    </div>
    <div class="table-container">
        <table align="left">
            <tr>
                <th>Employee Id</th>
                <th>Name</th>
                <th>Date</th>
                <th>Arrival Time</th>
                <th>Departure Time</th>
            </tr>
            <?php foreach ($attendanceRecords as $record) : ?>
                <tr>
                    <td>
                        <?php 
                            echo $record['Employee_Id']; 
                            $Employee_Id=$record['Employee_Id'];
                            $sql4="SELECT Name FROM employee WHERE Employee_Id='$Employee_Id' ";
                            $result4 = $connection->query($sql4);
                            $row4 = $result4->fetch_assoc();
                            $Name = $row4['Name'];
                        ?>
                    </td>
                    <td><?php echo $Name ?></td>
                    <td><?php echo $record['Date']; ?></td>
                    <td><?php echo $record['Arrival Time']; ?></td>
                    <td><?php echo $record['Departure Time']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
        <div style="display: flex; justify-content: space-between;">
            <form action="../Team.php" method="post" style="width: 65%;">
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <button type="submit" class="btn info">Back</button>
            </form>
            <form action="./View 1Employee.php" method="post" style="width: 45%;">
                <button type="submit" class="btn info">Get Info</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <label for="id">EmployeeId</label>
                <select id="Id" name="Id">
                    <?php
                    $uniqueEmployeeIds = array_unique(array_column($attendanceRecords, 'Employee_Id'));

                    foreach ($uniqueEmployeeIds as $uniqueEmployeeId) :
                    ?>
                        <option value="<?php echo $uniqueEmployeeId; ?>">
                            <?php echo $uniqueEmployeeId; ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </form>

        </div>
</div>

</body>
</html>