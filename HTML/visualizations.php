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
    <h1><span class="pt">Visualizações</span><span class="en">Visualizations</span></h1>
    <h2><span class="pt">Proporção de leituras comuns (escala fixa)</span><span
            class="en">Overlapping of common text (fixed)</span>
    </h2>
    <div class="en">
        <ul>
            <li>Graphic variants included as “common text”</li>
            <li>Explanation of the scaling process</li>
        </ul>
    </div>
    <div class="pt">
        <ul>
            <li>Variantes gráficas incluídas como “texto comum”</li>
            <li>Explicação da escala</li>
        </ul>
    </div>

    <?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/overlap-scaled.xquery";
    echo file_get_contents($xql);
    ?>
    <h2><span class="pt">Proporção de leituras comuns (escala proporcional)</span><span
            class="en">Overlapping of common text (scaled)</span>
    </h2>
    <div class="en">
        <ul>
            <li>Graphic variants included as “common text”</li>
            <li>Explanation of the scaling process</li>
        </ul>
    </div>
    <div class="pt">
        <ul>
            <li>Variantes gráficas incluídas como “texto comum”</li>
            <li>Explicação da escala</li>
        </ul>
    </div>
    <?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/overlap-non-scaled.xquery";
    echo file_get_contents($xql);
    ?>
    <h2><span class="pt">Variantes significativas</span><span class="en">Substantive variants</span> (I)</h2>
<?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/radar-plot.xquery";
    echo file_get_contents($xql);
    ?>
    <h2><span class="pt">Variantes significativas</span><span class="en">Substantive variants</span> (II)</h2>
    <?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/continous-graph.xquery";
    echo file_get_contents($xql);
    ?>
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>