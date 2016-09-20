<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Edição tabular</title>
    <meta charset="utf-8" lang="pt"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="css/project.css" rel="stylesheet" type="text/css"/>
    <script src="javascript/menu.js" type="text/javascript">/**/</script>
    <script src="javascript/language.js" type="text/javascript">/**/</script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
    <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
            type="text/javascript">/**/</script>
    <script src="javascript/header.js" type="text/javascript">/**/</script>
    <script src="javascript/checkboxes.js" type="text/javascript">/**/</script>
    <script src="javascript/tooltip.js" type="text/javascript">/**/</script>
    <script src="javascript/form.js" type="text/javascript">/**/</script>
    <!--#include virtual="ssi/favicon.html"-->
</head>
<body><!--#include virtual="ssi/header.html"-->
<main>
    <h1 class="center"><span class="pt">Edição</span><span class="gl">Edición</span><span class="gl pt"> tabular</span><span class="en">Tabular
                    edition</span>
    </h1>
    <div class="criterios"><h2><span class="en">Key</span><span class="pt"
            >Legenda</span><span class="gl">Lenda</span>
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
                    class="pt equipolent">Lições divergentes</span><span class="gl equipolent">Leccións diverxentes</span>
            </p>
        </div>
        <p><span class="en">Click on the colored or underlined form for additional
                        information</span><span class="pt">Clica na forma colorida ou sublinhada
                        para ler informação adicional</span><span class="gl">Fai click na forma colorida ou subliñada para ler información adicional</span>.</p>
        <h3><span  class="en">Edition criteria</span><span class="pt">Critérios de edição</span><span class="gl">Criterios de edición</span></h3>
        <form class="criteria">
            <fieldset><span><input type="radio" name="abbreviation" value="expan"
                                  id="expan"/><label for="expan"><span class="en">Expanded
                        abbreviations</span><span class="pt gl">Desenvolv<span class="pt">i</span><span class="gl">e</span>mento de abreviaturas</span></label></span>
                        <span><input type="radio" checked="checked" name="abbreviation" value="abb" id="abb"/><label
                        for="abb"><span class="en">Abbreviation
                        markers</span><span class="pt gl">Signos de abrevia<span class="pt">ção</span><span class="gl">ción</span></span></label></span>
            </fieldset>
            <fieldset><span><input type="radio" id="reg" name="hyphen" value="reg"
                    /><label for="reg"><span class="en">Hyphenated clitics and allomoph articles</span><span
                                                                                                         class="pt gl">Clíticos
                        e segunda forma do artigo <span class="pt">com hífen</span><span class="gl">con trazo</span></span></label></span><span><input  checked="checked"
                        type="radio" name="hyphen" value="orig" id="orig"/><label for="orig"><span class="en">Original
                        disposition of clitics and allomorphs</span><span class="pt">Disposição original</span><span class="gl">Disposición orixinal</span> <span class="gl pt">de clíticos e artigos alomorfos</span></label></span>
            </fieldset>
            <fieldset><span><input type="checkbox" name="apostrophe" value="apostrophe" id="apostrophe"/><label for="apostrophe"><span class="en">Apostrophes to
                        detect
                        elisions</span><span class="pt">Apóstrofes nas elisões
                        vocálicas</span><span class="gl">Apóstrofos nas elisións vocálicas</span></label></span><span><input type="checkbox" name="add" value="add" id="add"  checked="checked"/><label
                        for="add"><span
                        class="pt gl">Identificar visualmente as adi<span class="pt">ções</span><span class="gl">cións</span></span><span class="en"
                    >Identification of additions</span></label></span><span><input type="checkbox" name="del" id="del"  checked="checked"
                                                                            value="del"/><label for="del"><span class="pt">Ver as
                        cancelações</span><span class="gl">Ver as cancelacións</span><span
                                                  class="en"
                    >View deletations</span></label></span>
            </fieldset>
        </form>
    </div>
    <?php

    $value = $_SERVER['QUERY_STRING'];
    require_once('config.php');
    $query = REST_PATH . "/db/VTLGP/queries/tabular.xquery?" . $value;
    echo file_get_contents($query);

    ?>
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>
