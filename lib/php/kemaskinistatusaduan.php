<?php

    include 'conn.php';

    $aduan_id = $_POST['aduan_id'];
    $status = $_POST['status'];
    
    $sql="UPDATE aduan SET status='".$status."' WHERE aduan_id='".$aduan_id."'";
    
    if(mysqli_query($connect,$sql)){
        $response['value']=1;
        echo json_encode($response);
    }

?>



