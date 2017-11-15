xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=text media-type=text/plain omit-xml-declaration=yes";
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $type := 'strong'
let $tp := 
<parameters>
<param name="tp" value="{$type}"/>
</parameters>
let $hits := $songs//tei:app[tei:rdg[@select eq $type]]
for $wk in $hits
order by number($wk/ancestor::tei:div[1]/replace(substring-before(@corresp, 'B'), '#A', ''))
return
    '\uni&#123;' || transform:transform($wk, 'xmldb:exist:///db/VTLGP/xslt/select.xsl', ($tp)) || '&#125; &amp; ' ||
    
    (if ($wk[count(tei:rdg[@select eq $type]) gt 1])
    then
    let $witnesses:=  for $rdg in $wk/tei:rdg[@select = $type] return  $rdg/replace(replace(@wit, '#', ''), ' ', ', ')
    return 
        string-join($witnesses, ' / ')
           
    else
            $wk/tei:rdg[@select eq $type]/replace(replace(@wit, '#', ''), ' ', ', ')
    )
    || ' &amp; ' || $wk/ancestor::tei:div[1]/string-join(descendant::tei:title//tei:idno, ', ') || ' &amp; ' ||
    $wk/ancestor::tei:l/@n/string() ||  ' \\ \hline &#10;'

