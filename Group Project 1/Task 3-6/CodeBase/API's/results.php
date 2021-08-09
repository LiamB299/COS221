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

if(isset($_POST["mun_code"])) {
    if(isset($_POST["key"])) {
        get_results();
    }
    else {
        error_response("key not set");
        return;
    }
}
else {
    error_response("mun not set");
    return;
}

function get_results() {
    $pr_ward = Database::instance()->getValuesCustom("select party.name, count(elections.municipal_code) as tally from party, elections, pr_ward where elections.pr_ward = pr_ward.cand_no && pr_ward.party_no = party.party_no group by (elections.pr_ward)");
    $pr_dist = Database::instance()->getValuesCustom("select party.name, count(elections.municipal_code) as tally from party, elections, pr_dist where elections.pr_district = pr_dist.cand_no && pr_dist.party_no = party.party_no group by (elections.municipal_code)");
    $ward = Database::instance()->getValuesCustom("select party.name, ward.fname, ward.sname, count(elections.municipal_code) as tally from ward, elections, party where ward_candidate = ward.cand_no && ward.p_num = party.party_no group by elections.municipal_code");

    response([
        "ward" => $ward,
        "pr_dist" => $pr_dist,
        "pr_ward" => $pr_ward
    ]);
}
