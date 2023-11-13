<?php

    require_once '../../Config/config.php' ;

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
    <title>Add department Page</title>

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
    <link rel="stylesheet" type="text/css" href="Add department.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <form action="./New Save Details.php" method="post">
        <div class="form-container">
            <div class="col-50">
                <div class="header">
                    <H2>Enter Department Details</H2>
                </div>
                    <label for="Name"><i class="fa fa-calendar"></i>Department Name</label>
                    <input type="text" id="Name" name="Name"  maxlength="30" required><br>
                    
                    <label for="CD"><i class="fa fa-venus-mars"></i> Creation Date</label>
                    <input type="Date" id="CD" name="Creation_Date" required><br>
                    
                    <label for="location"><i class="fa fa-address-card-o"></i>Address</label>
                    <input type="text" id="location" name="location" maxlength="100" required><br>

                    <label for="Manager_Id"><i class="fa fa-venus-mars"></i> Manager Id</label>
                    <input type="text" id="Manager_Id" name="Manager_Id" maxlength="12" required><br>
        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <button type="submit" class="cancel-btn" id="cancelButton">Save</button>
        </div>
    </form>
    <form action="./Department.php" method="post">
        <div class="button">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </div>
    </form>
</html>