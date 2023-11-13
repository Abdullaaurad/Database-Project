<?php
require_once '../../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Pay_slip_No = $_POST['Pay_slip_No'];

        $sql1= "DELETE FROM payroll WHERE Pay_slip_No='$Pay_slip_No'";
        $result1 = $connection->query($sql1);
        if($result1){
            $url = "../Payroll.php?variableToPass=" . urlencode($EmployeeId);
            header("Location: $url");
            exit;
        }
        else{
            echo "Error";
        }
    }
}
?>