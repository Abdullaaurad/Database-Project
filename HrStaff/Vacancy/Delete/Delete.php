<?php
require_once '../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $VacancyId = $_POST['VacancyId'];

        $sql1= "DELETE FROM vacancy WHERE Vacancy_Id='$VacancyId'";
        $result1 = $connection->query($sql1);
        if($result1){
            $url = "../Vacancy.php?variableToPass=" . urlencode($EmployeeId);
            header("Location: $url");
            exit;
        }
        else{
            echo "Error";
        }
    }
}
?>