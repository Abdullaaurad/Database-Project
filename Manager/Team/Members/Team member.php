<?php
    require_once '../../../Config/config.php';

    $EmployeeRecords = array();

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];

        $sql1 = "SELECT * FROM employee WHERE Employee_Id='$EmployeeId' ";
        $result1 = $connection->query($sql1);
        $row1 = $result1->fetch_assoc();
        $Department = $row1['Department'];

        $sql2 = "SELECT * FROM employee WHERE Department='$Department' ";
        $result2 = $connection->query($sql2);
        $row2 = $result1->fetch_assoc();
        if ($result2->num_rows > 0) {
            while ($row2 = $result2->fetch_assoc()) {
                $EmployeeRecords[] = $row2;

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
    <link rel="stylesheet" type="text/css" href="./Team member.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
        <h1> Team member Details </h1>
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
                <th>Job</th>
            </tr>
            <?php foreach ($EmployeeRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Employee_Id']; ?></td>
                    <td><?php echo $record['Name']; ?></td>
                    <td><?php echo $record['Date_of_Birth']; ?></td>
                    <td><?php echo $record['Gender']; ?></td>
                    <td><?php echo $record['Address']; ?></td>
                    <td><?php echo $record['Contact']; ?></td>
                    <td><?php echo $record['Email']; ?></td>
                    <td><?php echo $record['Joining_Date']; ?></td>
                    <td>
                        <?php 
                            $Job_Id=$record['Job_Id'] ;
                            $sql3= "SELECT * FROM job WHERE Job_Id='$Job_Id' ";
                            $result3 = $connection->query($sql3);
                            $row3 = $result3->fetch_assoc();
                            echo $row3['Title'];
                        ?>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    <form action="../Team.php" method="post" style="display: inline-block; width: 10%;">
        <Input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        <button type="submit" class="btn info">Back</button>
    </form>
    </div>
</body>
</html>