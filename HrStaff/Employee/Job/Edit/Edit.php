<?php

    require_once '../../../../Config/config.php' ;
    $JobRecords = Array();

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId = $_POST["EmployeeId"];
        $Job_Id = $_POST["Job_Id"];

        $sql1="SELECT * FROM job WHERE Job_Id='$Job_Id' ";
        $result1= $connection->query($sql1);
        $row = $result1->fetch_assoc();
        $Title= $row['Title'];
        $Description = $row['Description'];

    }
    
?>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Job Page</title>

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
    <link rel="stylesheet" type="text/css" href="Edit.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <form action="./Save Details.php" method="post">
        <div class="form-container">
            <div class="col-50">
                <div class="header">
                    <H2>Edit Job Details</H2>
                </div>
                    <label for="Title"><i class="fa fa-calendar">Job Title </i></label>
                    <input type="Name" id="text" name="Title" value='<?php echo $Title ?>' maxlength="30"><br>
                    
                    <label for="Description"><i class="fa fa-calendar"></i> Job Description</label>
                    <input type="text" id="Description" name="Description" maxlength="100" value='<?php echo $Description; ?>' size="90%" required><br>
        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <input type="hidden" name="Job_Id" value="<?php echo $Job_Id; ?>">
            <button type="submit" class="cancel-btn" id="cancelButton">Save</button>
        </div>
    </form>
    <form action="../Job.php" method="post">
        <div class="button">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </div>
    </form>
</html>