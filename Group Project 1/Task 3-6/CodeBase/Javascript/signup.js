var templateReg = "You are registering for: ";

function log(data) {
    console.log(data);
}

$("#mun_page").on("click", function () {
    window.open("../API's/municipalities.php", '_blank');
});

$("#sub").on("click", function () {
    var data = CollectInfo(sessionStorage.getItem("group"));

    GenericPost("../API's/applications.php", data, redirect);
})

function redirect(data) {
    console.log(data);
    if(data["status"]=="error") {
        alert(data["message"]);
        return;
    }

    window.location.replace("../Frontend/index.html");
}

function Voter() {
    sessionStorage.setItem("group", "voter");
    document.getElementById("selection").innerHTML = templateReg + "Voter";
    showForm();
    hideAll();
    showAllVoter();
    
}

function Ward(){
    document.getElementById("selection").innerHTML = templateReg + "Ward";
    sessionStorage.setItem("group", "ward");
    showForm();
    hideAll();
    showAllWard()
}

function Staff(){
    document.getElementById("selection").innerHTML = templateReg + "Staff";
    sessionStorage.setItem("group", "staff");
    showForm();
    hideAll();
    showAllStaff();
}

function PartyMunicipality(){
    document.getElementById("selection").innerHTML = templateReg + "Party Municipality";
    sessionStorage.setItem("group", "party-second");
    showForm();
    hideAll();
    showAllPartyM();
}

function Party(){
    sessionStorage.setItem("group", "party-first");
    document.getElementById("selection").innerHTML = templateReg + "Party";
    showForm();
    hideAll();
    showAllParty();
}

function showForm() {
    var x = document.getElementById("overview");
    x.style.display = "block";
}

function hideAll(){
    var n = document.getElementById("name");
    n.style.display = "none";
    var n1 = document.getElementById("name1");
    n1.style.display = "none";
    var sur = document.getElementById("surname");
    sur.style.display = "none";
    var id = document.getElementById("ID");
    id.style.display = "none";
    var add = document.getElementById("address");
    add.style.display = "none";
    var sur1 = document.getElementById("surname1");
    sur1.style.display = "none";
    var id1 = document.getElementById("ID1");
    id1.style.display = "none";
    var add1 = document.getElementById("address1");
    add1.style.display = "none";
    var p = document.getElementById("province");
    p.style.display = "none";
    var p1 = document.getElementById("province1");
    p1.style.display = "none";
    var p2 = document.getElementById("partynum");
    p2.style.display = "none";
    var p3 = document.getElementById("partynum1");
    p3.style.display = "none";
    var m = document.getElementById("municipalityc");
    m.style.display = "none";
    var m1 = document.getElementById("municipalityc1");
    m1.style.display = "none";
    var w = document.getElementById("workid");
    w.style.display = "none";
    var w1 = document.getElementById("workid1");
    w1.style.display = "none";
    var m = document.getElementById("managerid");
    m.style.display = "none";
    var m1 = document.getElementById("managerid1");
    m1.style.display = "none";
    var i = document.getElementById("initials");
    i.style.display = "none";
    var i1 = document.getElementById("initials1");
    i1.style.display = "none";
    var d = document.getElementById("district");
    d.style.display = "none";
    var d1 = document.getElementById("district1");
    d1.style.display = "none";
    var na = document.getElementById("newadd");
    na.style.display = "none";
    var na1 = document.getElementById("newadd1");
    na1.style.display = "none";
}

function showAllVoter(){
    var id = document.getElementById("ID");
    id.style.display = "block";
    var add = document.getElementById("address");
    add.style.display = "block";
    var id1 = document.getElementById("ID1");
    id1.style.display = "block";
    var add = document.getElementById("address1");
    add.style.display = "block";
    var p = document.getElementById("province");
    p.style.display = "block";
    var p = document.getElementById("province1");
    p.style.display = "block";
    var p = document.getElementById("municipalityc");
    p.style.display = "block";
    var p = document.getElementById("municipalityc1");
    p.style.display = "block";
    //var p = document.getElementById("newadd");
    //p.style.display = "block";
    //var p = document.getElementById("newadd1");
    //p.style.display = "block";
}

function showAllWard(){
    var sur = document.getElementById("name");
    sur.style.display = "block";
    var sur = document.getElementById("name1");
    sur.style.display = "block";
    var sur = document.getElementById("surname");
    sur.style.display = "block";
    var add = document.getElementById("ID");
    add.style.display = "block";
    var sur = document.getElementById("surname1");
    sur.style.display = "block";
    var add = document.getElementById("ID1");
    add.style.display = "block";
    var p = document.getElementById("partynum");
    p.style.display = "block";
    var p = document.getElementById("partynum1");
    p.style.display = "block";
    var p = document.getElementById("municipalityc");
    p.style.display = "block";
    var p = document.getElementById("municipalityc1");
    p.style.display = "block";
}

function showAllStaff(){
    var sur = document.getElementById("surname");
    sur.style.display = "block";
    var sur = document.getElementById("surname1");
    sur.style.display = "block";
    var w = document.getElementById("workid");
    w.style.display = "block";
    var w1 = document.getElementById("workid1");
    w1.style.display = "block";
    var m = document.getElementById("managerid");
    m.style.display = "block";
    var m1 = document.getElementById("managerid1");
    m1.style.display = "block";
    var i = document.getElementById("initials");
    i.style.display = "block";
    var i1 = document.getElementById("initials1");
    i1.style.display = "block";
}

function showAllParty(){
    var sur = document.getElementById("name");
    sur.style.display = "block";
    var sur = document.getElementById("name1");
    sur.style.display = "block";
}

function showAllPartyM(){
    var sur = document.getElementById("partynum");
    sur.style.display = "block";
    var sur = document.getElementById("partynum1");
    sur.style.display = "block";
    var sur = document.getElementById("district");
    sur.style.display = "block";
    var sur = document.getElementById("district1");
    sur.style.display = "block";
    var p = document.getElementById("municipalityc");
    p.style.display = "block";
    var p = document.getElementById("municipalityc1");
    p.style.display = "block";
}

function CollectInfo(group) {
    data = [];

    if(group=="party-first") {
        if($("#name1").val().length>0) {
            data["name"]= $("#name1").val();
        }
        if($("#password").val() != "") {
            data["pass1"] = $("#password").val();
        }
        if($("#confirm").val() != "") {
            data["pass2"] = $("#confirm").val();
        }

        data = {
            "name" : data["name"],
            "pass1" : data["pass1"],
            "pass2" : data["pass2"],
            "type" : "apply",
            "group" : "party-first",
        };
    }
    else if(group=="party-second") {
        if($("#partynum1").val().length>0) {
            data["p_no"] = $("#partynum1").val();
        }

            data["dist"] = $("#district1").prop('checked');

        if($("#password").val() != "") {
            data["pass"] = $("#password").val();
        }
        if($("#municipalityc1").val() != "") {
            data["mun_code"] = $("#municipalityc1").val();
        }

        data = {
            "p_no" : data["p_no"],
            "dist" : data["dist"],
            "pass" : data["pass"],
            "mun_code" : data["mun_code"],
            "type" : "apply",
            "group" : "party-second",
        };
    }
    else if(group=="voter") {
        if($("#address1").val().length>0) {
            data["address"] = $("#address1").val();
        }
        if($("#ID1").val().length>0) {
            data["id"] = $("#ID1").val();
        }
        if($("#municipalityc1").val() != "") {
            data["mun_code"] = $("#municipalityc1").val();
        }
        if($("#province1").val().length>0) {
            data["province"] = $("#province1").val();
        }
        if($("#password").val() != "") {
            data["pass1"] = $("#password").val();
        }
        if($("#confirm").val() != "") {
            data["pass2"] = $("#confirm").val();
        }

        data = {
            "address" : data["address"],
            "id" : data["id"],
            "mun_code" : data["mun_code"],
            "province" : data["province"],
            "pass1" : data["pass1"],
            "pass2" : data["pass2"],
            "type" : "apply",
            "group" : "voter",
        };
    }
    else if(group=="staff") {
        if($("#workid1").val().length>0) {
            data["work_id"] = $("#workid1").val();
        }
        if($("#managerid1").val().length>0) {
            data["mgr_id"] = $("#managerid1").val();
        }
        if($("#password").val().length>0) {
            data["pass1"] = $("#password").val();
        }
        if($("#confirm").val().length>0) {
            data["pass2"] = $("#confirm").val();
        }
        if($("#initials1").val().length>0) {
            data["initials"] = $("#initials1").val();
        }
        if($("#surname1").val().length>0) {
            data["surname"] = $("#surname1").val();
        }

        data = {
            "work_id" : data["work_id"],
            "mgr_id" : data["mgr_id"],
            "pass1" : data["pass1"],
            "pass2" : data["pass2"],
            "initials" : data["initials"],
            "surname" : data["surname"],
            "type" : "apply",
            "group" : "staff",
        };

    }
    else if(group=="ward") {
        if($("#name1").val().length>0) {
            data["name"]= $("#name1").val();
        }
        if($("#surname1").val().length>0) {
            data["surname"] = $("#surname1").val();
        }
        if($("#ID1").val().length>0) {
            data["id"] = $("#ID1").val();
        }
        if($("#partynum1").val().length>0) {
            data["p_num"] = $("#partynum1").val();
        }
        if($("#password").val().length>0) {
            data["pass1"] = $("#password").val();
        }
        if($("#confirm").val().length>0) {
            data["pass2"] = $("#confirm").val();
        }
        if($("#municipalityc1").val() != "") {
            data["mun_code"] = $("#municipalityc1").val();
        }

        data = {
            "name" : data["name"],
            "surname" : data["surname"],
            "id" : data["id"],
            "p_num" : data["p_num"],
            "pass1" : data["pass1"],
            "pass2" : data["pass2"],
            "mun_code" : data["mun_code"],
            "type" : "apply",
            "group" : "ward"
        };
    }

    return data;
}