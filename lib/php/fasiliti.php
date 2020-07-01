<?php


    include 'conn.php';
    $action = $_POST["action"];
    // $action = "GET_ALL";
      // Get all employee records from the database
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT * from fasiliti ORDER BY fasiliti_id ASC";
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
 
    //Add an Employee
    if("ADD" == $action){
        // App will be posting these values to this server
        $namafasiliti = $_POST["namafasiliti"];
        $sql = "INSERT INTO fasiliti (namafasiliti) VALUES ('$namafasiliti')";
        $result = $connect->query($sql);
        echo "success";
        $connect->close();
        return;
    }
 
    // // Remember - this is the server file.
    // // I am updating the server file.
    // // Update an Employee
    if("UPDATE" == $action){
        // App will be posting these values to this server
         $fasiliti_id = $_POST['fasiliti_id'];
         $namafasiliti = $_POST["namafasiliti"];
         
        $sql = "UPDATE fasiliti SET namafasiliti = '$namafasiliti'  WHERE fasiliti_id =$fasiliti_id";
        if($connect->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
    // // Delete an Employee
    if('DELETE' == $action){
        $fasiliti_id = $_POST['fasiliti_id'];
        $sql = "DELETE FROM fasiliti WHERE fasiliti_id = $fasiliti_id"; // don't need quotes since id is an integer.
        if($connect->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $connect->close();
        return;
    }
 
?>
