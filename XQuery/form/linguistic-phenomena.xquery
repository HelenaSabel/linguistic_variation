xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $fenomenos := doc('/db/exemplos/feature_library.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-3_draft.xml')//tei:div[@type='poem']
let $ling := $cantigas//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos[@feats[contains(., '#ling')]]/@xml:id]
for $fen in $ling
return concat('Variante ', $fen/string(), ', testemuño ', $fen/substring(@wit, 2), ', cantiga ', $fen/ancestor::*[name() = 'div'[1]]/substring(@corresp, 2), 
', autor ', $fen/ancestor::*[name()='div'[1]]//tei:name/substring(@ref,2), ', liña ',  $fen/ancestor::*[name()='l']/@n/string() )