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
// get type of mun and mun code from key (stage 1)
// get ward candidates based on mun code
// get pr candidates from mun code
// receive votes and submit
// send log out command

if(isset($_POST["key"])) {

    if(!has_voted()) {
        return;
    }

    if(!permitted()) {
        return;
    }

    if(isset($_POST["stage"])) {
        if($_POST["stage"]=="1") {
            get_mun_info();
            return;
        }
        else if($_POST["stage"]=="2") {
            if(isset($_POST["mun_code"])) {
                get_ward();
                return;
            }
            else {
                error_response("mun code not set for stage 2");
            }
        }
        else if($_POST["stage"]=="3") {
            if(!isset($_POST["mun_code"]))
                error_response("Municipal code not set");
            if(isset($_POST["which"])) {
                if($_POST["which"]=="other") {
                    local_parties();
                    return;
                }
                if($_POST["which"]=="dist") {
                    dist_parties();
                    return;
                }
                else {
                    error_response("which not known");
                    return;
                }
            }
            else {
                error_response("which pr not set");
                return;
            }
        }
        else if($_POST["stage"]=="vote") {
            if(isset($_POST["mun_code"])) {
                if(isset($_POST["data1"]) && isset($_POST["data2"])) {
                    vote();
                    return;
                }
                else {
                    error_response("data not set");
                    return;
                }
            }
            else {
                error_response("mun code not set for stage vote");
                return;
            }
        }
    }
    else {
        error_response("stage not set");
        return;
    }
}
else {
    error_response("key not set");
    return;
}

function permitted() {
    $data = Database::instance()->getValuesCustom("select * from voter where id_no = ".$_POST["key"]." && permitted_to_vote = 0");
    //var_dump($data);
    if(count($data)!=0) {
        error_response("User not permitted");
        return false;
    }
    return true;
}

function has_voted() {
    $data = Database::instance()->getValuesCustom("select * from voter where id_no = ".$_POST["key"]." && has_voted = 1");
    //var_dump($data);
    if(count($data)!=0) {
        error_response("User has voted");
        return false;
    }
    return true;
}

function get_mun_info() {
    if(has_voted()==false)
        return false;


    $data1 = Database::instance()->getValues("voter", "id_no", $_POST["key"], "s", "municipal_code");
    if(count($data1)!=1) {
        error_response("mun code error");
        return false;
    }

    $data2 = Database::instance()->getValues("municipality", "municipal_code", $data1[0]["municipal_code"], "s", "type_of_mun");

    $data3 = Database::instance()->getValues("districts", "municipal_codes", $data1[0]["municipal_code"], "s");
    if(count($data3)==1) {
        $dist = true;
    }
    else
        $dist = false;

    response([
        "status" => "success",
        "mun_code" => $data1[0]["municipal_code"],
        "type" => $data2[0]["type_of_mun"],
        "is_dist" => $dist
    ]);

    return;
}

function get_ward() {
    $sql = "select sname, fname, party.name, cand_no from ward, party, candidate where registered = 1 && candidate.candidate_no = ward.cand_no 
            && is_ward = 1 && ward.p_num = party.party_no && candidate.municipal_code = \"".$_POST["mun_code"]."\"";
    //var_dump($sql);
    $data1 = Database::instance()->getValuesCustom($sql);

    response([
        "status" => "success",
        "data" => $data1
    ]);
}

function local_parties() {
    $sql = "select candidate.candidate_no, party.name from candidate, party, pr_ward where municipal_code = \"".$_POST["mun_code"]."\" 
&& is_pr = '1' && pr_ward.cand_no = candidate.candidate_no && pr_ward.party_no = party.party_no && permitted = 1";

    $data1 = Database::instance()->getValuesCustom($sql);

    response([
        "status" => "success",
        "data" => $data1
    ]);
}

function dist_parties() {
    $sql = "select candidate.candidate_no, party.name from candidate, party, pr_dist where municipal_code = \"".$_POST["mun_code"]."\" 
&& is_pr = '1' && pr_dist.cand_no = candidate.candidate_no && pr_dist.party_no = party.party_no && permitted = 1";

    $data1 = Database::instance()->getValuesCustom($sql);

    response([
        "status" => "success",
        "data" => $data1
    ]);
}

function vote() {
    $data = [
        $_POST["mun_code"],
        date("Y-m-d"),
        $_POST["data1"],
        $_POST["data2"],
        $_POST["data3"]
    ];

    Database::instance()->insert_record("elections", $data ,"sssss");
    Database::instance()->update_record("voter", "has_voted", 1, "id_no", $_POST["key"], "i");
    response([
        "status" => "success"
    ]);
}
