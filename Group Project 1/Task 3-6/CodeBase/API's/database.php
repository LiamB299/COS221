<?php

class Database {
    public static function instance() {
        static $instance = null;
        if($instance === null)
            $instance = new Database();
        return $instance;
    }

    private $host = "localhost";
    private $user = /*"u18015001";//*/"root";
    private $pass = /*"ORW5ZEPNIWANRQGTICMKOLHXDYVVBQVX";//*/"L19m2992@root";
    private $name = /*"u18015001_gameculture";//*/"municipality_elections";

    //connect first time
    private function __construct() {
        $connection = new mysqli($this->host, $this->user, $this->pass);

        if($connection->connect_error)
            die("First time connection failure -> " . $connection->connect_error);

        $connection->select_db($this->name);
        //echo "First time success!";
        $connection->close();
    }

    //connect
    private function connect() {
        $connection = new mysqli($this->host, $this->user, $this->pass);

        if($connection->connect_error)
            die("Connection failure -> " . connect_error);

        $connection->select_db($this->name);
        //echo "Connection success!";
        return $connection;
    }

    private function close($connection) {
        $connection->close();
    }

    //disconnect
    public function __destruct() {
    }

    //perform duplicate validation and return result
    public function is_duplicate_entry($table, $fieldname, $field) {
        $connection = $this->connect();
        $sql = "select * from ".$table." where ".$fieldname."=?";
        $query = $connection->prepare($sql);
        $query->bind_param("s",$field);
        if($query->execute() == false) {
            echo "select error";
        }
        //var_dump($query->num_rows);
        $result = $query->get_result();
        //var_dump($result->num_rows);
        $tuples = $result->fetch_all(MYSQLI_ASSOC);
        //var_dump($tuples);
        $this->close($connection);

        if($result->num_rows >0)
            return true;

        return false;
    }

    function user_exists($table, $f1, $v1, $f2, $v2, $types) {
        $connection = $this->connect();
        $sql = "select * from ".$table." where ".$f1."=? and ".$f2." =?";
        $query = $connection->prepare($sql);
        $data = [$v1, $v2];
        $query->bind_param($types,...$data);
        if($query->execute() == false) {
            echo "user exists error";
        }
        //var_dump($query->num_rows);
        $result = $query->get_result();
        //var_dump($result->num_rows);
        $tuples = $result->fetch_all(MYSQLI_ASSOC);
        //var_dump($tuples);
        //var_dump($tuples);
        $this->close($connection);

        if(count($tuples) == 1)
            return true;

        return false;
    }

    // $data must be in order of insertion for db
    public function insert_record($table, $data, $types) {
        //var_dump($data);
        $connection = $this->connect();

        $sql = "INSERT INTO ".$table." VALUES (";
        
        foreach($data as $val) {
            $sql .= "?, ";
        }
        $sql = substr($sql, 0, strlen($sql)-2);
        $sql .=")";

        $query = $connection->prepare($sql);
        $query->bind_param($types,...$data);
        
        if($query->execute() == false) {
            echo $connection->error;
        }        

        $this->close($connection);
    }

    // one at a time for simplification
    public function update_record($table, $s_col, $s_new, $w_col, $w_val, $type) {
        $connection = $this->connect();  
        
        $sql = "UPDATE ".$table." SET ".$s_col."=? WHERE ".$w_col."=".$w_val;
        //echo $sql;

        $query = $connection->prepare($sql);
        $query->bind_param($type,$s_new);

        if($query->execute() == false) {
            echo "update failure";
        }
        
        $this->close($connection);

        return true;
    }

    public function encode_password($pass) {
        return $pass;
        $pass = substr($pass, 0, strlen($pass)/2).$pass;
        $pass = password_hash($pass, PASSWORD_ARGON2I);
        $pos = strpos($pass,"p=");
        return substr($pass, $pos+2, 10);
    }

    public function getValues($table, $w_col, $w_val, $types, $get="*") {
        $connection = $this->connect(); 

        if(!is_int($w_col))
            $w_col = "`".$w_col."`";
        $sql = "SELECT ".$get." FROM ".$table." WHERE ".$w_col."=?";
        $query = $connection->prepare($sql);
        //echo $sql;
        $query->bind_param($types, $w_val);

        if($query->execute() == false) {
            echo "select rows failed";
        }



        if($result = $query->get_result()) {
            $result = $result->fetch_all(MYSQLI_ASSOC);
            $this->close($connection);
            return $result;
        }
        else {
            $this->close($connection);
            return null;
        }
    }

    function getValuesCustom($sql) {
        $connection = $this->connect();

        $query = $connection->prepare($sql);

        if($query == false)
            echo $connection->error;

        $query->execute();
        if($query->execute() == false) {
            echo "select rows failed";
        }

        if($result = $query->get_result()) {
            $result = $result->fetch_all(MYSQLI_ASSOC);
            $this->close($connection);
            return $result;
        }
        else {
            $this->close($connection);
            return null;
        }
    }
}