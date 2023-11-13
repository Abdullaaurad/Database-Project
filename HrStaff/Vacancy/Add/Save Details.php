<?php
require_once '../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Qualification = $_POST['Qualification'];
        $Type = $_POST['Type'];
        $Salary_Range = $_POST['Salary_Range'];
        $Title = $_POST['Title'];

        $stmt1 = $connection->prepare("SELECT Job_Id FROM job WHERE Title = ?");
        $stmt1->bind_param("s", $Title);
        $stmt1->execute();
        $stmt1->store_result();

        if ($stmt1->num_rows > 0) {
            $stmt1->bind_result($Job_Id);
            $stmt1->fetch();

            $stmt2 = $connection->prepare("INSERT INTO vacancy (`Qualification`, `Type`, `Salary_Range`, `Job_Id`) VALUES (?,?,?,?)");
            $stmt2->bind_param("ssss", $Qualification, $Type, $Salary_Range, $Job_Id);
            $stmt2->execute();


            if ($stmt2) {
                $url = "../Vacancy.php?variableToPass=" . urlencode($EmployeeId);
                header("Location: $url");
                exit;
            } else {
                echo "Failed to update data.";
            }
        }

    }
}
?>
