<?php
include 'conn.php';


$idjuruteknik=$_GET['idjuruteknik'];

$sql=$connect->query("SELECT a.*, b.namaruang,b.juruteknik_id, c.namafasiliti
						FROM aduan a 
						LEFT JOIN ruang b on a.ruang_id=b.ruangid 
						LEFT JOIN fasiliti c on a.fasiliti_id=c.fasiliti_id 
						WHERE status='tidakselesai' AND b.juruteknik_id='$idjuruteknik'");

$result=array();

while($fetchData=$sql->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

?>