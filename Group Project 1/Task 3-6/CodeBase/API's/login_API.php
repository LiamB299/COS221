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
    if($_POST["type"]=="login") {
        if(isset($_POST["group"])) {
            if($_POST["group"]=="staff") {
                if(validate_staff()) {
                    login_staff();
                    return;
                }
                else {
                    return;
                }
            }
            else if($_POST["group"]=="voter") {
                if(validate_voter_ward()) {
                    login_voter();
                    return;
                }
                else {
                    return;
                }
            }
            else if($_POST["group"]=="party") {
                if(validate_party()) {
                    login_party();
                    return;
                }
                else {
                    return;
                }
            }
            else if($_POST["group"]=="ward") {
                if(validate_voter_ward()) {
                    login_ward();
                    return;
                }
                else {
                    return;
                }
            }
            else {
                error_response("group not recognized");
                return;
            }
        }
        else {
            error_response("group not set");
            return;
        }
    }
    else {
        error_response("type not recognized");
        return;
    }
}
else {
    error_response("type not set");
    return;
}

//========================================
function validate_voter_ward() {
    if(isset($_POST["id"]) && isset($_POST["password"])) {
        if(validateIDCode($_POST["id"])==false) {
            error_response("ID invalid");
            return false;
        }
        //if(validatePass($_POST["password"])==false) {
       //     error_response("password invalid");
       //     return false;
        //}
        return true;
    }
    else {
        if(isset($_POST["id"])==false) {
            error_response("ID not set");
        }
        if(isset($_POST["password"])) {
            error_response("Password not set");
        }
        return false;
    }
}

function login_voter() {
    if(!Database::instance()->is_duplicate_entry("voter", "id_no", $_POST["id"])) {
        error_response("Voter not found");
        return;
    }
    //echo Database::instance()->encode_password($_POST["password"]);
    if(!Database::instance()->user_exists(
        "voter", "id_no",$_POST["id"],"password",
            Database::instance()->encode_password($_POST["password"]), "ss")) {
        error_response("password is incorrect");
        return;
    }

    response([
        "status" => "success",
        "key" => $_POST["id"],
        "group" => "voter"
    ]);
}
//========================================
function login_ward() {
    if(!Database::instance()->is_duplicate_entry("ward", "id_no", $_POST["id"])) {
        error_response("Ward candidate not found");
        return;
    }
    if(!Database::instance()->user_exists(
        "ward", "id_no",$_POST["id"],"password",
        Database::instance()->encode_password($_POST["password"]), "ss")) {
        error_response("password is incorrect");
    }

    response([
        "status" => "success",
        "key" => $_POST["id"],
        "group" => "ward"
    ]);
}
//========================================
function validate_party() {
    if(isset($_POST["party_no"]) && isset($_POST["password"])) {
        if(is_int($_POST["party_no"]) && strlen(($_POST["party_no"]))<=5) {
            error_response("Party no. invalid");
            return false;
        }
        if(validatePass($_POST["password"])==false) {
            error_response("password invalid");
            return false;
        }
        return true;
    }
    else {
        if(isset($_POST["party_no"])==false) {
            error_response("Party number not set");
        }
        if(isset($_POST["password"])) {
            error_response("Password not set");
        }
        return false;
    }
}

function login_party() {
    if(!Database::instance()->is_duplicate_entry("party", "party_no", $_POST["party_no"])) {
        error_response("party not found");
        return;
    }
    if(!Database::instance()->user_exists(
        "party", "party_no",$_POST["party_no"],"password",
        Database::instance()->encode_password($_POST["password"]), "ss")) {
        error_response("password is incorrect");
    }

    response([
        "status" => "success",
        "key" => $_POST["party_no"],
        "group" => "party"
    ]);
}
//========================================
function validate_staff() {
    if(isset($_POST["work_id"]) && isset($_POST["password"])) {
        if(validateIDCode($_POST["work_id"])==false) {
            error_response("Work ID invalid");
            return false;
        }
        //if(validatePass($_POST["password"])==false) {
       //     error_response("password invalid");
        //    return false;
        //}
        return true;
    }
    else {
        if(isset($_POST["work_id"])==false) {
            error_response("Work ID not set");
            return false;
        }
        if(isset($_POST["password"])) {
            error_response("Password not set");
            return false;
        }
        return false;
    }
}

function login_staff() {
    if(!Database::instance()->is_duplicate_entry("staff", "work_id", $_POST["work_id"])) {
        error_response("staff member not found");
        return;
    }
    //if(!Database::instance()->user_exists(
    //    "staff", "work_id",$_POST["work_id"],"password",
    //    Database::instance()->encode_password($_POST["password"]), "ss")) {
    //    error_response("password is incorrect");
    //    return;
    //}

    if(!Database::instance()->is_duplicate_entry("staff", "password", $_POST["password"])) {
        error_response("password is incorrect");
        return;
    }

    response([
        "status" => "success",
        "key" => $_POST["work_id"],
        "group" => "staff"
    ]);
}
//========================================
function validatePass($data) {
    return preg_match("/^(?=.*[A-Za-z]+)(?=.*[0-9]+)(?=.*[!@#$%^&*()_+=\-{}\[\],\.<>\/\?\*]+).+$/",$data);
}

function validateIDCode($data) {
    return preg_match("/^\d{13}$/",$data);
}
