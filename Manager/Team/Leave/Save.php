<?php
require_once '../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $EmployeeId = $_POST["EmployeeId"];
    $Id = $_POST['Id'];
    $Commencement_Date= $_POST["Commencement_Date"];

    $sql1="UPDATE employee_leave SET Acceptance='Yes'  WHERE Employee_Id = '$Id' AND Commencement_Date='$Commencement_Date' ";
    $result1 = $connection->query($sql1);
    $url = "./New%20Leave.php?variableToPass=" . urlencode($EmployeeId);
    header("Location: $url");
    exit;
}