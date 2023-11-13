<?php
    require_once '../../../Config/config.php';

    $EmployeeRecords = array();

    if (isset($_GET['variableToPass'])) {
        $EmployeeId = $_GET['variableToPass'];
        $sql1 = "SELECT * FROM employee ;";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $EmployeeRecords[] = $row;
            }
        }
    }

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];

        $sql1 = "SELECT * FROM employee;";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $EmployeeRecords[] = $row;
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
    <title>All Employee Info page</title>

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
    <link rel="stylesheet" type="text/css" href="Info.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
<body>
<div class="header">
        <h1>Employee Info</h1>
        <form action="../Employee.php" method="post" style="display: inline-block; width: 10%;">
            <Input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <button type="submit" class="btn info">Back</button>
        </form>
</div>
    <div class="table-container">
        <table align="left">
            <tr>
                <th>Employee Id</th>
                <th>Name</th>
                <th>Date of Birth</th>
                <th>Gender</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Joined Date</th>
                <th>Department</th>
                <th>Job_Id</th>
            </tr>
            <?php foreach ($EmployeeRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Employee_Id']; $Employee_Id=$record['Employee_Id']; ?></td>
                    <td><?php echo $record['Name']; ?></td>
                    <td><?php echo $record['Date_of_Birth']; ?></td>
                    <td><?php echo $record['Gender']; ?></td>
                    <td><?php echo $record['Address']; ?></td>
                    <td><?php echo $record['Contact']; ?></td>
                    <td><?php echo $record['Email']; ?></td>
                    <td><?php echo $record['Joining_Date']; ?></td>
                    <td><?php echo $record['Department']; ?></td>
                    <td><?php echo $record['Job_Id']; ?></td>
                    <td>
                        <form action="./Edite.php" method="post" style="display: inline-block;">
                            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                            <input type="hidden" name="Employee_Id" value="<?php echo $Employee_Id; ?>">
                            <button type="submit"> Edit </button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>    