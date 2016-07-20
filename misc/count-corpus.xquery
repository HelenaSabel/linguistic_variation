declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $collection := collection('../edition')//tei:div[@type eq 'poem'];
declare variable $songs := //song[@class eq 'A'];
declare variable $b := //song[@class eq 'B'];
count($collection) * 100 div count($songs[./*[1]/@id = $b/*[1]/@id])