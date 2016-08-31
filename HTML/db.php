<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title>Formulário</title>
        <meta charset="utf-8" lang="pt" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="css/project.css" rel="stylesheet" type="text/css" />
        <script src="javascript/menu.js" type="text/javascript">/**/</script>
        <script src="javascript/show.js" type="text/javascript">/**/</script>
        <script src="javascript/deselect.js" type="text/javascript">/**/</script>
        <script src="javascript/language.js" type="text/javascript">/**/</script>
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
        <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
                type="text/javascript">/**/</script>
        <script src="javascript/header.js" type="text/javascript">/**/</script>
        <script src="javascript/menu.js" type="text/javascript">/**/</script>
        <!--#include virtual="ssi/favicon.html"-->
    </head>
    <body><!--#include virtual="ssi/header.html"-->
        <main>
            <h1><span class="pt gl">Fenómenos de varia<span class="pt">ção</span><span class="gl">ción</span></span><span class="en">Variation phenomena</span></h1>
            <h2><span class="pt gl">Variantes de li<span class="pt">&#769;</span>ngua</span><span class="en">Linguistic variants</span></h2>
            <?php 
                require_once('config.php');
                $xqul = REST_PATH . "/db/VTLGP/queries/form.xquery";
                echo file_get_contents($xqul);
         ?>
        </main>
        <!--#include virtual="ssi/footer.html"-->
    </body>
</html>
