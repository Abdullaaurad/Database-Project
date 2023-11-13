<?php
require_once '../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $VacancyId = $_POST['VacancyId'];
        $Qualification = $_POST['Qualification'];
        $Type = $_POST['Type'];
        $Salary_Range = $_POST['Salary_Range'];
        $Title = $_POST['Title'];

        // Use prepared statement for the SELECT query
        $stmt1 = $connection->prepare("SELECT Job_Id FROM job WHERE Title = ?");
        $stmt1->bind_param("s", $Title);
        $stmt1->execute();
        $stmt1->store_result();

        if ($stmt1->num_rows > 0) {
            $stmt1->bind_result($Job_Id);
            $stmt1->fetch();

            // Use prepared statement for the UPDATE query
            $stmt2 = $connection->prepare("UPDATE vacancy SET Qualification=?, Type=?, Salary_Range=?, Job_id=? WHERE Vacancy_Id=?");
            $stmt2->bind_param("sssss", $Qualification, $Type, $Salary_Range, $Job_Id, $VacancyId);
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
