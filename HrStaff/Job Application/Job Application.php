<?php
    require_once '../../Config/config.php';

    $ApplicantRecords = array();

    if (isset($_GET['variableToPass'])) {
        $EmployeeId = $_GET['variableToPass'];
        $sql1 = "SELECT * FROM applicant ;";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $ApplicantRecords[] = $row;
            }
        }
    }

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
        $EmployeeId = $_POST["EmployeeId"];

        $sql1 = "SELECT * FROM applicant ;";
        $result1 = $connection->query($sql1);

        if ($result1->num_rows > 0) {
            while ($row = $result1->fetch_assoc()) {
                $ApplicantRecords[] = $row;
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
    <title>Applications page</title>

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
    <link rel="stylesheet" type="text/css" href="Job Application.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
<body>
<div class="header">
        <h1>Job Applications</h1>
    </div>
    <div class="table-container">
        <table align="left">
            <tr>
                <th>Applicant Id</th>
                <th>Name</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Interview Date and Time</th>
                <th>Status</th>
                <th>Vacancy_Id</th>
                <th></th>
            </tr>
            <?php foreach ($ApplicantRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Application_Id']; $Application_Id=$record['Application_Id']; ?></td>
                    <td><?php echo $record['Name']; ?></td>
                    <td><?php echo $record['Email']; ?></td>
                    <td><?php echo $record['Contact']; ?></td>
                    <td><?php echo $record['Interview_Time']; ?></td>
                    <td><?php echo $record['Status']; ?></td>
                    <td>
                        <form action="./Vacancy.php" method="post" style="display: inline-block;">
                            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                            <input type="hidden" name="VacancyId" value="<?php echo $record['Vacancy_Id']; ?>">
                            <input type="hidden" name="Email" value="<?php echo $record['Email']; ?>">
                            <button type="submit"><?php echo $record['Vacancy_Id']; ?></button>
                        </form>
                    </td>
                    <td>
                    <form action="./Apply/Apply.php" method="post" style="display: inline-block;">
                        <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                        <input type="hidden" name="Application_Id" value="<?php echo $Application_Id ; ?>">
                        <button type="submit"> Edit</button>
                    </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    <form action="../Hr Staff.php" method="post" style="display: inline-block; width: 10%;">
        <Input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        <button type="submit" class="btn info">Back</button>
    </form>
    </div>
</body>
</html>    