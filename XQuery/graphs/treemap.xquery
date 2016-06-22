declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('../../edition/corrigidas')//tei:div[@type eq 'poem'];
declare variable $fs := doc('../../ancillary-files/feature-library.xml');
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;


