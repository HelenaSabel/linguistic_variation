xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $songs := collection('/db/tese/drafts/songs')//tei:div[@type='poem']
let $fenomena := doc('/db/tese/drafts/ancillary/feature_library.xml')//tei:fs[@xml:id eq 'vus']
let $exemplos := $songs//tei:rdg[contains(tei:ex[not(preceding-sibling::text()[contains(.,'p')])], 'er')]
for $exemplo in $exemplos
return $exemplo/ancestor::*[name() eq 'div']/@corresp/string() || '-' || $exemplo/@wit
