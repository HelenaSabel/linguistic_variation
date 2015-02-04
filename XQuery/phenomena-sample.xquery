xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $fenomenos := doc('/db/exemplos/feature_library.xml')//tei:fs
let $cantigas := doc('/db/exemplos/A1-3_draft.xml')//tei:div[@type='poem']
let $oer := $cantigas//tei:rdg[substring(@ana, 2) = $fenomenos/@xml:id[. = 'o']]
for $fen in $oer
return concat('Fenómeno ', $fen/string(), ', cantiga ', $fen/../../../../substring(@corresp, 2), ', liña ',  $fen/../../@n/string())
