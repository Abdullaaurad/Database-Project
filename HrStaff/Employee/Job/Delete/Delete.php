<?php
require_once '../../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Job_Id = $_POST['Job_Id'];

        $sql1= "DELETE FROM job WHERE Job_Id='$Job_Id'";
        $result1 = $connection->query($sql1);
        if($result1){
            $url = "../Job.php?variableToPass=" . urlencode($EmployeeId);
            header("Location: $url");
            exit;
        }
        else{
            echo "Error";
        }
    }
}
?>