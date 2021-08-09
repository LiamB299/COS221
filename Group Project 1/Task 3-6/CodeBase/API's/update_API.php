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
    if(isset($_POST["key"])) {
        if(isset($_POST["group"])) {
            if($_POST["group"]=="staff") {
                if(Database::instance()->is_duplicate_entry("staff", "work_id", $_POST["key"])) {
                    if(isset($_POST["command"])) {
                        if($_POST["command"]=="permit") {
                            permit_group();
                            return;
                        }
                        else if($_POST["command"]=="voting_district") {
                            update_district();
                            return;
                        }
                        else {
                            error_response("command not recognized");
                            return;
                        }
                    }
                    else {
                        error_response("command not set for staff");
                        return;
                    }
                }
                else {
                    error_response("Staff ID Key invalid");
                }
            }
            if($_POST["group"]=="voter") {
                if(Database::instance()->is_duplicate_entry("voter", "id_no", $_POST["key"])) {
                    if(isset($_POST["command"])) {
                        if($_POST["command"]=="change_address") {
                            update_info_voter();
                            return;
                        }
                        else if($_POST["command"]=="voted") {
                            set_voted_voter();
                        }
                        else {
                            error_response("voter command not recognized");
                            return;
                        }
                    }
                    else {
                        error_response("voter command not set");
                        return;
                    }
                }
                else {
                    error_response("ID Key not found");
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
        error_response("key not set");
        return;
    }




/*
 *
 *
 *

if(isset($_POST[""])) {

}
else {
    error_response("");
    return;
}

if($_POST[""]) {

}
else {
    error_response("");
    return;
}*/
//========================================
// voters can change their address and thus set their mun code
// key and group identify the user
function update_info_voter() {
    if(!isset($_POST["address"])) {
        error_response("address not set");
        return;
    }

    if(!isset($_POST["mun_code"])) {
        error_response("municipality code not set");
        return;
    }

    if(!Database::instance()->is_duplicate_entry("municipality", "municipal_code", $_POST["mun_code"])) {
        error_response("municipality code not found");
        return;
    }

    if(!validateAddress($_POST["address"])) {
        error_response("Voter address invalid");
        return;
    }

    if(!Database::instance()->update_record("voter", "address", $_POST["address"],
        "id_no", $_POST["key"],"s"))
        error_response("Update voter failed");

    if(!Database::instance()->update_record("voter", "municipal_code", $_POST["mun_code"],
        "id_no", $_POST["key"],"s"))
        error_response("Update voter mun code failed");

    response([
        "status" => "success",
    ]);
}

function set_voted_voter() {
    if(Database::instance()->update_record("voter", "has_voted", 1, "id_no", $_POST["key"], "i")) {
        response([
            "status" => "success"
        ]);
    }
    else {
        error_response("failed to set voter to voted");
    }
}

//========================================
// staff may permit parties, candidates and voters
// work id is key, group is the staff, target is the other group,
// command set to allows, permits the group
//

function permit_group() {
    if(isset($_POST["target"])) {
        if(!isset($_POST["targ_no"])) {
            error_response("group to update has no key");
            return;
        }
        if($_POST["target"]=="voter") {
            $table = "voter";
            $where = "id_no";
            $perm = "permitted_to_vote";
        }
        else if($_POST["target"]=="party") {
            $table = "party";
            $where = "party_no";
            $perm = "permitted";
        }
        else if($_POST["target"]=="candidate") {
            $table = "candidate";
            $where = "candidate_no";
            $perm = "registered";
        }
        else {
            error_response("staff group to update not recognized");
            return;
        }

        if(!Database::instance()->update_record($table, $perm, 1,$where, $_POST["targ_no"], "i")) {
            error_response("failed to permit group ".$_POST["target"]." to partake in election");
            return;
        }
        else {
            response([
                "status" => "success"
            ]);
            return;
        }
    }
    else {
        error_response("No group to permit specified");
        return;
    }
}

// update... mun codes?
function update_district() {

}

function validateAddress($data) {
    return preg_match("/^(?=.*\w+)(?=.*\d+).+$/i",$data);
}
