window.onload = function () {
    SwapPage("info");
    genPages();
}

function genPages() {
    if(sessionStorage.getItem("group")!="voter") {
        window.location.replace("../Frontend/index.html");
        alert("Only voters may vote");
    }

    //sessionStorage.setItem("key", "9904275017089");
    body = {
        "stage": "1",
        "key" : sessionStorage.getItem("key")
    };

    console.log(body);
    GenericPost("../API's/ballot_API.php", body, stage2);
}

function stage2(data) {
    //console.log(data);
    if(data["status"]=="error") {
        alert(data["message"])
        window.location.replace("../Frontend/index.html");
        return;
    }

    sessionStorage.setItem("mun_code", data["mun_code"]);
    sessionStorage.setItem("mun_type", data["type"]);
    sessionStorage.setItem("is_dist", data["is_dist"]);

    var body = {
        "stage": "2",
        "mun_code" : data["mun_code"],
        "key" : sessionStorage.getItem("key")
    };

    GenericPost("../API's/ballot_API.php", body, stage3);
}

function stage3(data) {
    console.log(data);
    if(data["status"]=="error") {
        alert(data["message"])
        return;
    }


    data = data["data"];
    //build ward html

    for(i=0; i<data.length; i++) {
        html = "<div class=\"grid-item\">"+data[i]["fname"]+"</div>\n" +
            "        <div class=\"grid-item\">"+data[i]["sname"]+"</div>\n" +
            "        <div class=\"grid-item\">"+data[i]["name"]+"</div>\n" +
            "        <div class=\"grid-item\"><input id=\""+data[i]["cand_no"]+"\" type=\"checkbox\" class=\"check\"></div>";
        $("#ward-add").append(html);
    }

    var body = {
        "stage" : "3",
        "key" : sessionStorage.getItem("key"),
        "mun_code" : sessionStorage.getItem("mun_code"),
        "which" : "other"
    };

    //console.log(body);

    GenericPost("../API's/ballot_API.php", body, stage4);
}

function stage4(data) {
    if(data["status"]=="error") {
        alert(data["message"])
        return;
    }

    //console.log(data);
    //build html

    data = data["data"];
    //build pr html

    for(i=0; i<data.length; i++) {
        html = "<div class=\"grid-item\">"+data[i]["name"]+"</div>\n" +
            "        <div class=\"grid-item\"><input id=\""+data[i]["candidate_no"]+"\" type=\"checkbox\" class=\"check\"></div>";
        $("#pr-add").append(html);
    }

    val = sessionStorage.getItem("is_dist");

    if(val) {
        body = {
            "stage" : "3",
            "key" : sessionStorage.getItem("key"),
            "mun_code" : sessionStorage.getItem("mun_code"),
            "which" : "dist"
        };
        GenericPost("../API's/ballot_API.php", body, stage5);
    }
    else {
        $("#dist").css("visibility", "none");
        //pages are built
        $(".check").on("click", checked);
        return;
    }

}

function stage5(data) {
    if(data["status"]=="error") {
        alert(data["message"])
        return;
    }

    //build dist

    data = data["data"];
    //build pr html

    for(i=0; i<data.length; i++) {
        html = "<div class=\"grid-item\">"+data[i]["name"]+"</div>\n" +
            "        <div class=\"grid-item\"><input id=\""+data[i]["candidate_no"]+"\" type=\"checkbox\" class=\"check\"></div>";
        $("#dist-add").append(html);
    }

    $(".check").on("click", checked);
}

function SwapPage(which) {
    $(".tabcontent").css("display", "none");
    $("#"+which+"-content").css("display", "block");
}

$(".tablink").on("click",function () {
    SwapPage(this.id);
});

function checked() {
    var par = this.parentElement.parentElement.parentElement;
    var hold = $("#"+par.id).find("input");

    //console.log(hold.length);

    for(var i=0; i<hold.length; i++) {
        if(hold[i].checked==true && hold[i]!=this) {
            //alert("Only one option allowed");
            hold[i].checked=false;
        }
    }
}

$("#submit-content").on("click", function () {
    var boxes = $("input");

    //console.log(boxes.length);

    var count = 0;
    for(var i=0; i<boxes.length; i++) {
        //console.log(boxes[i].checked);
        if(boxes[i].checked)
            count++;
    }

    if(count!=3) {
        //alert(count);
        alert("Number of selections invalid");
        return;
    }
    var data = [];
    for(i=0; i<boxes.length; i++) {
        //console.log(boxes[i].checked);
        if(boxes[i].checked)
            data.push(boxes[i].id);
    }

    body = {
        "key" : sessionStorage.getItem("key"),
        "stage" : "vote",
        "mun_code" : sessionStorage.getItem("mun_code"),
        "data1" : 1,//toString(data[0]),
        "data2" : 8,//toString(data[1]),
        "data3" : 8,//toString(data[2]),
    };

    //console.log(body);
    GenericPost("../API's/ballot_API.php", body, submitted);


})

function submitted(data) {
    sessionStorage.clear();
    window.location.replace("../Frontend/index.html");
}