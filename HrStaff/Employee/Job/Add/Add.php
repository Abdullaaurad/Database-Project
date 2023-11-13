<?php

    require_once '../../../../Config/config.php' ;
    $JobRecords = Array();

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId = $_POST["EmployeeId"];
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
            background-image: url('../../../../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="Add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <form action="./Save Details.php" method="post">
        <div class="form-container">
            <div class="col-50">
                <div class="header">
                    <H2>Add Job Details</H2>
                </div>
                    <label for="Title"><i class="fa fa-calendar"></i>Job Title</label>
                    <input type="text" id="Title" name="Title" maxlength="30" size="50%" required><br>

                    <label for="Description"><i class="fa fa-venus-mars"></i> Job Description</label>
                    <input type="text" id="Description" name="Description" size="70%" maxlength="100" required><br>
                    <br>
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