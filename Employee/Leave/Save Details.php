<?php
require_once '../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        echo "hi";
        $EmployeeId = $_POST["EmployeeId"];
        $Commencement_Date = $_POST['Commencement_Date'];
        $Conclusion_Date = $_POST['Conclusion_Date'];
        $Type = $_POST['Type'];

        $sql2 = "INSERT INTO  employee_leave (Employee_Id, Commencement_Date, Conclusion_Date, Type) VALUES ('$EmployeeId', '$Commencement_Date', '$Conclusion_Date', '$Type')";
        $result2 = $connection->query($sql2);
        $url = "../Leave/Leave.php?variableToPass=" . urlencode($EmployeeId);
        header("Location: $url");
        exit;

        if ($result2) {
            
        } else {
            echo "Failed to update data.";
        }
    }
}
?>