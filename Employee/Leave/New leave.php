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
    <title>Request Leave Page</title>

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
    <link rel="stylesheet" type="text/css" href="New leave.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <form action="../Leave/Save Details.php" method="post">
        <div class="form-container">
            <div class="col-50">
                <div class="header">
                    <H2>Enter Leave Details</H2>
                </div>
                    <label for="CD"><i class="fa fa-calendar"></i>Commencement Date</label>
                    <input type="Date" id="CD" name="Commencement_Date" required><br>
                    
                    <label for="CUD"><i class="fa fa-venus-mars"></i> Conclusion Date</label>
                    <input type="Date" id="CUD" name="Conclusion_Date" required><br>
                    
                    <label for="Type"><i class="fa fa-address-card-o"></i> Type</label>
                    <select id="Type" name="Type" required>
                        <option value="Value1">Sick Leave</option>
                        <option value="Value2">Vacation</option>
                        <option value="Value3">Parental Leave</option>
                        <option value="Value4">Maternity Leave</option>
                        <option value="Value5">Other</option>
                </select><br>
        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <button type="submit" class="cancel-btn" id="cancelButton">Save</button>
        </div>
    </form>
    <form action="../Leave/Leave.php" method="post">
        <div class="button">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </div>
    </form>
</html>