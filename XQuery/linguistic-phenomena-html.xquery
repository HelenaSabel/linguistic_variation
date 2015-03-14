xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $fenomenos := doc('/db/exemplos/feature_library.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-3_draft.xml')//tei:div[@type='poem']
let $ling := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
let $poets := doc('/db/exemplos/corpus_autores.xml')//tei:person
return 
<html>
    <head>
        <title>Linguistic phenomena</title>
        <meta charset="utf-8" />
        <link href="CSS/index.css" rel="stylesheet" type="text/css" />
        <link href="CSS/sortable-table.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="javaScript/sorttable.js">/**/</script>
        <style>table, th, td &#123;
   border: 1px solid black;
&#125; </style>
    </head>
    <body>
        <h1>Linguistic phenomena</h1>
        <table>
            <tr>
                <th>Phenomenum</th>
                <th>Variant</th>
                <th>Witness</th>
                <th>Author</th>
                <th>Period</th>
                <th>Song</th>
                <th>Line</th>
            </tr>
            {for $fen in $ling
            let $author := $poets[@xml:id = $fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2)]
            return
                <tr>
                    <td>{$fenomenos[@xml:id =  $fen/substring(@ana, 2)]//comment()/string()}</td>
                    <td>{(if ($fen//tei:choice) then $fen//tei:orig else $fen/string())||' (vs. '||
                    (if ($fen/../tei:rdg[. ne $fen]/tei:choice) then $fen/../tei:rdg[. ne $fen]//tei:orig else $fen/../tei:rdg[. ne $fen])||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$author/tei:persName}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                    <td>{$fen/ancestor::*[name() = 'div'[1]]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::*[name()='l']/@n/string()}</td>
                </tr>
             }
        </table>
    </body>
</html>