xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=text media-type=text/plain omit-xml-declaration=yes";
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $me-apps := $songs//tei:rdg[not(contains(@ana, 'dat'))][matches(., '[^\w][mM]e[^\w]') or (tei:supplied[preceding-sibling::node()[1][matches(., '[^\w][mM]$')]]) or (matches(., '[^\w][mM]e$')) or (matches(., '^[mM]e$')) or (matches(., '^[mM]e[^\w]'))]/parent::tei:app[not(tei:rdg[contains(@ana, 'dat')])]
for $me in $me-apps
order by number($me/ancestor::tei:div[1]/replace(substring-before(@corresp, 'B'), '#A', ''))
return
    '\uni&#123;' || transform:transform($me, 'xmldb:exist:///db/VTLGP/xslt/me.xsl', ()) || '&#125; &amp; ' ||
    
    (if ($me[count(tei:rdg[not(contains(@ana, 'dat'))][matches(., '[^\w][mM]e[^\w]') or (tei:supplied[preceding-sibling::node()[1]
            [matches(., '[^\w][mM]$')]]) or (matches(., '[^\w][mM]e$')) or (matches(., '^[mM]e$')) or (matches(., '^[mM]e[^\w]'))]) gt 1])
    then
    let $witnesses:=  for $rdg in $me/tei:rdg[not(contains(@ana, 'dat'))][matches(., '[^\w][mM]e[^\w]') or (tei:supplied[preceding-sibling::node()[1]
            [matches(., '[^\w][mM]$')]]) or (matches(., '[^\w][mM]e$')) or (matches(., '^[mM]e$')) or (matches(., '^[mM]e[^\w]'))] return  $rdg/replace(replace(@wit, '#', ''), ' ', ', ')
    return 
        string-join($witnesses, ' / ')
           
    else
            $me/tei:rdg[not(contains(@ana, 'dat'))][matches(., '[^\w][mM]e[^\w]') or (tei:supplied[preceding-sibling::node()[1]
            [matches(., '[^\w][mM]$')]]) or (matches(., '[^\w][mM]e$')) or (matches(., '^[mM]e$')) or (matches(., '^[mM]e[^\w]'))]/replace(replace(@wit, '#', ''), ' ', ', ')
    )
    || ' &amp; ' || $me/ancestor::tei:div[1]/string-join(descendant::tei:title//tei:idno, ', ') || ' &amp; ' ||
    $me/ancestor::tei:l/@n/string() ||  ' \\ \hline &#10;'