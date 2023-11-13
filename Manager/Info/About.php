<?php

    require_once '../../Config/config.php' ;
    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId = $_POST["EmployeeId"];
        $sql1="SELECT * FROM department WHERE Manager_Id='$EmployeeId' ";
        $result1= $connection->query($sql1);
        if($result1->num_rows >0){
            $row = $result1->fetch_assoc();
            $Name = $row['Name'];
            $Creation_Date = $row['Creation_Date'];
            $Location = $row['Location'];
        }
    }
    
?>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department Details page</title>

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
    <link rel="stylesheet" type="text/css" href="About.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="form-container">
        <div class="col-50">
        <div class="header">
            <H2> Department Details</H2>
        </div>
            <label for="id"><i class="fa fa-user"></i> Manager Id</label>
            <input type="text" id="id" name="EmployeeID" value="<?php echo $EmployeeId; ?>" readonly><br>

            <label for="fname"><i class="fa fa-user"></i> Department Name</label>
            <input type="text" id="fname" name="fname" value="<?php echo $Name; ?>" readonly><br>
            
            <label for="dob"><i class="fa fa-calendar"></i> Creation Date</label>
            <input type="text" id="dob" name="dob" value="<?php echo $Creation_Date; ?>" readonly><br>
            
            <label for="job_id"><i class="fa fa-institution"></i> Job Id</label>
            <input type="text" id="job_id" name="job_id" value="<?php echo $Location; ?>" readonly style="width: 300px;"><br>
        </div>
    </div>
    </div>
    </div>
        <div class="button">
            <form action="../Team/Team.php" method="post">
                <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
                <button type="submit" class="cancel-btn" id="cancelButton">Back</button>
        </form>
        </div>
</html>