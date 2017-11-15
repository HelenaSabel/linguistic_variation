<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Resultados</title>
    <meta charset="utf-8" lang="pt"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="css/project.css" rel="stylesheet" type="text/css"/>
    <script src="javascript/menu.js" type="text/javascript">/**/</script>
    <script src="javascript/language.js" type="text/javascript">/**/</script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
    <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
            type="text/javascript">/**/</script>
    <script src="javascript/sidebar.js" type="text/javascript">/**/</script>
    <script src="javascript/sorttable.js" type="text/javascript">/**/</script>

    <!--#include virtual="ssi/favicon.html"-->
</head>
<body><!--#include virtual="ssi/header.html"-->
<main>
    <h1><span class="gl">Variantes de lingua</span><span class="en">Linguistic
                    variants</span><span class="pt">Variantes de língua</h1>

    <?php
    $parameters = $_GET['phenomenon'];
    $values = implode(",", $parameters);
    require_once('config.php');
    $query = REST_PATH . "/db/VTLGP/queries/ling.xquery?phenomenon=" . $values;
    echo file_get_contents($query);
    ?>

    <div class="footer"></div>
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>
