<?php
 
    include 'conn.php';
    $action = $_POST["action"];
    // $action = "GET_ALL";
      // Get all ruang records from the database
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT * from ruang ORDER BY ruangid ASC";
        $result = $connect->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
    //Add an ruang
    if("ADD_EMP" == $action){
        // App will be posting these values to this server
        $namaruang = $_POST["namaruang"];
        $lokasi = $_POST["lokasi"];
        $aras = $_POST["aras"];
        $juruteknik_id = $_POST["juruteknik_id"];
        $sql = "INSERT INTO ruang (namaruang, lokasi,aras,juruteknik_id) VALUES ('$namaruang', '$lokasi','$aras','$juruteknik_id')";
        $result = $connect->query($sql);
        echo "success";
        $connect->close();
        return;
    }
 
    // // Remember - this is the server file.
    // // I am updating the server file.
    // // Update an ruang
    if("UPDATE_EMP" == $action){
        // App will be posting these values to this server
        $ruangid = $_POST['ruangid'];
        $namaruang = $_POST["namaruang"];
        $lokasi = $_POST["lokasi"];
        $aras = $_POST["aras"];
        $juruteknik_id = $_POST["juruteknik_id"];
        $sql = "UPDATE ruang SET namaruang = '$namaruang', lokasi = '$lokasi',aras = '$aras',juruteknik_id = '$juruteknik_id' WHERE ruangid = $ruangid";
        if($connect->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
    // // Delete an ruang
    if('DELETE_EMP' == $action){
        $ruangid = $_POST['ruangid'];
        $sql = "DELETE FROM ruang WHERE ruangid = $ruangid"; // don't need quotes since id is an integer.
        if($connect->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
?>
