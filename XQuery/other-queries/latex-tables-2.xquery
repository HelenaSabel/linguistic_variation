xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare namespace djb = "www.obdurodon.org";
declare option exist:serialize "method=text media-type=text/plain omit-xml-declaration=yes";
declare function djb:locus($from as node(), $to as node())
{
    (if ($from eq $to)
    then
        $from/string()
    else
        if (substring($from, 1, string-length($from) - 1) eq substring($to, 1, string-length($to) - 1))
        then
            concat($from, '-v')
        else
            concat($from, '-', $to))
};
declare variable $result := request:get-parameter("phenomenon", ("p1i"));
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $readings := $songs//tei:rdg
let $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person
for $fen in $readings[some $ana in tokenize(@ana, '\s+')
    satisfies $ana = concat('#', $result)]
let $rdg :=
<parameters>
    <param
        name="rdg"
        value="{$fen}"/>
    <param
        name="ana"
        value="{$result}"/>
</parameters>
let $author := $poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]
let $orderedWit := for $wit in tokenize($fen/@wit, '\s+')
order by $wit
return
    $wit
let $wit1 := $orderedWit[1]
let $wit2 := $orderedWit[2]
order by $wit1,
    number($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit1]/tei:locus/replace(@from, '[rv]+', ''))
return

    (
    '\uni&#123;' || string-join(transform:transform($fen/.., 'xmldb:exist:///db/VTLGP/xslt/ex.xsl', ($rdg)), '//') || '&#125; &amp; ' ||
    
    (if ($fen/contains(@wit, ' ')) then
        substring($wit1, 2)
    
    else
        $fen/substring(@wit, 2))
    || ' &amp; ' ||
    
    (if (contains($fen/@wit, ' ')) then
        djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit1]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit1]/tei:locus/@to)
    else
        djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@to)) || ' &amp; ' ||
    
    (if (contains($fen/@wit, ' ')) then
        
        $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit1]/substring(@hand, 2)
    else
        $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)) || ' &amp;' ||
    $author/tei:persName/string() || ' &amp; ' ||
(:      $author/tei:floruit/@period || ' &amp; ' || :)
 
    $fen/ancestor::tei:div[1]/string-join(descendant::tei:title//tei:idno, ', ') || ' &amp; ' ||
    $fen/ancestor::tei:l/@n/string() ||
    (if (contains($fen/@wit, ' ')) then
        ' \\ \cline&#123;2-4&#125; &#10; &amp;' || substring($wit2, 2) || ' &amp; ' ||
        djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit2]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit2]/tei:locus/@to) || ' &amp; ' || $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit2]/substring(@hand, 2) ||
        ' &amp; &amp; &amp; \\ \hline &#10;'
    else
        ' \\ \hline &#10;'
    )
    )