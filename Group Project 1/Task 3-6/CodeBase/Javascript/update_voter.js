function log(data) {
    console.log(data);
}

function setHead(data) {
    //console.log(data);
    $("#old_add").text("Current Address: "+data["result"][0]["address"]);
}

window.onload = function () {
    data = {
        "group" : "voter",
        "key" : "9904275017089",
        "get" : "address"
    }
    GenericPost("../API's/query_API.php", data, setHead);
}

$("#sub").on('click', function () {
    submit();
})

function submit() {
    let address = $("#new_add").val();
    let mun = $("#new_mun").val();

    data = {
        //fixed for demo purposes
        "key" : "9904275017089", //sessionStorage.getItem("key");
        "group" : "voter",
        "command" : "change_address",
        "address" : address,
        "mun_code" : mun
    };

    GenericPost("../API's/update_API.php", data, log);
}