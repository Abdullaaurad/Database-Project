<?php
    $hostname = "localhost";
    $username = "root";
    $password = "";
    $database = "hr_department";
    $port = 3306;

$connection = new mysqli($hostname, $username, $password, $database, $port);

if($connection->connect_error){
    echo "Connection unsuccessfull !".$connection->connect_error;
}