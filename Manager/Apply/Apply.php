<?php
    require_once '../../Config/config.php';

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId=$_POST['EmployeeId'];
        $VacancyId = $_POST['VacancyId'];
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Application</title>

    <style>
        body {
            background-image: url('../../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="Apply.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <form action="Save.php" method="post">
        <div class="form-container">
            <div class="col-50">
                <div class="header">
                    <H2>Enter Details</H2>
                </div>
                    <label for="Name"><i class="fa fa-calendar"></i>Name</label>
                    <input type="text" id="Name" name="Name" maxlength="30" required><br>

                    <label for="Contact"><i class="fa fa-user"></i>Contact</label>
                    <input type="number" id="Contact" name="Contact" maxlength="10" required><br>
                     
                    <label for="email"><i class="fa fa-envelope"></i> Email Address</label>
                    <input type="text" id="email" name="Email" maxlength="30" required><br>
                    
            </div>
        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <input type="hidden" name="VacancyId" value="<?php echo $VacancyId; ?>">
            <button type="submit" class="cancel-btn" id="SaveButton">Save</button>
        </div>
    </form>
        
        <div class="button">
        <form action="../Vacancy/Vacancy.php" method="post">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </form>
        </div>
    </form>
</html>