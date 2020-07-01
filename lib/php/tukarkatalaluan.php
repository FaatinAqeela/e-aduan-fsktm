<?php

    include 'conn.php';

    $idpengguna= $_GET['idpengguna'];
    $katalaluanbaru = $_POST['katalaluanbaru'];

    $sql="UPDATE pengguna SET katalaluan='".$katalaluanbaru."' WHERE id_pengguna='".$idpengguna."'";

    if(mysqli_query($connect,$sql)){
        $response['value']=1;
        echo json_encode($response);
    }
?>

