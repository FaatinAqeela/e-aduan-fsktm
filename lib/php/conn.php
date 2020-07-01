<?php

//$connect=new mysqli("localhost","id12341650_faatin","FaatinAqeela_96","id12341650_eaduanfsktm");
$connect=new mysqli("localhost","root","","eaduan");
if($connect){
//echo 'connect';
}
else{
    echo "Connection Failed";
    exit();
}


?>