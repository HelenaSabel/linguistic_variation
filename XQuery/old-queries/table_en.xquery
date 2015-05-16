xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $fenomenos := doc('/db/exemplos/feature_library_EN.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-A4_draft.xml')//tei:div[@type='poem']
let $ling := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
let $graph := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#graph')]]/@xml:id]
let $error := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#Error')]]/@xml:id]
let $poets := doc('/db/exemplos/corpus_autores.xml')//tei:person
return 
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Estudos lingüísticos</title>
    </head>
    <body>
        <h2 id="Ling">Linguistic variation</h2>
        <table class="sortable">
            <thead>
                <tr class="head">
                    <th>Phenomenon </th>
                    <th>Variant </th>
                    <th>Witness </th>
                    <th>Copyist </th>
                    <th>Author </th>
                    <th>Period </th>
                    <th>Song </th>
                    <th>Line </th>
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
                    (if (string-length($fen) = 0) then '<span class="normal">omission</span>'
                    else transform:transform($fen,'xmldb:exist:///db/ex.xsl',())
))||' (<span class="normal">vs</span>. '||
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg 
                    else 
                    if (string-length($fen/../*[not(@wit = $fen/@wit)]) = 0) then '<span class="normal">omission</span>' else $fen/../*[not(@wit = $fen/@wit)]/transform:transform(.,'xmldb:exist:///db/ex.xsl',()))||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                     <td>{$fen/ancestor::tei:div[1]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::tei:l/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>
        <h2 id="Graph">Graphic variants</h2>
        <table class="sortable">
            <thead>
                <tr class="head">
                   <th>Phenomenon </th>
                    <th>Variant </th>
                    <th>Witness </th>
                    <th>Copyist </th>
                    <th>Author </th>
                    <th>Period </th>
                    <th>Song </th>
                    <th>Line </th>
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
                    <td>{(if ($fen//tei:choice) then $fen//tei:reg else 
                    (if (string-length($fen) = 0) then '<span class="normal">omission</span>'
                    else transform:transform($fen,'xmldb:exist:///db/ex.xsl',())
))||' (<span class="normal">vs</span>. '||
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg 
                    else 
                    if (string-length($fen/../*[not(@wit = $fen/@wit)]) = 0) then '<span class="normal">omission</span>' else $fen/../*[not(@wit = $fen/@wit)]/transform:transform(.,'xmldb:exist:///db/ex.xsl',()))||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                     <td>{$fen/ancestor::tei:div[1]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::tei:l/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>
    <h2 id="Error">Scribal errors</h2>
        <table class="sortable">
            <thead>
                <tr class="head">
                   <th>Phenomenon </th>
                    <th>Variant </th>
                    <th>Witness </th>
                    <th>Copyist </th>
                    <th>Author </th>
                    <th>Period </th>
                    <th>Song </th>
                    <th>Line </th>
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
                    <td>{(if ($fen//tei:choice) then $fen//tei:reg else 
                    (if (string-length($fen) = 0) then '<span class="normal">omission</span>'
                    else transform:transform($fen,'xmldb:exist:///db/ex.xsl',())
))||' (<span class="normal">vs</span>. '||
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg 
                    else 
                    if (string-length($fen/../*[not(@wit = $fen/@wit)]) = 0) then '<span class="normal">omission</span>' else $fen/../*[not(@wit = $fen/@wit)]/transform:transform(.,'xmldb:exist:///db/ex.xsl',()))||')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{$fen/ancestor::*[name()='div'[1]]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                     <td>{$fen/ancestor::tei:div[1]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::tei:l/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>
    </body>
    </html>
