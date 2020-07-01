<?php
include 'conn.php';

$ruang_id= $_POST['ruang_id'];
$fasiliti_id= $_POST['fasiliti_id'];
$maklumat= $_POST['maklumat'];
$status= 'disemak';
$gambaraduan=$_FILES['aduanimages']['name'];
$idpengguna=$_POST['idpengguna'];

$imagePath="aduanimages/".$gambaraduan;

move_uploaded_file($_FILES['aduanimages']['tmp_name'],$imagePath);

$connect->query("INSERT INTO aduan (tarikhaduan,ruang_id,fasiliti_id,maklumat,status,gambaraduan,idpengguna) 
                    VALUES (now(),'".$ruang_id."','".$fasiliti_id."','".$maklumat."','".$status."',
                                '".$gambaraduan."','".$idpengguna."')");

?>