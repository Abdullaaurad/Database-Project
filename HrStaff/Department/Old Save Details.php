<?php
require_once '../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Name = $_POST['Name'];
        $Creation_Date = $_POST['Creation_Date'];
        $location = $_POST['location'];
        $Manager_Id = $_POST['Manager_Id'];
        $OldDepartment = $_POST['OldDepartment'];

        $sql2 = "UPDATE department SET Name='$Name', Creation_Date='$Creation_Date', location='$location', Manager_Id='$Manager_Id' WHERE Name='$OldDepartment' ";
        $result2 = $connection->query($sql2);
        $url = "./Department.php?variableToPass=" . urlencode($EmployeeId);
        header("Location: $url");
        exit;

        if ($result2) {
            
        } else {
            echo "Failed to update data.";
        }
    }
}
?>