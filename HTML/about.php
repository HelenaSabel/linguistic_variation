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

    <!--#include virtual="ssi/favicon.html"-->
</head>
<body><!--#include virtual="ssi/header.html"-->
<main>
    <h1><span class="pt">Apresentação</span><span class="en">About</span><span class="gl">Presentación</span></h1>
    <h2><span class="pt">O que posso encontrar neste site?</span><span class="en">What you will find in this site</span>
        <span class="gl">Que podo encontrar neste portal?</span>
    </h2>
    <p><span class="en">Place holder text.</span><span class="gl">(En curso)</span><span class="pt">Apesar da abrangente bibliografia que compreende o estudo da lírica profana galego-portuguesa, ficam
        ainda muitas incógnitas
        que a crítica literária deve resolver, sendo especialmente numerosas no tocante a sua génese. Justamente, a
        caracterização
        linguística de cada um dos testemunhos que conformam uma tradição manuscrita aporta informação determinante a
        respeito da
        sua confeção, o que nos leva a poder explicar não só a elaboração dos testemunhos escritos, mas a evolução
        sócio-histórica
            da escola literária analisada. Para focar este tipo de análise linguística, apostamos pelo estudo do fenómeno da
        variação,
        pois, ao analisarmos os aspetos que variam de um manuscrito para o outro estamos identificando o que cada um de
        eles tem
        em particular, delimitando, assim, o ingente objeto de estudo.</span></p>
    <h2><span class="pt gl">Corpus estudado</span><span class="en">Composition of the corpus</span></h2>
    <p><span class="pt gl">Neste momento, o corpus estudado está conformado por</span><span class="en">At this point, the corpus is composed of</span>
            <?php
            require_once('config.php');
            $xql = REST_PATH . "/db/VTLGP/queries/count.xquery";
            echo file_get_contents($xql);
            ?>
            <span class="gl pt">cantigas, compostas por</span><span class="en">songs written by</span> <?php
            require_once('config.php');
            $xql = REST_PATH . "/db/VTLGP/queries/count2.xquery";
            echo file_get_contents($xql);
            ?> <span class="pt"> trovadores.</span><span class="gl">trobadores.</span><span class="en"> troubadours.</span></p>
    <h3><span class="gl pt">Textos</span><span class="en">Texts</span></h3>
    <!--#include virtual="ssi/corpus.svg"-->
    <?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/corpus-composition.xquery";
    echo file_get_contents($xql);
    ?>
    <!--<p><a href="visualizations.php"><span class="pt gl">Outras <span class="pt">visualizações</span><span class="gl">visualizacións</span> (incompleto)</span><span class="en">Additional visualizations (in progress)</span>.</a></p>-->
    <h2><span class="pt">Metodologia</span><span class="en">Methodology</span><span class="gl">Metodoloxía<span></h2>
    <p><span class="pt">A nossa proposta para sistematizar o estudo da variação linguística na lírica profana
        galego-portuguesa, consiste
        numa edição digital sinóptica. A grandes traços, fundamenta-se na colação de cada uma das leituras de todos os
        testemunhos conservados,
        contrastando cada forma e signo automaticamente. O suporte da edição é a linguagem de marcas XML e esta marcação
        faz-se seguindo as normas
        estabelecidas pela Text Encoding Initiative (TEI). Concretamente, utilizamos o método de segmentação em
        paralelo, pois permite a
        codificação de várias versões dum mesmo texto num único documento.</span><span class="en">Place holder text.</span><span class="gl">(En curso)</span></p>
    <p><span class="pt">Esta anotação facilita a identificação de cada variante para posteriormente ser categorizada. Para
        marcá-las e defini-las, utilizamos as chamadas “estruturas de traços”
        (Feature Structures). Assim, criamos uma livraria de traços mínimos com o fim de categorizar as variantes
        atendendo à sua tipologia (erros de cópia, variantes de língua,
        lições equipolentes ou variantes gráficas). Evidentemente, os valores que conformam o conteúdo de cada estrutura
        de traços que define um fenómeno linguístico são muito
        mais complexos (em quantidade e concreção) que aqueles que utilizamos para definir as outras tipologias de
        variação.</span></p>
    <p><span class="pt">A flexibilidade na hora de combinar os traços mínimos e a especificidade com que são definidos
        permite-nos extrair com muita precisão os fenómenos de variação linguística.
        Para extrair e manipular eficazmente a complexa informação contida em esta marcação utilizamos um gestor de
        bases de dados não-SQL e a linguagem de consulta XQuery.</span></p>
    <h3>Workflow</h3>
    <div class="mxgraph">
        <div>
            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
        </div>
    </div>
    <script type="text/javascript" src="https://www.draw.io/js/embed-static.min.js"></script>
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>
