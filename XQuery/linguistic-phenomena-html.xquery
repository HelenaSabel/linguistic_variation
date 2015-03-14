xquery version "3.0";(:
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";:)
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $fenomenos := doc('/db/exemplos/feature_library.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-3_draft.xml')//tei:div[@type='poem']
let $ling := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
let $label := $fenomenos//tei:f
return 
<html>
    <head>
        <title>Linguistic phenomena</title>
        <meta charset="utf-8" />
        <link href="CSS/index.css" rel="stylesheet" type="text/css" />
        <link href="CSS/sortable-table.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="javaScript/sorttable.js">/**/</script>
    </head>
    <body>
        <h1>Linguistic phenomena</h1>
        <table style="margin-left:auto;margin-right:auto;empty-cells:hide;border-collapse:collapse;color:black">
            <tr>
                <th>Phenomenum</th>
                <th>Variant</th>
                <th>Witness</th>
                <th>Author</th>
                <th>Song</th>
                <th>Line</th>
            </tr>
            {for $fen in $ling
            return
                <tr>
                    <td>{$label[@name = $fen/substring(@ana, 2)]}</td>
                    <td>{$fen/string()}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2)}</td>
                    <td>{$fen/ancestor::*[name() = 'div'[1]]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::*[name()='l']/@n/string()}</td>
                    </tr>
             }
        </table>
    </body>
</html>