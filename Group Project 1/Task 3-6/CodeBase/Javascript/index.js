    if(sessionStorage.getItem("logged")=="false" || sessionStorage.getItem("logged")==null) {
        $("#login").show();//css("visibility", "block");
        $("#signup").show();//css("visibility", "block");
        $("#logout").hide();
        $("#perm").hide();
        $("#vote").attr("href", "../Frontend/login.html");
        $("#addr").hide();
    }
    else if(sessionStorage.getItem("key")!=null) {
        $("#logout").show();
        $("#login").hide();//css("visibility", "none");
        $("#signup").hide();//css("visibility", "none");
        $("#vote").attr("href", "../Frontend/ballot.html");

        if(sessionStorage.getItem("Logged_group")=="staff")
            $("#perm").show();
        if(sessionStorage.getItem("Logged_group")=="voter")
            $("#addr").show();
    }

    //alert(sessionStorage.getItem("key"));

    $("#logout").on("click", function () {
        sessionStorage.clear();
    });

