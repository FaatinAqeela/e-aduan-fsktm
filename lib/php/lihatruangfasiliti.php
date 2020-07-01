<?php
include 'conn.php';

$kod=$_GET['kod'];
                 
$sql=$connect->query("SELECT a.*, b.namaruang, c.namafasiliti 
                        FROM ruang_fasiliti a 
                        LEFT JOIN ruang b on a.ruang_id=b.ruangid 
                        LEFT JOIN fasiliti c on a.fasiliti_id=c.fasiliti_id
                        WHERE ruangfasiliti_id='$kod'");

$data= $sql->fetch_assoc();

echo json_encode($data);

mysqli_close($connect);

?>