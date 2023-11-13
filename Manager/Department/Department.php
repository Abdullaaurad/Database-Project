<?php
    require_once '../../Config/config.php';

    $employeeId = '';
    $DepartmentRecords = array();

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];

        $sql1 = "SELECT * FROM department ";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $DepartmentRecords[] = $row;
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
    <title>Department page</title>

    <style>
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
    <link rel="stylesheet" type="text/css" href="Department.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
<body>
    <div class="header">
        <h1 class="center">Departments</h1>
    </div>
    <div class="table-container">
        <table >
            <tr>
                <th>Name/th>
                <th>Creation Date</th>
                <th>Location</th>
                <th>Manager Id</th>
            </tr>
            <?php foreach ($DepartmentRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Name']; ?></td>
                    <td><?php echo $record['Creation_Date']; ?></td>
                    <td><?php echo $record['Location']; ?></td>
                    <td><?php echo $record['Manager_Id']; ?></td>
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