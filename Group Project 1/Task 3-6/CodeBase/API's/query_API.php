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
if(isset($_POST["group"])) {
    if(isset($_POST["key"])) {
        if(isset($_POST["get"])) {
            if($_POST["group"]=="voter") {
                if(Database::instance()->is_duplicate_entry("voter", "id_no", $_POST["key"])) {
                    voter_get_do();
                    return;
                }
                else {
                    error_response("voter key invalid");
                    return;
                }
            }
            if($_POST["group"]=="staff") {
                if(Database::instance()->is_duplicate_entry("staff", "work_id", $_POST["key"])) {
                    staff_get_do();
                    return;
                }
                else {
                    error_response("staff key invalid");
                    return;
                }
            }
            else {
                error_response("group not recognized");
                return;
            }
        }
        else {
            error_response("get not set");
            return;
        }
    }
    else {
        error_response("key not set");
        return;
    }
}
else {
    error_response("group not set");
    return;
}

//========================================
function voter_get_do() {
    if($_POST["get"]=="address") {
        return response([
            "status" => "success",
            "result" => Database::instance()->getValues("voter", "id_no", $_POST["key"], "s", $_POST["get"])
        ]);
    }
    else {
        return response([
            "status" => "success",
            "result" => Database::instance()->getValues("voter", "id_no", $_POST["key"], "s")
        ]);
    }
}
//========================================
function staff_get_do() {
    if(!isset($_POST["which"])) {
        error_response("staff which is not specified");
    }

    if($_POST["get"]=="party") {
        if($_POST["which"]=="unset") {
            return response([
                "group" => "party",
                "status" => "success",
                "result" => Database::instance()->getValues("party", "permitted", 0, "i", "*")
            ]);
        }
        else if($_POST["which"]=="set") {
            return response([
                "status" => "success",
                "result" => Database::instance()->getValues("party", "permitted", 1, "i", "*")
            ]);
        }
    }
    else if($_POST["get"]=="staff") {
        return response([
            "group" => "staff",
            "status" => "success",
            "result" => Database::instance()->getValues("staff", 1, 1, "i", "initials, surname, work_id")
        ]);
    }
    else if($_POST["get"]=="ward") {
        if($_POST["which"]=="unset") {
            return response([
                "group" => "ward",
                "status" => "success",
                "result" => Database::instance()->getValuesCustom("select distinct fname, sname, candidate_no, municipal_code from ward, candidate where cand_no = candidate_no and registered = 0")
            ]);
        }
        else if($_POST["which"]=="set") {
            return response([
                "status" => "success",
                "result" => Database::instance()->getValuesCustom("select distinct fname, sname, candidate_no, municipal_code from ward, candidate where cand_no = candidate_no and registered = 1")
            ]);
        }
    }
    else if($_POST["get"]=="voter") {
        if($_POST["which"]=="unset") {
            return response([
                "group" => "voter",
                "status" => "success",
                "result" => Database::instance()->getValues("voter", "permitted_to_vote", 0, "i", "id_no, address, municipal_code")
            ]);
        }
        else if($_POST["which"]=="set") {
            return response([
                "status" => "success",
                "result" => Database::instance()->getValues("voter", "permitted_to_vote", 1, "i", "id_no, address, municipal_code")
            ]);
        }
    }
    error_response("no get specified");
}
//========================================

//========================================
