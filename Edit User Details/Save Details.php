<?php
require_once '../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Name = $_POST['Name'];
        $DB = $_POST['Date_of_Birth'];
        $Gender = $_POST['Gender'];
        $Address = $_POST['Address'];
        $Contact = $_POST['Contact'];
        $Email = $_POST['Email'];
        $JD = $_POST['Joining_Date'];
        $Department = $_POST['Department'];
        $Job_Id =$_POST['Job_Id'];
        
        $sql2 = "UPDATE employee SET Name='$Name', Date_of_Birth='$DB', Gender='$Gender', Address='$Address', Contact='$Contact', Email='$Email' WHERE Employee_Id = '$EmployeeId'";
        $result2 = $connection->query($sql2);
        $url = "../Info/About.php?variableToPass=" . urlencode($EmployeeId);
        header("Location: $url");
        exit;

        if ($result2) {
            
        } else {
            echo "Failed to update data.";
        }
    }
}
?>



