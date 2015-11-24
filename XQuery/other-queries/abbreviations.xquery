xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $songs := collection('/db/VTLGP')//tei:div[@type='poem']
let $fenomena := doc('/db/VTLGP/feature_library.xml')//tei:fs[@xml:id eq 'vus']
let $exemplos := $songs//tei:rdg[contains(tei:ex[preceding-sibling::text()[contains(.,'q')]], 'uan')]
for $exemplo in $exemplos
return $exemplo/ancestor::*[name() eq 'div']/@corresp/string() || '-' || $exemplo/@wit