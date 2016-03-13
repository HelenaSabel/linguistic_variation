<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title>Apresentação</title>
        <meta charset="utf-8" lang="pt" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="css/project.css" rel="stylesheet" type="text/css" />
        <script src="javascript/language.js" type="text/javascript">/**/</script>   
        <script src="javascript/menu.js" type="text/javascript">/**/</script>
        <!--#include virtual="ssi/favicon.html"-->
    </head>
    <body><!--#include virtual="ssi/header.html"-->
        <main>
            <h1><span class="pt">Apresentação</span><span class="en">About</span></h1>
            <h2><span class="pt">O que posso encontrar neste site?</span><span class="en">What you will find in this site</span></h2>
            <p>Place holder text</p>
            <h2><span class="pt">Corpus estudado</span><span class="en">Composition of the corpus</span></h2>
            <?php
            require_once('config.php');
            $xql = REST_PATH . "/db/VTLGP/queries/songs-by-period.xquery";
            echo file_get_contents($xql);
         ?>  
        </main>
        <!--#include virtual="ssi/footer.html"-->
    </body>
</html>
