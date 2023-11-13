<?php
require_once '../../../../Config/config.php';

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    if (isset($_POST["EmployeeId"])) {
        $EmployeeId = $_POST["EmployeeId"];
        $Title = $_POST['Title'];
        $Description = $_POST['Description'];

        $sql1 = "INSERT INTO Job (`Title`, `Description`) VALUES ('$Title', '$Description')";
        $result1=$connection->query($sql1);
            if ($result1) {
                $url = "../Job.php?variableToPass=" . urlencode($EmployeeId);
                header("Location: $url");
                exit;
            } else {
                echo "Failed to update data.";
            }
        }

    }
?>
