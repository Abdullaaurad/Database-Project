<?php
    require_once '../../../Config/config.php';

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId=$_POST['EmployeeId'];
        $Application_Id = $_POST['Application_Id'];

        $sql1="SELECT * FROM applicant WHERE Application_Id='$Application_Id' ";
        $result1 = $connection->query($sql1);
        $row = $result1->fetch_assoc();
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Application</title>

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
                    <label for="Application_Id"><i class="fa fa-user"></i>Application Id</label>
                    <input type="number" id="Application_Id" name="Application_Id" maxlength="5" readonly value="<?php echo $Application_Id ?>"><br>

                    <label for="Name"><i class="fa fa-calendar"></i>Name</label>
                    <input type="text" id="Name" name="Name" maxlength="30" value="<?php echo $row['Name'] ?>" readonly><br>

                    <label for="Contact"><i class="fa fa-user"></i>Contact</label>
                    <input type="number" id="Contact" name="Contact" maxlength="10" value="<?php echo $row['Contact'] ?>" readonly required><br>
                     
                    <label for="Email"><i class="fa fa-envelope"></i> Email Address</label>
                    <input type="text" id="Email" name="Email" maxlength="30"  value="<?php echo $row['Email'] ?>" readonly><br>

                    <label for="Interview_Time"><i class="fa fa-user"></i>InterView Date and Time</label>
                    <input type="datetime" id="Interview_Time" name="Interview_Time" value="<?php echo $row['Interview_Time'] ?>"><br>

                    <label for="Status"><i class="fa fa-envelope"></i> Status</label>
                    <select id="Status" name="Status" required>
                        <option value="Applied" <?php if ($row['Status'] == 'Applied') echo 'selected'; ?>>Applied</option>
                        <option value="Under Review" <?php if ($row['Status'] == 'Under Review') echo 'selected'; ?>>Under Review</option>
                        <option value="Interview Scheduled" <?php if ($row['Status'] == 'Interview Scheduled') echo 'selected'; ?>>Interview Scheduled</option>
                        <option value="Not Selected" <?php if ($row['Status'] == 'Not Selected') echo 'selected'; ?>>Not Selected</option>
                        <option value="Selected" <?php if ($row['Status'] == 'Selected') echo 'selected'; ?>>Selected</option>
                    </select>
            </div>
        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <input type="hidden" name="Application_Id " value="<?php echo $Application_Id ; ?>">
            <button type="submit" class="cancel-btn" id="SaveButton">Save</button>
        </div>
    </form>
        
        <div class="button">
        <form action="../Job Application.php" method="post">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </form>
        </div>
    </form>
</html>