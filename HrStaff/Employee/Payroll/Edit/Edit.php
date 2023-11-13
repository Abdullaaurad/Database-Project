<?php

    require_once '../../../../Config/config.php' ;
    $PayrollRecords = Array();

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId = $_POST["EmployeeId"];
        $Pay_slip_No = $_POST['Pay_slip_No'];

        $sql1="SELECT * FROM payroll WHERE Pay_Slip_No='$Pay_slip_No' ";
        $result1= $connection->query($sql1);
        $row = $result1->fetch_assoc();
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
                    <H2>Edit Payroll Details</H2>
                </div>
                    <label for="Pay_slip_No"><i class="fa fa-calendar"></i>Pay slip No</label>
                    <input type="number" id="Pay_slip_No" name="Pay_slip_No" value="<?php echo $Pay_slip_No ?>" readonly><br>

                    <label for="Date"><i class="fa fa-calendar"></i>Issue Date</label>
                    <input type="date" id="Date" name="Date" value="<?php echo $row['Date'] ?>" required><br>

                    <label for="Salary"><i class="fa fa-calendar"></i>Salary</label>
                    <input type="number" id="Salary" name="Salary" maxlength="8" value="<?php echo $row['Salary'] ?>" required><br>

                    <label for="Bonus"><i class="fa fa-calendar"></i>Bonus</label>
                    <input type="number" id="Bonus" name="Bonus" maxlength="8" value="<?php echo $row['Bonus'] ?>" required><br>

                    <label for="Allowance"><i class="fa fa-calendar"></i>Allowance</label>
                    <input type="number" id="Allowance" name="Allowance" maxlength="8" value="<?php echo $row['Allowance'] ?>" required><br>

                    <label for="Employee_Id"><i class="fa fa-venus-mars"></i> Employee Id</label>
                    <input type="text" id="Employee_Id" name="Employee_Id"  maxlength="12" value="<?php echo $row['Employee_Id'] ?>" required><br>
                    <br>
        </div>
    
        <div class="button">
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
            <input type="hidden" name="Pay_slip_No" value="<?php echo $Pay_slip_No ; ?>">
            <button type="submit" class="cancel-btn" id="cancelButton">Save</button>
        </div>
    </form>
    <form action="../Payroll.php" method="post">
        <div class="button">
            <button type="submit" class="cancel-btn" id="cancelButton">Cancel</button>
            <input type="hidden" name="EmployeeId" value="<?php echo $EmployeeId; ?>">
        </div>
    </form>
</html>