function log(data) {
    console.log(data);
}

window.onload = function () {
    getResults();
}

function getResults() {
    data = {
        "key" : "123",
        "mun_code" : "CPT"
    }
    $("#head_mun").text("Results for: "+data["mun_code"]);
    GenericPost("../API's/results.php", data, DisplayData);
}

function DisplayData(data) {
    let data1 = data["pr_ward"];
        for (i = 0; i < data1.length; i++) {
            html = "<div class=\"grid-item\">" + data1[i]["name"] + "</div>\n" +
                "        <div class=\"grid-item\">" + data1[i]["tally"] + "</div>\n";
            $("#pr").append(html);
            }

    data1 = data["pr_dist"];
    for (i = 0; i < data1.length; i++) {
        html = "<div class=\"grid-item\">" + data1[i]["name"] + "</div>\n" +
            "        <div class=\"grid-item\">" + data1[i]["tally"] + "</div>\n";
        $("#dist").append(html);
    }

    data1 = data["ward"];
    for (i = 0; i < data1.length; i++) {
        html = "<div class=\"grid-item\">" + data1[i]["sname"] + "</div>\n" +
            "        <div class=\"grid-item\">" + data1[i]["tally"] + "</div>\n";
        $("#ward").append(html);
    }

    winner_pr(data);

}

function winner_pr(data) {
    //console.log(data);
    data1 = data["pr_ward"];
    data2 = data["pr_dist"];

    for(let i=0; i<data1.length; i++) {
        for(let j=0; j<data2.length; j++) {
            if(data1[i]["name"]==data2[j]["name"])
                data1[i]["tally"] += data2[j]["tally"];
        }
    }

    let $curr = data1[0];
    for(let i=0; i<data1.length; i++) {
        if(data1[i]["tally"] > $curr["tally"])
            $curr = data1[i];
    }

    html = "<div class=\"grid-item\">" + $curr["name"] + "</div>\n" +
        "        <div class=\"grid-item\">" + $curr["tally"] + "</div>\n";
    $("#winner_rep").append(html);

    winner_ward(data);
}

function winner_ward(data) {
    data1 = data["ward"];
    $curr = data1[0];
    for(let i=0; i<data1.length; i++) {
        if(data1[i]["tally"] > $curr["tally"])
            $curr = data1;
    }
    html = "<div class=\"grid-item\">" + $curr["sname"] + "</div>\n" +
        "        <div class=\"grid-item\">" + $curr["tally"] + "</div>\n";
    $("#winner_ward").append(html);

    overall(data);
}

function overall(data) {
    data1 = data["pr_dist"];
    data2 = data["pr_ward"];
    data3 = data["ward"];
    for(let i=0; i<data1.length; i++) {
        for (let j = 0; j < data2.length; j++) {
            for (let k = 0; k < data3.length; k++) {
                if(data3["name"] == data2["name"])
                    data2[j]["tally"] += data3[k]["tally"];
            }
            if(data2["name"] == data1["name"])
                data1[i]["tally"] += data2[j]["tally"];
        }
    }
    console.log(data1);
    html = "<div class=\"grid-item\">" + data1[0]["name"] + "</div>\n" +
        "        <div class=\"grid-item\">" + data1[0]["tally"]/2 + "</div>\n";
    $("#winner").append(html);

}