declare namespace tei="http://www.tei-c.org/ns/1.0";
let $corpus:= doc('../dinis.xml')
let $sharrer:= $corpus//tei:l/tei:app/tei:rdg[@wit="#T"]
let $y:= //tei:rdg[@wit="#T"]/count(tokenize(., 'y|Y'))
return count($y)