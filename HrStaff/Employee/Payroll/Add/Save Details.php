<?php
require_once '../../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Date = $_POST['Date'];
        $Salary = $_POST['Salary'];
        $Bonus = $_POST['Bonus'];
        $Allowance = $_POST['Allowance'];
        $Employee_Id  = $_POST['Employee_Id'];

        $sql1 = "INSERT INTO payroll (`Date`, `Salary`, `Bonus`, `Allowance`, `Employee_Id`) VALUES ('$Date', '$Salary', '$Bonus', '$Allowance', '$Employee_Id')";
        $result1=$connection->query($sql1);
            if ($result1) {
                $url = "../Payroll.php?variableToPass=" . urlencode($EmployeeId);
                header("Location: $url");
                exit;
            } else {
                echo "Failed to update data.";
            }
        }

    }
?>
