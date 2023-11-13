<?php
require_once '../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Name = $_POST['Name'];
        $Creation_Date = $_POST['Creation_Date'];
        $location = $_POST['location'];
        $Manager_Id = $_POST['Manager_Id'];

        $sql2 = "INSERT INTO  department (Name, Creation_Date, location, Manager_Id) VALUES ('$Name', '$Creation_Date', '$location', '$Manager_Id')";
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