xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $increase := number('4');
declare variable $height := number('20');
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fs[@type];
declare variable $arcaic := for $i in $fs[@type eq 'arcaico']/@xml:id return concat('#', $i);
declare variable $innova-pt := $fs[@type eq 'inova-pt']/@xml:id;
declare variable $innova-gl :=  $fs[@type eq 'inova-gl']/@xml:id; 
declare variable $innova : = $fs[@type eq 'inova']/@xml:id;
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $readings := $songs//tei:rdg;
declare variable $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person;
let $width1 := $readings[tokenize(@ana, '\s') = concat('#', $arcaic)]
return
    count($width1)
