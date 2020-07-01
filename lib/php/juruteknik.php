<?php
 
    include 'conn.php';
    $action = $_POST["action"];
    //$action = "ADD";
    
    
    // Get all employee records from the database
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT * from pengguna WHERE kategoripengguna='juruteknik' ORDER BY id_pengguna ASC";
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
 
    // //Add an juruteknik
    if("ADD" == $action){
        // App will be posting these values to this server
        $juruteknik_id = $_POST["id_pengguna"];
        $namapenuh = $_POST["namapenuh"];
        $nombortelefon = $_POST["nombortelefon"];
        $jabatan = $_POST["jabatan"];
        $katalaluan = 'J1234';
        $kategoripengguna = 'juruteknik';
        
        $query = mysqli_query($connect, "SELECT * FROM pengguna WHERE id_pengguna='".$juruteknik_id."'");

        if(mysqli_num_rows($query) > 0){
        
            echo "idpengguna telah wujud";
        }
        else
        {   $sql = "INSERT INTO pengguna (id_pengguna,namapenuh,nombortelefon,jabatan,katalaluan,kategoripengguna, gambarpengguna) VALUES ('$juruteknik_id','$namapenuh','$nombortelefon','$jabatan','$katalaluan','$kategoripengguna','')";
            $result = $connect->query($sql);
            echo "success";
            
        }
        $connect->close();
        return;
    }
 
    // // // Remember - this is the server file.
    // // // I am updating the server file.
    // // // Update an Employee
    if("UPDATE" == $action){
        // App will be posting these values to this server
        $juruteknik_id = $_POST['id_pengguna'];
        $namapenuh = $_POST["namapenuh"];
        $nombortelefon = $_POST["nombortelefon"];
        $jabatan = $_POST["jabatan"];
        $sql = "UPDATE pengguna SET namapenuh = '$namapenuh', nombortelefon = '$nombortelefon',jabatan = '$jabatan' WHERE id_pengguna ='$juruteknik_id'";
        if($connect->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
    // // // Delete an Employee
    if('DELETE' == $action){
        $juruteknik_id = $_POST['id_pengguna'];
        $sql = "DELETE FROM pengguna WHERE id_pengguna = '$juruteknik_id'"; // don't need quotes since id is an integer.
        if($connect->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
?>