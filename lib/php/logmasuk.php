<?php

    include 'conn.php';

    $idpengguna = $_POST['id_pengguna'];
    $katalaluan = $_POST['katalaluan'];
    
    $sql=$connect->query("SELECT * FROM pengguna WHERE id_pengguna='".$idpengguna."' AND katalaluan='".$katalaluan."'");

    $result=array();

    while($data=$sql->fetch_assoc()){
        $result[]=$data;
        
      }
    echo json_encode($result);
?>