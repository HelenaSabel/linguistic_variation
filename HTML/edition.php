<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Edição sinóptica</title>
    <meta charset="utf-8" lang="pt"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="css/project.css" rel="stylesheet" type="text/css"/>
    <script src="javascript/menu.js" type="text/javascript">/**/</script>
    <script src="javascript/language.js" type="text/javascript">/**/</script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
    <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
            type="text/javascript">/**/</script>
    <script src="javascript/sidebar.js" type="text/javascript">/**/</script>
    <script src="javascript/checkboxes.js" type="text/javascript">/**/</script>
    <script src="javascript/tooltip.js" type="text/javascript">/**/</script>
    <script src="javascript/form.js" type="text/javascript">/**/</script>
    <script src="javascript/criteria.js" type="text/javascript">/**/</script>
    <!--#include virtual="ssi/favicon.html"-->
</head>
<body><!--#include virtual="ssi/header.html"-->
<main>
    <h1 class="center"><span class="pt">Edição</span><span class="gl">Edición</span><span class="gl pt"> sinóptica</span><span class="en">Synoptic
                    edition</span>
    </h1>
    <div class="criterios"><h2><span class="en">Key</span><span class="pt"
            >Legenda</span>
        </h2>
        <div class="flex">
            <p>
                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22"
                     viewBox="0 0 22 22">
                    <rect width="20" height="20" x="1" y="1" rx="4" ry="4" fill="#77659D"
                          stroke-width="1" stroke="black"></rect>
                </svg>
                <span class="pt gl linguistic">Variantes de l<span class="pt">í</span><span class="gl">i</span>ngua</span><span
                    class="en linguistic">Linguistic variants</span>
            </p>
            <p>
                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22"
                     viewBox="0 0 22 22">
                    <rect width="20" height="20" x="1" y="1" rx="4" ry="4" fill="#D14205"
                          stroke-width="1" stroke="black"></rect>
                </svg>
                <span class="pt gl error">Erros</span><span class="en error"
                >Errors</span>
            </p>
            <p><span class="en graphic">Graphic variants</span><span class="pt gl graphic"
                >Variantes gráficas</span>
            </p>
            <p><span class="en equipolent">Divergent readings</span><span
                    class="pt equipolent">Lições divergentes</span><span class="gl">Leccións diverxentes</span>
            </p>
        </div>
        <p><span class="en">Click on the colored or underlined form for additional
                        information</span><span class="pt">Clica na forma colorida ou sublinhada
                        para ler informação adicional</span><span class="gl">Fai click na forma colorida ou subliñada para ler información adicional</span>.</p>
        <h3><span  class="en">Edition criteria</span><span class="pt">Critérios de edição</span><span class="gl">Criterios de edición</span></h3>
        <form class="criteria">
            <fieldset><span><input type="radio" name="abbreviation" value="expan"
                                  id="expan"/><label for="expan" class="en">Expanded
                        abbreviations</label><label for="expan"
                                                    class="pt">Desenvolvimento de
                        abreviaturas</label></span><span><input type="radio" checked="checked"
                                                                name="abbreviation" value="abb" id="abb"/><label
                        for="abb"
                        class="en">Abbreviation
                        markers</label><label for="abb" class="pt">Signos de abreviação</label></span>
            </fieldset>
            <fieldset><span><input type="radio" id="reg" name="hyphen" value="reg"
                    /><label for="reg" class="en">Hyphenated clitics and allomoph articles</label><label for="reg"
                                                                                                         class="pt">Clíticos
                        e segunda forma do artigo com hífen</label></span><span><input  checked="checked"
                        type="radio" name="hyphen" value="orig" id="orig"/><label for="orig" class="en">Original
                        disposition of clitics and allomorphs</label><label for="orig" class="pt">Conservação
                        da disposição original de clíticos e artigos alomorfos</label></span>
            </fieldset>
            <fieldset><span><input type="checkbox" name="apostrophe" value="apostrophe" id="apostrophe"/><label class="en" for="apostrophe">Apostrophes to
                        detect
                        elisions</label><label for="apostrophe" class="pt">Apóstrofes nas elisões
                        vocálicas</label></span><span><input type="checkbox" name="add" value="add" id="add"/><label
                        for="add"
                        class="pt">Identificar visualmente as adições</label><label for="add" class="en"
                    >Identification of additions</label></span><span><input type="checkbox" name="del" id="del"
                                                                            value="del"/><label for="del" class="pt">Ver
                        cancelações</label><label for="del"
                                                  class="en"
                    >View deletations</label></span>
            </fieldset>
        </form>
    </div>

<!--
    -->
   <!-- require_once('config.php');
    $url = REST_PATH . "/db/VTLGP/queries/edition.xquery";
    $value = htmlspecialchars($_POST['author']);
    $data = array('author' => $value);
    $options = array(
        'http' => array(
            'header' => "Content-type: application/x-www-form-urlencoded\r\n",
            'method' => 'POST',
            'content' => http_build_query($data)
        )
    );
    $context = stream_context_create($options);
    $result = file_get_contents($url, false, $context);
    if ($result === FALSE) { /* Handle error */
    }

    var_dump($result);
    echo $result;-->



    <?php
    $songs = $_GET["song"];
    $songValues = implode(",", $songs);
    $authors = $_GET["author"];
    $authorValues = implode(",", $authors);
    $scribes = $_GET["scribe"];
    $scribeValues = implode(",", $scribes);
    $line = $_GET["line"];
    require_once('config.php');
    $query = REST_PATH . "/db/VTLGP/queries/edition.xquery?song=" . $songValues . "&author=" . $authorValues .
         "&scribe=" . $scribeValues . "&line=" . $line;
    echo file_get_contents($query);

    ?>




    <div class="footer"></div>
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>
