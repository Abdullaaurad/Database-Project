<?php
    require_once '../../../Config/config.php' ;

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $EmployeeId = $_POST["EmployeeId"];
        $Employee_Id = $_POST["Employee_Id"];
        $jd = $_POST["jd"];
        $dept = $_POST["dept"];
        $Job_Id = $_POST["Job_Id"];

        $sql2="UPDATE employee SET Joining_Date='$jd', Department='$dept', Job_Id='$Job_Id' WHERE Employee_Id='$Employee_Id' ";
        $result2 = $connection->query($sql2);
        if($result2){
            $url = "./Info.php?variableToPass=" . urlencode($EmployeeId);
            header("Location: $url");
            exit;
        }
        else{
            echo "Error";
        }
    }

