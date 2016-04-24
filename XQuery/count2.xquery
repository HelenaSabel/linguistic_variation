xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $authors := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $songs//tei:name[@role eq 'author']/@ref];
count($authors)
