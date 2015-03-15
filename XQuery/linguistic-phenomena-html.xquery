xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $fenomenos := doc('/db/exemplos/feature_library.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-A4_draft.xml')//tei:div[@type='poem']
let $ling := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
let $poets := doc('/db/exemplos/corpus_autores.xml')//tei:person
return 
<html>
    <head>
        <title>Linguistic phenomena</title>
        <meta charset="utf-8" />
        <link href="CSS/temporary.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="javaScript/sortable.js">/**/</script>
    </head>
    <body>
        <h1>Linguistic phenomena</h1>
        <table class="sortable">
            <thead>
                <tr class="head">
                    <th>Phenomenum</th>
                    <th>Variant</th>
                    <th>Witness(es)</th>
                    <th>Copyist</th>
                    <th>Author</th>
                    <th>Period</th>
                    <th>Song</th>
                    <th>Line</th>
                </tr>
            </thead>
            <tbody>
            {for $fen in $ling
            let $author := $poets[@xml:id = $fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2)]
            return
            for $ana in $fen/tokenize(replace(@ana, '#', ''), ' ')
            return
                <tr>
                    <td class="intro">{$fenomenos[@xml:id = $ana]//comment()[2]/string()}</td>
                    <td>{(if ($fen//tei:choice) then $fen//tei:orig else $fen/string())||' (vs. '||
                    (if ($fen/../tei:rdg[. ne $fen]/tei:choice) then $fen/../tei:rdg[. ne $fen]//tei:orig else $fen/../tei:rdg[. ne $fen])||')'}</td>
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
    </body>
</html>