<?php
include 'conn.php';


$idpengguna=$_GET['idpengguna'];

$sql=$connect->query("SELECT a.*, b.namaruang, c.namafasiliti
					   FROM aduan a 
					   LEFT JOIN ruang b on a.ruang_id=b.ruangid 
					   LEFT JOIN fasiliti c on a.fasiliti_id=c.fasiliti_id 	
					   WHERE status='disemak' AND idpengguna='$idpengguna'");

$result=array();

while($fetchData=$sql->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

?>