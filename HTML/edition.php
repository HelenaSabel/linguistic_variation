<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title>Edição sinóptica</title>
        <meta charset="utf-8" lang="pt" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="css/project.css" rel="stylesheet" type="text/css" />
        <script src="javascript/menu.js" type="text/javascript">/**/</script>
        <script src="javascript/language.js" type="text/javascript">/**/</script>
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
        <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js" type="text/javascript">/**/</script>
        <script src="javascript/sidebar.js" type="text/javascript">/**/</script>
        <script src="javascript/checkboxes.js" type="text/javascript">/**/</script>
        <script src="javascript/tooltip.js" type="text/javascript">/**/</script>
        <script src="javascript/form.js" type="text/javascript">/**/</script>
        <script src="javascript/criteria.js" type="text/javascript">/**/</script>
        <!--#include virtual="ssi/favicon.html"-->
    </head>
    <body><!--#include virtual="ssi/header.html"-->
        <main>
            <h1 class="center"><span class="pt">Edição sinóptica</span><span class="en">Synoptic
                    edition</span>
            </h1>
            <div class="criterios"><h2><span class="en">Edition criteria</span><span class="pt"
                        >Critérios de edição</span>
                </h2>
                <div class="flex">
                    <p><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22"
                            viewBox="0 0 22 22">
                            <rect width="20" height="20" x="1" y="1" rx="4" ry="4" fill="#2B3966"
                                stroke-width="1" stroke="black"></rect>
                        </svg><span class="pt linguistic">Variantes de língua</span><span
                            class="en linguistic">Linguistic variants</span>
                    </p>
                    <p><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22"
                            viewBox="0 0 22 22">
                            <rect width="20" height="20" x="1" y="1" rx="4" ry="4" fill="#D14205"
                                stroke-width="1" stroke="black"></rect>
                        </svg><span class="pt error">Erros de cópia</span><span class="en error"
                            >Scribal errors</span>
                    </p>
                    <p><span class="en graphic">Graphic variants</span><span class="pt graphic"
                            >Variantes gráficas</span>
                    </p>
                    <p><span class="en equipolent">Equipolent readings</span><span
                            class="pt equipolent">Lições equipolentes</span>
                    </p>
                </div>
                <p><span class="en">Click on the colored or underlined form for additional
                        information</span><span class="pt">Clica na forma colorida ou sublinhada
                        para ler informação adicional</span>.</p>
                <h3 class="en">Other criteria</h3>
                <h3 class="pt">Outros critérios</h3>
                <form class="criteria">
                    <fieldset><input type="radio" name="abbreviation" value="expan"
                            checked="checked" /><span class="en">Expanded abbreviations</span><span
                            class="pt">Desenvolvimento de abreviaturas</span><input type="radio"
                            name="abbreviation" value="abb" /><span class="en">Abbreviation
                            markers</span><span class="pt">Signos de abreviação</span>
                    </fieldset>
                    <fieldset><input type="radio" name="hyphen" value="reg" checked="checked"
                             /><span class="en">Hyphenated clitics and allomoph articles</span><span
                            class="pt">Clíticos e segunda forma do artigo com hífen</span><input
                            type="radio" name="hyphen" value="orig" /><span class="en">Original
                            disposition of clitics and allomorphs</span><span class="pt">Conservação
                            da disposição original de clíticos e artigos alomorfos</span>
                    </fieldset>
                    <fieldset><input type="checkbox" name="apostrophe" value="apostrophe"
                            checked="checked" /><span class="en">Apostrophes to detect
                            elisions</span><span class="pt">Apóstrofes nas elisões
                            vocálicas</span><input type="checkbox" name="add" value="add" /><span
                            class="pt">Identificar visualmente as adições</span><span class="en"
                            >Identification of additions</span><input type="checkbox" name="del"
                            value="del" /><span class="pt">Ver cancelações</span><span class="en"
                            >View deletations</span>
                    </fieldset>
                </form></div>
                <!--   
               <?php 
                foreach (array_keys($_GET) as $field)
                {
                $parameters = $_GET[$field];}
                $values = implode(",", $parameters);
                require_once('config.php');
                $query = REST_PATH . "/db/VTLGP/queries/edition.xquery?" . $field . "=" . $values;
                echo file_get_contents($query);
               
                ?>
            
               
<?php
                $fields = array_keys($_GET);
                $data = array();
                foreach ($fields as $field) {
                if (isset($_GET[$field])) {
                $data[$field] = $_GET[$field];}
                $values = implode(",", $data);}
                require_once('config.php');
                $query = REST_PATH . "/db/VTLGP/queries/edition.xquery?" . $field . "=" . $values;
                echo file_get_contents($query);
?>--> 
         <?php 
                
                $songs = $_GET["song"];
                $songValues = implode(",", $songs);
                $authors = $_GET["author"];
                $authorValues = implode(",", $authors);
                $periods = $_GET["period"];
                $periodValues = implode(",", $periods);
                $scribes = $_GET["scribe"];
                $scribeValues = implode(",", $scribes);
                require_once('config.php');
                $query = REST_PATH . "/db/VTLGP/queries/edition.xquery?song=" . $songValues . "&author=" . $authorValues .
                 "&period=" . $periodValues . "&scribe=" . $scribeValues;
                echo file_get_contents($query);
               
                ?>

            <div id="footer"></div>
        </main>
        <!--#include virtual="ssi/footer.html"-->
    </body>
</html>
