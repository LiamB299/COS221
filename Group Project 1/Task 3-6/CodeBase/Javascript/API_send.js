function log(sline) {
    console.log(sline);
}

//bodydata is a json string
function GenericPost(url, Bodydata, callback=null, arg=null, arg2=null) {
    //Object
    var req = new XMLHttpRequest();
    //Request type
    req.open("POST", url, true);
    //Secure POST
    req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    //Compose body and begin request
    //log(formParameters(Bodydata));
    //req.send(formParameters(Bodydata));
    //log(Bodydata);
    req.send($.param(Bodydata));
    //check status
    req.onreadystatechange = function() {
        //success
        if(this.readyState == 4 && this.status == 200) {
            //log(req.responseText);
            if(callback==null)
                return;// JSON.parse(req.responseText);
            //log(req.responseText);
            callback(JSON.parse(req.responseText), arg, arg2);
            //callback(req.responseText, arg, arg2);
        }
        else if( this.status == 403 || this.status == 403)
            //throw exception
            return "";
    }

}