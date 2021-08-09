window.onload = function () {
    $("#sub").on("click", subUsers);
    $("#ret").on("click", leave);
    $("#votbut").on("click", function () {
        getData("voter");
    });
    $("#staffbut").on("click", function () {
        getData("staff");
    });
    $("#partbut").on("click", function () {
        getData("party");
    });
    $("#wardbut").on("click", function () {
        getData("ward");
    });
}

function leave() {
    window.location.replace("../Frontend/index.html");
}

function getData(group="voter") {
    sessionStorage.setItem("target", group);
    data = { //demo purposes
        "key" : "9904275017089",//sessionStorage.getItem("key"),
        "group" : "staff",
        "get" : group,
        "which" : "unset"
    };
    GenericPost("../API's/query_API.php", data, addData);
}

function addData(data) {
    data = data["result"];
    if (sessionStorage.getItem("target") == "voter") {
        for (i = 0; i < data.length; i++) {
            html = "<div class=\"grid-item\">" + data[i]["id_no"] + "</div>\n" +
                "        <div class=\"grid-item\">" + data[i]["address"] + "</div>\n" +
                "        <div class=\"grid-item\"><input id=\"" + data[i]["id_no"] + "\" type=\"checkbox\" class=\"check\"></div>";
            $("#up-add").append(html);
        }
    } else if (sessionStorage.getItem("target") == "staff") {
        for (i = 0; i < data.length; i++) {
            html = "<div class=\"grid-item\">" + data[i]["work_id"] + "</div>\n" +
                "<div class=\"grid-item\">" + data[i]["initials"] + "</div>\n" +
                "        <div class=\"grid-item\">" + data[i]["surname"] + "</div>\n";
            $("#up-add").append(html);
        }
    } else if (sessionStorage.getItem("target") == "ward") {
        for (i = 0; i < data.length; i++) {
            html = "<div class=\"grid-item\">" + data[i]["municipal_code"] + "</div>\n" +
                "        <div class=\"grid-item\">" + data[i]["sname"] + "</div>\n" +
                "        <div class=\"grid-item\"><input id=\"" + data[i]["candidate_no"] + "\" type=\"checkbox\" class=\"check\"></div>";
            $("#up-add").append(html);
        }
    } else if (sessionStorage.getItem("target") == "party") {
        for (i = 0; i < data.length; i++) {
            html = "<div class=\"grid-item\">" + data[i]["name"] + "</div>\n" +
                "        <div class=\"grid-item\">" + data[i]["party_no"] + "</div>\n" +
                "        <div class=\"grid-item\"><input id=\"" + data[i]["party_no"] + "\" type=\"checkbox\" class=\"check\"></div>";
            $("#up-add").append(html);
        }
    }
}


function subUsers() {
    let boxes = $(".check");
    for(i=0; i<boxes.length; i++) {
        log(boxes[i].id);
        if(boxes[i].checked==true) {
            let data = {
                "key" : "9904275017089",//sessionStorage.getItem("key"),
                "group" : "staff",
                "command" : "permit",
                "target" : sessionStorage.getItem("target"),
                "targ_no" : boxes[i].id
            };
            //GenericPost("../API's/update_API.php", data, log);
        }
    }
}

