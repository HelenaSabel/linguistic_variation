<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
   <head>
      <title>Corpus</title>
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
         <h1>Corpus</h1>
         <h2 class="pt gl">Por autor</h2>
         <h2 class="en">By author</h2>         
         <?php
            require_once('config.php');
            $xql = REST_PATH . "/db/VTLGP/queries/corpus.xquery";
            echo file_get_contents($xql);
         ?>         
      </main>
      <!--#include virtual="ssi/footer.html"-->
   </body>
</html>
