xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(: Local function written by David J. Birnbaum (djbpitt@gmail.com) :)
declare namespace djb = "www.obdurodon.org";
declare option exist:serialize "method=xhtml media-type=application/xhtml+html indent=no";
declare function djb:locus($from as node()?, $to as node()?)
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
declare variable $selection := request:get-parameter("song", 'A82B186b');
declare variable $cantigas := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $song := $cantigas[substring(@corresp, 2) = $selection];
declare variable $author := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[string(@xml:id) = $song//tei:name[@role eq 'author']/substring(@ref, 2)];

(<div
    class="metadata">
    <h2><span
            class="pt gl">Cantiga</span><span
            class="en">Song</span>
        {':&#32;' || string-join($song//tei:title//tei:idno, ', ')}</h2>
    <h2><span
            class="pt gl">Autor</span><span
            class="en">Author</span>
        {':&#32;' || $author/tei:persName/string()}</h2>
    <h2><span
            class="pt gl">Período</span><span
            class="en">Period</span>
        {':&#32;' || $author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()}
        (<span
            class="pt gl">período</span><span
            class="en">period</span>
        {'&#32;' || $author/tei:floruit/@period/string()})</h2>
</div>,
<div
    class="tabular">
    {
        for $line in $song//tei:l
        return
            (<p>{$line/@n/string()}.</p>,
            <table>{
                    for $witness in $song/tei:head/descendant::tei:rdg
                    let $parameter :=
                    <parameters>
                        <param
                            name="wit"
                            value="{$witness/@wit}"/>
                    </parameters>
                    return
                        <tr>{transform:transform($line[ancestor::tei:div/tei:head/descendant::tei:rdg/@wit = $witness/@wit], doc('/db/VTLGP/xslt/table.xsl'), $parameter)}</tr>
                
                }</table>)
    
    }</div>)

