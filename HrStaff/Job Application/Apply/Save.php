<?php
require_once '../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST['EmployeeId'];
        $Application_Id = $_POST['Application_Id'];
        $Interview_Time = $_POST['Interview_Time'];
        $Status = $_POST['Status'];

        $sql2 = "UPDATE applicant SET Interview_Time='$Interview_Time', Status='$Status' WHERE Application_Id='$Application_Id' ";
        $result2 = $connection->query($sql2);
        if ($result2) {
            $url = "../Job%20Application.php?variableToPass=" . urlencode($EmployeeId);
            header("Location: $url");
            exit;
        } else {
            echo "Failed to update data.";
        }
        
    }
}
?>