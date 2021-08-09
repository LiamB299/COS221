//var sel = document.getElementById('mySelect');

//sel.addEventListener("change", Party);

function log(data) {
    console.log(data);
}

var templateReg = "You are signing in as: ";

$("#sub").on("click", function () {
    //console.log();

    GenericPost("../API's/login_API.php", CollectInfo(), setDom);

});

function setDom(data) {
    //console.log(data);

    if(data["status"]=="error") {
        alert(data["message"]);
        return;
    }

    sessionStorage.setItem("Logged_group", sessionStorage.getItem("group"))
    sessionStorage.setItem("key", data["key"]);
    sessionStorage.setItem("logged", "true");
    window.location.replace("../Frontend/index.html");
}

function CollectInfo() {
    let data = {};
    if(sessionStorage.getItem("group")=="voter") {
        data = {
            "type" : "login",
            "group" : sessionStorage.getItem("group"),
            "id" : $("#ID1").val(),
            "password" : $("#pass").val()
        };
    }
    else if(sessionStorage.getItem("group")=="staff") {
        data = {
            "type" : "login",
            "group" : sessionStorage.getItem("group"),
            "work_id" : $("#workID1").val(),
            "password" : $("#pass").val()
        };
    }
    else if(sessionStorage.getItem("group")=="ward") {
        data = {
            "type" : "login",
            "group" : sessionStorage.getItem("group"),
            "id" : $("#ID1").val(),
            "password" : $("#pass").val()
        };
    }
    else if(sessionStorage.getItem("group")=="party") {
        data = {
            "type" : "login",
            "group" : sessionStorage.getItem("group"),
            "party_no" : $("#partyNum1").val(),
            "password" : $("#pass").val()
        };
    }
    return data;
}

function Voter() {
    sessionStorage.setItem("group", "voter");
    document.getElementById("selection").innerHTML = templateReg + "Voter";
    showForm();
    hideAll();
    var add = document.getElementById("ID");
    add.style.display = "block";
    var sur = document.getElementById("ID1");
    sur.style.display = "block";
}

function Staff(){
    sessionStorage.setItem("group", "staff");
    document.getElementById("selection").innerHTML = templateReg + "Staff";
    showForm();
    hideAll();
    var add = document.getElementById("workID");
    add.style.display = "block";
    var sur = document.getElementById("workID1");
    sur.style.display = "block";
}

function Candidate(){
    sessionStorage.setItem("group", "ward");
    document.getElementById("selection").innerHTML = templateReg + "Candidate";
    showForm();
    hideAll();
    var add = document.getElementById("ID");
    add.style.display = "block";
    var sur = document.getElementById("ID1");
    sur.style.display = "block";
}

function Party(){
    sessionStorage.setItem("group", "party");
    document.getElementById("selection").innerHTML = templateReg + "Party";
    showForm();
    hideAll();
    var sur = document.getElementById("partyNum");
    sur.style.display = "block";
    var add = document.getElementById("partyNum1");
    add.style.display = "block";
}

function showForm(){
    var x = document.getElementById("overview");
    x.style.display = "block";
}

function hideAll(){
    var sur = document.getElementById("partyNum");
    sur.style.display = "none";
    var add = document.getElementById("partyNum1");
    add.style.display = "none";
    var add = document.getElementById("ID");
    add.style.display = "none";
    var sur = document.getElementById("ID1");
    sur.style.display = "none";
    var add = document.getElementById("workID");
    add.style.display = "none";
    var add = document.getElementById("workID1");
    add.style.display = "none";
}

function showAll(){
    var sur = document.getElementById("partyNum");
    sur.style.display = "block";
    var sur = document.getElementById("partyNum1");
    sur.style.display = "block";
    var add = document.getElementById("ID");
    add.style.display = "block";
    var add = document.getElementById("ID1");
    add.style.display = "block";
    var add = document.getElementById("workID");
    add.style.display = "block";
    var add = document.getElementById("workID1");
    add.style.display = "block";
}

