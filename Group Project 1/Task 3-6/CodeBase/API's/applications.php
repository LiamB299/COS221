<?php

    require("database.php");

//========================================

    function response($data) {
        header("Content-Type: application/json; charset=UTF-8");
        header("HTTP/1.1 200 OK");

        echo json_encode (
            $data
        );
    }

    function error_response($message) {
        response([
            "status" => "error",
            "message" => $message
        ]);
    }

//========================================

    if(isset($_POST["type"])) {
       if($_POST["type"]=="apply") {
           if(isset($_POST["group"])) {
               if($_POST["group"]=="voter") {
                   if(validate_voter()) {
                       response("here");
                       create_Voter();
                       return;
                   }
                   else {

                       return;
                   }
               }
               else if($_POST["group"]=="ward") {
                   if(validate_ward()) {
                       create_ward();
                       return;
                   }
                   else {

                       return;
                   }
               }
               else if($_POST["group"]=="staff") {
                   if(validate_iec()) {
                       create_staff();
                       return;
                   }
                   else {
                       return;
                   }
               }
               else if($_POST["group"]=="party-first") {
                   if(validate_party_first()) {
                       create_party();
                       return;
                   }
                   else {

                       return;
                   }
               }
               else if($_POST["group"]=="party-second") {
                   if(validate_party_cand()) {
                       create_party_cand_reg();
                       return;
                   }
                   else {
                       return;
                   }
               }
               else {
                   response([
                       "status" => "error",
                       "message" => "group not recognized"
                   ]);
                   return;
               }
           }
           else {
               response([
                   "status" => "error",
                   "message" => "group not set"
               ]);
               return;
           }
       }
       else if($_POST["type"]=="update") {
            if(isset($_POST["key"])) {

            }
            else {
                response([
                    "status" => "error",
                    "message" => "API Key not set"
                ]);
                return;
            }
       }
       else {
           response([
               "status" => "error",
               "message" => "type not recognized"
           ]);
           return;
       }
    }
    else {
        response([
           "status" => "error",
           "message" => "type not set"
        ]);
        return;
    }

//=======================================

function validate_voter() {
    if(isset($_POST["province"])==false || isset($_POST["id"])==false || isset($_POST["pass1"])==false
        || isset($_POST["pass2"])==false || isset($_POST["address"])==false || isset($_POST["mun_code"])==false) {
        error_response("a voter field is empty");
        return false;
    }
    else {
        if(!preg_match("/^(gauteng|limpopo|mpumalanga|north-west|western-cape|northern-cape|eastern-cape|kwa-zulu-natal|free-state)$/i",$_POST["province"])) {
           error_response("province ".$_POST["province"]." not listed");
           return false;
        }
        if(!validateIDCode($_POST["id"])) {
            error_response("id: ".$_POST["id"]." invalid");
            return false;
        }
        if(!validatePass($_POST["pass1"])) {
            error_response("password: ".$_POST["pass1"]." invalid");
            return false;
        }
        if(!validateAddress($_POST["address"])) {
            error_response("address is invalid");
            return false;
        }
        if(Database::instance()->is_duplicate_entry("voter","id_no", $_POST["id"])) {
            error_response("User ID found. User exists");
            return false;
        }
        if($_POST["pass1"]!=$_POST["pass2"] || validatePass($_POST["pass1"])==false
            || validatePass($_POST["pass2"])==false) {
            error_response("Passwords are incorrect");
            return false;
        }
    }
    return true;
}


function create_Voter() {
        $age = substr($_POST["id"],0,2);
        $age = 100+21-intval($age);
        $data = [
            $_POST["id"],
            $_POST["address"],
            $age,
            $_POST["mun_code"],
            Database::instance()->encode_password($_POST["pass1"]),
            0,
            0
        ];
        $types = "ssissii";
        Database::instance()->insert_record("voter", $data, $types);
        response([
            "status" => "voting-success"
        ]);
        return true;
}


//=======================================

function validate_party_first() {
    if(isset($_POST["pass1"])==false || isset($_POST["pass2"])==false || isset($_POST["name"])==false) {
        error_response("Not all fields are set");
        return false;
    }
    if(validateWord($_POST["name"])==false) {
        error_response("Name is invalid");
        return false;
    }
    if($_POST["pass1"]!=$_POST["pass2"] || validatePass($_POST["pass1"])==false
        || validatePass($_POST["pass2"])==false) {
        error_response("Passwords are incorrect");
        return false;
    }
    return true;
}

function create_party() {
    $party_no = Database::instance()->getValues("party", 1, 1, "i", "*");

    $data = [
        count($party_no),
        $_POST["name"],
        0,
        Database::instance()->encode_password($_POST["pass1"])
    ];

    Database::instance()->insert_record("party", $data, "ssis");

    response([
        "status" => "success",
        "code" => $party_no
    ]);

    return true;

}

//=======================================

function validate_party_cand() {
    if(isset($_POST["pass"])==false || isset($_POST["p_no"])==false || isset($_POST["mun_code"])==false
        || isset($_POST["dist"])==false) {
        error_response("A field is not set.");
        return false;
    }
    if(!Database::instance()->is_duplicate_entry("party","party_no",$_POST["p_no"])) {
        error_response("Party not found");
        return false;
    }
    if(validateMunCode($_POST["mun_code"])==false) {
        error_response("Municipal code format is incorrect");
        return false;
    }
    if(!Database::instance()->is_duplicate_entry("municipality","municipal_code",$_POST["mun_code"])) {
        error_response("Municipal code not found");
        return false;
    }
    if($_POST["dist"]==false) {
        error_response("No Municipality type specified");
        return false;
    }
    return true;
}

function create_party_cand_reg() {
    $cand_no = Database::instance()->getValues("candidate", 1, 1, "i", "*");

    $dist =1;

    if($_POST["dist"]=="false")
        $dist =0;

    $local =1;

    $data = [
        count($cand_no),
        $_POST["mun_code"],
        0,
        1,
        0
    ];

    Database::instance()->insert_record("candidate", $data, "ssiii");

    $data = [
        count($cand_no),
        $dist,
        $local
    ];

    Database::instance()->insert_record("proportional_representatives", $data, "sii");

    if($dist==1) {
        $data = [
            count($cand_no),
            $_POST["p_no"]
        ];
        Database::instance()->insert_record("pr_dist", $data, "ss");
    }

    if($local==1) {
        $data = [
            count($cand_no),
            $_POST["p_no"]
        ];
        Database::instance()->insert_record("pr_ward", $data, "ss");
    }

    response([
        "status" => "party-candidate-success"
    ]);
    return true;
}

//=======================================

function validate_iec() {
    if(isset($_POST["work_id"])==false || isset($_POST["mgr_id"])==false || isset($_POST["pass1"])==false || isset($_POST["pass2"])==false ||
        isset($_POST["initials"])==false || isset($_POST["surname"])==false) {
        error_response("a Staff member field is empty");
        return false;
    }
    if(validateIDCode($_POST["work_id"])==false) {
        error_response("IEC Work ID field is incorrect");
        return false;
    }
    if(validateIDCode($_POST["mgr_id"])==false) {
        error_response("IEC Mgr ID field is incorrect");
        return false;
    }
    if($_POST["pass1"]!=$_POST["pass2"] || validatePass($_POST["pass1"])==false ||validatePass($_POST["pass2"])==false) {
        error_response("Passwords are incorrect");
        return false;
    }
    if(validateWord($_POST["initials"])==false) {
        error_response("Initials are invalid");
        return false;
    }
    if(!validateWord($_POST["surname"])) {
        error_response("Surname is invalid");
        return false;
    }
    if(Database::instance()->is_duplicate_entry("staff","work_id",$_POST["work_id"])) {
        error_response("Staff member already exists");
        return false;
    }
    if(!Database::instance()->is_duplicate_entry("staff","mgr_id",$_POST["mgr_id"])) {
        error_response("Manager not found, not verified to add");
        return false;
    }
    return true;
}

function create_staff() {
    $data = [
      $_POST["work_id"],
      $_POST["initials"],
      $_POST["surname"],
      Database::instance()->encode_password($_POST["pass1"]),
      $_POST["mgr_id"]
    ];
    $types = "sssss";
    Database::instance()->insert_record("staff", $data, $types);
    response([
        "status" => "staff-success"
    ]);
    return true;
}

//=======================================

    function validate_ward() {
        if(isset($_POST["name"])==false || isset($_POST["surname"])==false || isset($_POST["id"])==false
            || isset($_POST["p_num"])==false || isset($_POST["pass1"])==false || isset($_POST["pass2"])==false
            || isset($_POST["mun_code"])==false) {
            error_response("a ward application field is empty");
            return false;
        }
        else {
            if(!validateWord($_POST["surname"])) {
                error_response("Surname is invalid");
                return false;
            }
            if(!validateWord($_POST["name"])) {
                error_response("first name is invalid");
                return false;
            }
            if(!validateIDCode($_POST["id"])) {
                error_response("id: ".$_POST["id"]." invalid");
                return false;
            }
            if(is_numeric($_POST["p_num"])==false) {
                error_response("Party number is not a number");
                return false;
            }
            if(Database::instance()->is_duplicate_entry("ward","id_no", $_POST["id"])) {
                error_response("User already exists, ID is found");
                return false;
            }
            if($_POST["pass1"]!=$_POST["pass2"] || validatePass($_POST["pass1"])==false
                || validatePass($_POST["pass2"])==false) {
                error_response("Passwords are incorrect");
                return false;
            }
            if(validateMunCode($_POST["mun_code"])==false) {
                error_response("Municipal code format is incorrect");
                return false;
            }
        }
        return true;
    }

    function create_ward() {
        $cand_no = Database::instance()->getValues("candidate", 1, 1, "i", "*");
        //var_dump($cand_no);
        if($cand_no==null)
            $cand_no =0;

        $data = [
            count($cand_no),
            $_POST["mun_code"],
            1,
            0,
            0
        ];

        Database::instance()->insert_record("candidate", $data, "ssiii");

        $data = [
            $_POST["id"],
            $_POST["p_num"],
            count($cand_no),
            $_POST["name"],
            $_POST["surname"],
            $_POST["pass1"]
        ];

        Database::instance()->insert_record("ward", $data, "ssssss");

        response([
            "status" => "success",
            "code" => $cand_no
        ]);

        return true;


    }

//=======================================

    function validateWord($data) {
        return preg_match("/^[A-Za-z].+$/i", $data);
    }

    function validatePass($data) {
        return preg_match("/^(?=.*[A-Za-z]+)(?=.*[0-9]+)(?=.*[!@#$%^&*()_+=\-{}\[\],\.<>\/\?\*]+).{10}$/",$data);
    }

    function validateIDCode($data) {
        return preg_match("/^\d{13}$/",$data);
    }

    function validateMunCode($data) {
        return preg_match("/^\w{3,8}$/", $data);
    }

    function validateAddress($data) {
        return preg_match("/^(?=.*\w+)(?=.*\d+).+$/i",$data) == 1;
    }


