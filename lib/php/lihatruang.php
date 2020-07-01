<?php
 
    include 'conn.php';
    
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
    
?>