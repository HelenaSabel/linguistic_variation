xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
return
    count($songs)