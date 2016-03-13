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
            <p class="en">Place holder text.</p>
            <p class="pt">Apesar da abrangente bibliografia que compreende o estudo da lírica profana galego-portuguesa, ficam ainda muitas incógnitas
             que a crítica literária deve resolver, sendo especialmente numerosas no tocante a sua génese. Justamente, a caracterização 
             linguística de cada um dos testemunhos que conformam uma tradição manuscrita aporta informação determinante a respeito da 
             sua confeção, o que nos leva a poder explicar não só a elaboração dos testemunhos escritos, mas a evolução sócio-histórica 
             da escola literário analisada. Para focar este tipo de análise linguística, apostamos pelo estudo do fenómeno da variação, 
             pois, ao analisarmos os aspetos que variam de um manuscrito para o outro estamos identificando o que cada um de eles tem
              em particular, delimitando, assim, o ingente objeto de estudo.</p>
            <h2><span class="pt">Corpus estudado</span><span class="en">Composition of the corpus</span></h2>
            <?php
            require_once('config.php');
            $xql = REST_PATH . "/db/VTLGP/queries/songs-by-period.xquery";
            echo file_get_contents($xql);
         ?>  
         <h2><span class="pt">Metodologia</span><span class="en">Methodology</span></h2>
         <p class="pt">A nossa proposta para sistematizar o estudo da variação linguística na lírica profana galego-portuguesa, consiste
          numa edição digital sinóptica. A grandes traços, fundamenta-se na colação de cada uma das leituras de todos os testemunhos conservados,
           contrastando cada forma e signo automaticamente. O suporte da edição é a linguagem de marcas XML e esta marcação faz-se seguindo as normas
            estabelecidas pela Text Encoding Initiative (TEI). Concretamente, utilizamos o método de segmentação em paralelo, pois permite a 
            codificação de várias versões dum mesmo texto num único documento.</p>
<p class="pt">Esta anotação facilita a identificação de cada variante para posteriormente ser categorizada. Para marcá-las e defini-las, utilizamos as chamadas “estruturas de traços”
 (Feature Structures). Assim, criamos uma livraria de traços mínimos com o fim de categorizar as variantes atendendo à sua tipologia (erros de cópia, variantes de língua,
  lições equipolentes ou variantes gráficas). Evidentemente, os valores que conformam o conteúdo de cada estrutura de traços que define um fenómeno linguístico são muito
   mais complexos (em quantidade e concreção) que aqueles que utilizamos para definir as outras tipologias de variação. </p>
<p class="pt">A flexibilidade na hora de combinar os traços mínimos e a especificidade com que são definidos permite-nos extrair com muita precisão os fenómenos de variação linguística. 
Para extrair e manipular eficazmente a complexa informação contida em esta marcação utilizamos um gestor de bases de dados não-SQL e a linguagem de consulta XQuery.</p>
         <h3>Workflow</h3>
            <div class="mxgraph">
<div>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</div>
</div>
<script type="text/javascript" src="https://www.draw.io/js/embed-static.min.js"></script>
        </main>
        <!--#include virtual="ssi/footer.html"-->
    </body>
</html>
