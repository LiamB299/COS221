<?php

    require("API's/database.php");

    //$var = Database::instance()->getValues("voter", "id_no", 9904275017089, "s", "municipal_code");
    //var_dump($var);
    //var_dump($var[0]["municipal_code"]);
    //var_dump("select distinct fname, sname, party.name, cand_no from candidate, ward, party where candidate_no = cand_no && municipal_code = "."\"CPT\""));
    //var_dump(Database::instance()->getValues("candidate", 1, 1, "i", "*"));
    /*var_dump(Database::instance()->getValuesCustom("select candidate.candidate_no, party.name from candidate, party, pr_ward where municipal_code = \""."CPT"."\"
&& is_pr = '1' && pr_ward.cand_no = candidate.candidate_no && pr_ward.party_no = party.party_no"));
    //echo "test";

    //var_dump(Database::instance()->getValues("test", "key", "L"));
*/
$data = [
    "CPT",
    date("Y-m-d"),
    1,
    8,
    8
];

//Database::instance()->insert_record("elections", $data ,"sssss");

Database::instance()->update_record("voter", "has_voted", 1, "id_no", 9904275017089, "i");