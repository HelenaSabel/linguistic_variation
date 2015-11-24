xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $poets := doc('/db/tese/drafts/ancillary/corpus_autores.xml')//tei:person
let $songs := collection('/db/tese/drafts/songs')//tei:div[@type='poem']
return count($songs[.//tei:name/substring(@ref,2) = $poets/tei:floruit[./@period = '3']/../@xml:id])