<?php
include 'conn.php';

$namaruang= $_POST['ruang_id'];
$lokasi= $_POST['lokasi'];
$aras= $_POST['aras'];
$juruteknik= $_POST['juruteknik'];

$connect->query("INSERT INTO ruang (namaruang,lokasi,aras,juruteknik) 
                    VALUES ('".$namaruang."','".$lokasi."','".$aras."','".$juruteknik."')");

?>