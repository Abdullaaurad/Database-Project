<?php
    require_once '../../../Config/config.php';

    $JobRecords = array();
    if (isset($_GET['variableToPass'])) {
        $EmployeeId = $_GET['variableToPass'];
            $sql1 = "SELECT * FROM Job ";
            $result1 = $connection->query($sql1);

            if ($result1->num_rows > 0) {
                while ($row = $result1->fetch_assoc()) {
                    $Job_Id = $row['Job_Id'];
                    $Title = $row['Title'];
                    $Description = $row['Description'];
                    $JobRecords[] = $row;
                }
            }
    }

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];
        $sql1 = "SELECT * FROM Job ";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $Job_Id = $row['Job_Id'];
                $Title = $row['Title'];
                $Description = $row['Description'];
                $JobRecords[] = $row;
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
    <title>Job page</title>

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
    <link rel="stylesheet" type="text/css" href="Job.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="header">
        <h1>Job Openings</h1>
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
<?php foreach ($JobRecords as $record): ?>
<div class="w3-container">
    <div class="w3-card-4" style="width: 90%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>
                <?php 
                    echo $record['Title'];
                ?>
            </h2>
        </header>
        <div class="w3-container w3-white">
        <table>
                <tr>
                    <td>Job Id:</td>
                    <td><?php echo $record['Job_Id'];   $Job_Id=$record['Job_Id']?></td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td><?php echo $record['Description']; ?></td>
                </tr>
        </table>
        <footer class="w3-container w3-white">
            <form action="./Edit/Edit.php" method="post" style="text-align: right; display: inline-block; width: 90%;">
                <button type="submit" class="btn info">Edit</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <input type="hidden" name="Job_Id" value="<?php echo $Job_Id; ?>">
            </form>

            <form action="./Delete/Delete.php" method="post" style="text-align: right; display: inline-block; width: 2%;">
                <button type="submit" class="btn info">Delete</button>
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <input type="hidden" name="Job_Id" value="<?php echo $Job_Id; ?>">
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

