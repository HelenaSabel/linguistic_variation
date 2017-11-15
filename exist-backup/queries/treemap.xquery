xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace math = "http://www.w3.org/2005/xpath-functions/math";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml');
declare variable $fs-ling := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs;
declare variable $fs-phonetic := $fs-ling[tei:f/tei:fs[1][some $feats in tokenize(./@feats, '\s+') satisfies $feats = $fs//tei:fLib[@n eq "phonetic"]/tei:f/concat('#', @xml:id)]]/@xml:id;
declare variable $fs-morphological := $fs-ling[tei:f/tei:fs[1][some $feats in tokenize(./@feats, '\s+') satisfies $feats = $fs//tei:fLib[@n eq "morphological"]/tei:f/concat('#', @xml:id)]]/@xml:id;
declare variable $fs-other := $fs-ling[tei:f/tei:fs[1][some $feats in tokenize(./@feats, '\s+') satisfies $feats = $fs//tei:fLib[@n eq "other"]/tei:f/concat('#', @xml:id)]]/@xml:id;
declare variable $ling := count($songs//tei:rdg[some $anas in tokenize(@ana, '\s+') satisfies $anas = $fs-ling/@xml:id/concat('#', .)]);
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="820"
    height="720">
    <g>
        <rect width="{math:sqrt($ling)}" height="{math:sqrt($ling)}" fill="black" stroke="red" />
    </g>
</svg>