<?php
require_once '../../Config/config.php';
require_once '../Leave/Leave.php';
if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST['EmployeeId'];
        $Name = $_POST['Name'];
        $VacancyId = $_POST['VacancyId'];
        $Contact = $_POST['Contact'];
        $Email = $_POST['Email'];
        
        $sql2 = "INSERT INTO applicant (Name, Contact, Email, Vacancy_Id) VALUES ('$Name', '$Contact', '$Email', '$VacancyId')";
        $result2 = $connection->query($sql2);
        if ($result2) {
            $url = "../Vacancy/Vacancy.php?variableToPass=" . urlencode($EmployeeId);
            header("Location: $url");
            exit;
        } else {
            echo "Failed to update data.";
        }
        
    }
}
?>