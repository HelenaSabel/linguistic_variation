xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $fenomenos := doc('/db/exemplos/feature_library.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-A4_draft.xml')//tei:div[@type='poem']
let $ling := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
let $graph := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#graph')]]/@xml:id]
let $error := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#Error')]]/@xml:id]
let $poets := doc('/db/exemplos/corpus_autores.xml')//tei:person

(: Problemas que resolver: 
    1. Tratar os elementos <gap> e omissons
    2. Formatar <ex> 
    
    :)


return 
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Estudos lingüísticos</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="CSS/index.css" rel="stylesheet" type="text/css" />
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
        <script src="JavaScript/menu.js" type="text/javascript">/**/</script>
        <script type="text/javascript" src="javaScript/sorttable.js">/**/</script>
    </head>
    <body>
        <h1>Lírica galego-portuguesa</h1>
        <div class="body">
            <!--#include virtual="SSI/menu.html" -->
            <div class="banner"><img src="images/banner-ms.jpg" alt="banner" /></div>
            <div class="container">
                <div class="main">
                <h2 id="ling">Variaçom lingüística</h2>
        <table class="sortable">
            <thead>
                <tr class="head">
                    <th>Fenómeno</th>
                    <th>Variante</th>
                    <th>Testemunho</th>
                    <th>Copista</th>
                    <th>Autor</th>
                    <th>Período</th>
                    <th>Cantiga</th>
                    <th>Linha</th>
                </tr>
            </thead>
            <tbody>
            {for $fen in $ling
            let $author := $poets[@xml:id = $fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2)]
            return
            for $ana in $fen/tokenize(replace(@ana, '#', ''), ' ')[. = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
            return
                <tr>
                    <td class="intro">{$fenomenos[@xml:id = $ana]/@n/string()}</td>
                    <td>{(if ($fen//tei:choice) then $fen//tei:reg else 
                    (if (string-length($fen) = 0) then 'omisión'
                    else $fen/string()))||' (vs. '||
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg/string() 
                    else 
                    if (string-length($fen/../*[not(@wit = $fen/@wit)]) = 0) then 'omisión' else $fen/../*[not(@wit = $fen/@wit)]/string())||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                    <td>{$fen/ancestor::*[name() ='div'[1]]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::*[name()='l']/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>
        <h2 id="graph">Variaçom gráfica</h2>
        <table class="sortable">
            <thead>
                <tr class="head">
                    <th>Fenómeno</th>
                    <th>Variante</th>
                    <th>Testemunho</th>
                    <th>Copista</th>
                    <th>Autor</th>
                    <th>Período</th>
                    <th>Cantiga</th>
                    <th>Linha</th>
                </tr>
            </thead>
            <tbody>
            {for $fen in $graph
            let $author := $poets[@xml:id = $fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2)]
            return
            for $ana in $fen/tokenize(replace(@ana, '#', ''), ' ')[. = $fenomenos[@feats[contains(., '#graph')]]/@xml:id]
            return
                <tr>
                    <td class="intro">{$fenomenos[@xml:id = $ana]/@n/string()}</td>
                    <td>{(if ($fen//tei:choice) then $fen//tei:reg else $fen/string())||' (vs. '||
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg/string() 
                    else $fen/../*[not(@wit = $fen/@wit)]/string())||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                    <td>{$fen/ancestor::*[name() ='div'[1]]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::*[name()='l']/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>
    <h2 id="error">Erros de cópia</h2>
        <table class="sortable">
            <thead>
                <tr class="head">
                    <th>Fenómeno</th>
                    <th>Variante</th>
                    <th>Testemunho</th>
                    <th>Copista</th>
                    <th>Autor</th>
                    <th>Período</th>
                    <th>Cantiga</th>
                    <th>Linha</th>
                </tr>
            </thead>
            <tbody>
            {for $fen in $error
            let $author := $poets[@xml:id = $fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2)]
            return
            for $ana in $fen/tokenize(replace(@ana, '#', ''), ' ')[. = $fenomenos[@feats[contains(., '#Error')]]/@xml:id]
            return
                <tr>
                    <td class="intro">{$fenomenos[@xml:id = $ana]/@n/string()}</td>
                    <td>{(if ($fen//tei:choice) then $fen//tei:reg else $fen/string())||' (vs. '||
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg/string() 
                    else $fen/../*[not(@wit = $fen/@wit)]/string())||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                    <td>{$fen/ancestor::*[name() ='div'[1]]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::*[name()='l']/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>
        </div>
        <div class="rightSide">
            <h3>Conteúdos</h3>
                    <ul>
                        <li><a href="#ling">Variaçom lingüística</a></li>
                        <li><a href="#graph">Variaçom gráfica</a></li>
                        <li><a href="#error">Erros de cópia</a></li>
                    </ul>
        </div>
        </div>
        </div>
    </body>
    </html>
