xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
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
declare function functx:is-node-in-sequence-deep-equal
($node as node()?,
$seq as node()*) as xs:boolean {
    
    some $nodeInSeq in $seq
        satisfies deep-equal($nodeInSeq, $node)
};
declare function functx:distinct-deep
($nodes as node()*) as node()* {
    
    for $seq in (1 to count($nodes))
    return
        $nodes[$seq][not(functx:is-node-in-sequence-deep-equal(
        ., $nodes[position() < $seq]))]
};
declare variable $cantigas := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[@xml:id/string() = $cantigas//tei:name[@role eq 'author']/substring(@ref, 2)];
declare variable $partialselection := request:get-parameter("song", ());
declare variable $otherSelection := request:get-parameter("period", ());
declare variable $partialSelection := request:get-parameter("author", ());
declare variable $nextSelection := request:get-parameter("scribe", ());
let $poetselection := tokenize($partialSelection, ',+')
let $songselection := tokenize($partialselection, ',+')
let $periodselection := tokenize($otherSelection, ',+')
let $scribeselection := tokenize($nextSelection, ',+')
let $selectionPoet := for $i in $poetselection
return
    $i
let $selectionSong := for $y in $songselection
return
    $y
let $selectionPeriod := for $h in $periodselection
return
    $h
let $selectionScribe := for $g in $scribeselection
return
    $g
let $songs := $cantigas[substring(@corresp, 2) = $selectionSong] |
$cantigas[descendant::tei:name[substring(@ref, 2) = $selectionPoet]] |
$cantigas[descendant::tei:name[substring(@ref, 2) = doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[./tei:floruit/@period = $selectionPeriod]/@xml:id]] |
$cantigas[tei:head/descendant::tei:rdg[substring(@hand, 2) = $selectionScribe]]
return
    <div
        class="multiple">
        <section>
            {
                for $song in functx:distinct-deep($songs)
                let $author := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[string(@xml:id) = $song//tei:name[@role eq 'author']/substring(@ref, 2)]
                return
                    <div
                        id="{$song/substring(@corresp, 2)}"
                        class="poem">
                        <div
                            class="metadata">
                            <h2><span
                                    class="pt">Cantiga</span><span
                                    class="en">Song</span>
                                {':&#32;' || string-join($song//tei:title//tei:idno, ', ')}</h2>
                            <h2><span
                                    class="pt">Autor</span><span
                                    class="en">Author</span>
                                {':&#32;' || $author/tei:persName/string()}</h2>
                            <h2><span
                                    class="pt">Período</span><span
                                    class="en">Period</span>
                                {':&#32;' || $author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()}
                                (<span
                                    class="pt">período</span><span
                                    class="en">period</span>
                                {'&#32;' || $author/tei:floruit/@period/string()})</h2>
                        </div>
                        <div
                            class="body">
                            {
                                
                                for $witness in $song/tei:head/descendant::tei:rdg
                                let $parameter :=
                                <parameters>
                                    <param
                                        name="wit"
                                        value="{$witness/@wit}"/>
                                </parameters>
                                return
                                    <div
                                        class="witness">
                                        <h3><span
                                                class="pt">Testemunho</span><span
                                                class="en">Witness</span>: {$witness/substring(@wit, 2)}</h3>
                                        <h4>Text<span
                                                class="pt">o</span>: {$witness/tei:idno/string()}</h4>
                                        <h4><span
                                                class="pt">Localização</span><span
                                                class="en">Location</span>: {djb:locus($witness/tei:locus/@from, $witness/tei:locus/@to)}</h4>
                                        <h4><span
                                                class="pt">Copista</span><span
                                                class="en">Copyist</span>: {$witness/substring(@hand, 2)}</h4>
                                        
                                        {transform:transform($song//tei:lg, doc('/db/VTLGP/xslt/reading.xsl'), $parameter)}
                                    
                                    </div>
                            
                            }
                        </div>
                    </div>
            }
        </section>
        <aside
            id="move">
            {
                (if (count($songs) gt 1) then
                    (<h3
                        class="pt">Cantigas</h3>,
                    <h3
                        class="en">Songs</h3>,
                    <ul>{
                            for $song in $songs
                            return
                                <li><a
                                        href="{$song/@corresp}">{string-join($song//tei:title//tei:idno, ', ')}</a></li>
                        }
                    
                    </ul>)
                else
                    ())
            }
            <p
                class="dinamic"><span
                    class="pt">Mudar critérios</span><span
                    class="en">Change criteria</span></p>
        </aside>
    </div>