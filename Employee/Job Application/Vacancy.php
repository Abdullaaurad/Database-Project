<?php
    require_once '../../Config/config.php';
    $VacancyRecords = array();

    if ($_SERVER['REQUEST_METHOD'] === "POST") {
            $EmployeeId = $_POST["EmployeeId"];
            $VacancyId = $_POST["VacancyId"];
            $Email = $_POST["Email"];
            $sql1 = "SELECT * FROM vacancy WHERE Vacancy_Id='$VacancyId' ";
            $result1 = $connection->query($sql1);
            $row = $result1->fetch_assoc();
            $VacancyRecords[] = $row;
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>One Vacancy page</title>

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
    <link rel="stylesheet" type="text/css" href="Vacancy.css">
</head>
<body>
    <div class="header">
        <h1>Job Opening</h1>
        <form action="../Job Application/Job Application.php" method="post">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <input type="hidden" name="Email" value="<?php echo $Email; ?>">
            <button class="btn info">Back</button>
        </form>
    </div>
    <br>
<div class="w3-container">
    <div class="w3-card-4" style="width: 90%; float: left; margin-right: 10px;">
        <header class="w3-container w3-green">
            <h2>
                <?php 
                    $Job_Id = $row['Job_Id'];
                    $sql2 = "SELECT * FROM job WHERE Job_Id='$Job_Id'";
                    $result2 = $connection->query($sql2);
                    $row1 = $result2->fetch_assoc();
                    $Title = $row1['Title'];
                    echo $Title;
                ?>
            </h2>
        </header>
        <div class="w3-container w3-white">
        <table>
                <tr>
                    <td>Vacancy Id:</td>
                    <td><?php echo $row['Vacancy_Id']; ?></td>
                </tr>
                <tr>
                    <td>Qualification:</td>
                    <td><?php echo $row['Qualification']; ?></td>
                </tr>
                <tr>
                    <td>Job Type:</td>
                    <td><?php echo $row['Type']; ?></td>
                </tr>
                <tr>
                    <td>Salary Range:</td>
                    <td><?php echo $row['Salary_Range']; ?></td>
                </tr>
                <tr>
                    <td>Department </td>
                    <td> 
                        <?php
                            if ($Job_Id >= 1 && $Job_Id <= 5) {
                                echo 'Human Resource';
                            } elseif ($Job_Id >= 6 && $Job_Id <= 10) {
                                echo 'Finance';
                            }
                            elseif ($Job_Id >= 11 && $Job_Id <= 15){
                                echo 'Marketing';
                            }
                            elseif ($Job_Id >= 16 && $Job_Id <= 20) {
                                echo 'Sales';
                            }
                            elseif ($Job_Id >= 21 && $Job_Id <= 25){
                                echo 'Quality Assurance';
                            }
                            elseif ($Job_Id >= 26 && $Job_Id <= 30) {
                                echo 'Research and Development';
                            }
                            elseif ($Job_Id >= 31 && $Job_Id <= 40) {
                                echo 'Information Technology';
                            }
                        ?>
                    </td>
        </table>
        </div>          
        <br>
        <br>
    </div>
</div>
</body>
</html>