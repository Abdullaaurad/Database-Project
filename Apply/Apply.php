<?php 
    require_once'../Config/config.php';
    $ApplicantRecords = array();

    if($_SERVER['REQUEST_METHOD'] === "POST"){
        $Email= $_POST['Email'];
        $sql1="SELECT * FROM applicant WHERE Email='$Email' ";
        $result1 = $connection->query($sql1);
        if($result1->num_rows >0){
            while ($row = $result1->fetch_assoc()){
                $ApplicantRecords[] = $row;
            }
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Application Page</title>

    <style>
        body {
            background-image: url('../Image/04.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="Apply.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
<body>

    <div class="header">
        <h1>Applications</h1>
        <form action="../index.php" method="post">
            <button class="btn view">Back</button>
        </form>
    </div><br><br>
    <?php if (empty($Email)) : ?>
        <label for="userInput">Enter Email: </label>
        <input type="text" id="userInput">
        <button onclick="storeAndDisplay()" style="font-size: 14px;">Submit</button>
    <?php endif; ?>

    <br>

    <script>
        function storeAndDisplay() {
        var userInput = document.getElementById('userInput').value;
        var form = document.createElement('form');
        form.action = 'Apply.php';
        form.method = 'get';
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'userInput';
        input.value = userInput;
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
}

    </script>
    <?php
        $userInput = isset($_GET['userInput']) ? $_GET['userInput'] : '';
        $sql1="SELECT * FROM applicant WHERE Email='$userInput' ";
        $result1 = $connection->query($sql1);
        if($result1->num_rows >0){
            while ($row = $result1->fetch_assoc()){
                $ApplicantRecords[] = $row;
            }
        }
    ?>
    <br>
    <?php if (!empty($ApplicantRecords)) : ?>
    <div class="table-container">
        <table>
            <tr>
                <th>Applicant Id</th>
                <th>Name</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Interview Date and Time</th>
                <th>Status</th>
                <th>Vacancy_Id</th>
            </tr>
            <?php foreach ($ApplicantRecords as $record) : ?>
                <tr>
                    <td><?php echo $record['Application_Id']; ?></td>
                    <td><?php echo $record['Name']; ?></td>
                    <td><?php echo $record['Email']; ?></td>
                    <td><?php echo $record['Contact']; ?></td>
                    <td><?php echo $record['Interview_Time']; ?></td>
                    <td><?php echo $record['Status']; ?></td>
                    <td>
                        <form action="./Vacancy.php" method="post" style="display: inline-block;">
                            <input type="hidden" name="VacancyId" value="<?php echo $record['Vacancy_Id']; ?>">
                            <input type="hidden" name="Email" value="<?php echo $record['Email']; ?>">
                            <button type="submit"><?php echo $record['Vacancy_Id']; ?></button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
    <?php endif; ?>
</body>
</html>
