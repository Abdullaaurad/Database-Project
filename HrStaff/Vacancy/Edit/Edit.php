<?php

    require_once '../../../Config/config.php' ;
    $JobRecords = Array();

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId = $_POST["EmployeeId"];
        $VacancyId = $_POST["VacancyId"];

        $sql1="SELECT * FROM vacancy WHERE Vacancy_Id='$VacancyId' ";
        $result1= $connection->query($sql1);
        $row = $result1->fetch_assoc();
        $Qualification= $row['Qualification'];
        $Type = $row['Type'];
        $Salary_Range = $row['Salary_Range'];
        $Job_Id  = $row['Job_Id'];

        $sql2 ="SELECT DISTINCT (Title) FROM job ";
        $result2= $connection->query($sql2);
        while ($row = $result2->fetch_assoc()) {
            $JobRecords[] = $row;
        }
    }
    
?>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vacancy Page</title>

    <style>
        body {
            background-image: url('../../../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="Edit.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <form action="./Save Details.php" method="post">
        <div class="form-container">
            <div class="col-50">
                <div class="header">
                    <H2>Edit Vacancy Details</H2>
                </div>
                    <label for="Vacancy_Id"><i class="fa fa-calendar">Vacancy Id </i></label>
                    <input type="text" id="VacancyId" name="VacancyId" value='<?php echo $VacancyId ?>' readonly><br>
                    
                    <label for="Qualification"><i class="fa fa-calendar"></i>Qualification</label>
                    <input type="text" id="Qualification" name="Qualification" maxlength="100" value='<?php echo htmlspecialchars($Qualification, ENT_QUOTES, 'UTF-8'); ?>' size="90%" required><br>
                    
                    <label for="Type"><i class="fa fa-address-card-o"></i> Type </label>
                    <select id="Type" name="Type" required>
                        <option value="Full Time">Full Time</option>
                        <option value="Part Time">Part Time</option>
                        <option value="Temporary Positions">Temporary Positions</option>
                        <option value="Freelance Job">Freelance Job</option>
                    </select>

                    <label for="Salary_Range"><i class="fa fa-venus-mars"></i> Salary Range</label>
                    <input type="text" id="Salary_Range" name="Salary_Range" maxlength="50" value='<?php echo $Salary_Range ?>' required><br>

                    <label for="Title"><i class="fa fa-venus-mars"></i> Job</label>
                    <select id="Title" name="Title" required>
                        <?php foreach ($JobRecords as $record) : ?>
                            <option value="<?php echo $record['Title']; ?>">
                                <?php echo $record['Title']; ?>
                            </option>
                        <?php endforeach; ?>
                    </select>

        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <button type="submit" class="cancel-btn" id="cancelButton">Save</button>
        </div>
    </form>
    <form action="../Vacancy.php" method="post">
        <div class="button">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </div>
    </form>
</html>