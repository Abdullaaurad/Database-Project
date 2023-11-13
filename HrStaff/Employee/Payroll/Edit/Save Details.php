<?php
require_once '../../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Pay_slip_No = $_POST["Pay_slip_No"];
        $Date = $_POST['Date'];
        $Salary = $_POST['Salary'];
        $Bonus = $_POST['Bonus'];
        $Allowance = $_POST['Allowance'];
        $Employee_Id  = $_POST['Employee_Id'];


        $sql1="UPDATE payroll SET Date='$Date', Salary='$Salary', Bonus='$Bonus', Allowance='$Allowance', Employee_Id='$Employee_Id' WHERE Pay_slip_No='$Pay_slip_No' ";
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
