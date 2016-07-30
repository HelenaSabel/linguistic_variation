<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Apresentação</title>
    <meta charset="utf-8" lang="pt"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="css/project.css" rel="stylesheet" type="text/css"/>
    <script src="javascript/language.js" type="text/javascript">/**/</script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
    <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
            type="text/javascript">/**/</script>
    <script src="javascript/header.js" type="text/javascript">/**/</script>
    <script src="javascript/menu.js" type="text/javascript">/**/</script>
    <script src="javascript/hide-show.js" type="text/javascript">/**/</script>

    <!--#include virtual="ssi/favicon.html"-->
</head>
<body><!--#include virtual="ssi/header.html"-->
<main>
    <h1><span class="pt">Visualizações</span><span class="en">Visualizations</span><span class="gl">Visualizacións</span></h1>
    <h2><span class="pt gl">Variantes significativas</span><span class="en">Substantive variants</span> (I)</h2>
    <!--#include virtual="ssi/sig-variants.svg"-->
        <h2><span class="pt">Variantes significativas</span><span class="en">Substantive variants</span> (II)</h2>
    <div class="radar">
        <!--#include virtual="ssi/radar-plot.svg"-->
        <?php
        require_once('config.php');
        $xql = REST_PATH . "/db/VTLGP/queries/radar-plot-form.xquery";
        echo file_get_contents($xql);
        ?>
    </div>
    <h2><span class="pt">Variantes de língua</span><span class="en">Linguistic variants</span></h2>
    <!--#include virtual="ssi/ling-variants.svg"-->
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>