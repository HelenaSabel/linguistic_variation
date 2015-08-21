declare namespace tei="http://www.tei-c.org/ns/1.0";
let $corpus:= doc('../dinis.xml')
let $sharrer:= string-join($corpus//tei:l/tei:app/tei:rdg[@wit="#T"])
let $y:= count(tokenize($sharrer, 'y|Y'))
let $i:= count(tokenize($sharrer, 'i'))