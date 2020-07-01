<?php
include 'conn.php';

$idpengguna=$_GET['idpengguna'];
                 
$sql=$connect->query("SELECT * FROM pengguna WHERE id_pengguna='$idpengguna'");

$data= $sql->fetch_assoc();

echo json_encode($data);

mysqli_close($connect);

?>