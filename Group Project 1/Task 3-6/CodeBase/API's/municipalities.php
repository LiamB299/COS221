<?php

    include("database.php");

    // In a real life scenario this would be a cURL request to the back end.

page_top();
print_mun_codes();
page_bottom();

//========================================
//MUN codes data
function print_mun_codes() {
    $results = Database::instance()->getValuesCustom("SELECT name, type_of_mun, municipality.municipal_code from municipality
right join metro
on municipality.municipal_code = metro.municipal_code
union
SELECT name, type_of_mun, municipality.municipal_code from municipality
right join `local`
on municipality.municipal_code = `local`.municipal_code");

    foreach($results as $row) {
        echo "<tr>";
        echo "
        <td>".$row["name"]."</td>
        <td>".$row["type_of_mun"]."</td>
        <td>".$row["municipal_code"]."</td>
        ";
        echo "</tr>";
    }
}

    function page_top() {
        echo "
        <!DOCTYPE html>
        <html lang=\"en\">
            <link rel=\"stylesheet\" href=\"../CSS/munic.css\">
        <head>
            <meta charset=\"UTF-8\">
            <title>Municipality Codes</title>
        </head>
        <body>
            <div id=\"header\">Municipality Codes</div>
            <table>
                <th>City Area</th><th>Type of municipality</th><th>Municipality Code</th>
                <tr>
        ";
    }

    function page_bottom() {
        echo "
        </tr>
    </table>
</body>
<script src=\"https://code.JQuery.com/JQuery-3.4.1.min.js\"></script>
</html>
        ";
    }