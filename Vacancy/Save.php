<?php
require_once '../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["VacancyId"])) {
        $Name = $_POST['Name'];
        $VacancyId = $_POST['VacancyId'];
        $Contact = $_POST['Contact'];
        $Email = $_POST['Email'];
        
        $sql2 = "INSERT INTO applicant (Name, Contact, Email, Vacancy_Id) VALUES ('$Name', '$Contact', '$Email', '$VacancyId')";
        $result2 = $connection->query($sql2);
        if ($result2) {
            $url = "./Vacancy.php?variableToPass=";
            header("Location: $url");
            exit;
        } else {
            echo "Failed to update data.";
        }
        
    }
}
?>