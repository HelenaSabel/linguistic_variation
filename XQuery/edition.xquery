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
declare variable $partialSelection := request:get-parameter("author", ());
declare variable $nextSelection := request:get-parameter("scribe", ());
declare variable $line := request:get-parameter("line", ());
let $selectionPoet := for $i in tokenize($partialSelection, ',+')
return
    concat('#', $i)
let $selectionSong := for $y in tokenize($partialselection, ',+')
return
    concat('#', $y)
let $selectionScribe := for $g in tokenize($nextSelection, ',+')
return
    concat('#', $g)
let $songs := $cantigas[@corresp = $selectionSong] |
$cantigas[descendant::tei:name[@ref = $selectionPoet]] |
$cantigas[tei:head/descendant::tei:rdg[@hand = $selectionScribe]]
return
    <div
        class="multiple">
        <section>
            {
                for $song in functx:distinct-deep($songs)
                let $author := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $song//tei:name[@role eq 'author']/@ref]
                order by $song/number(substring-before(substring(@corresp, 3), 'B'))
                return
                    <div
                        id="{$song/substring(@corresp, 2)}"
                        class="poem">
                        <div
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
                        </div>
                        <p
                            style="text-align:center"><a
                                class="pt"
                                href="http://gl-pt.obdurodon.org/editionTab.php?song={$song/substring(@corresp, 2)}"
                                target="_blank">Ver edição tabular</a><a
                                class="gl"
                                href="http://gl-pt.obdurodon.org/editionTab.php?song={$song/substring(@corresp, 2)}"
                                target="_blank">Ver edición tabular</a>
                            <a
                                class="en"
                                href="http://gl-pt.obdurodon.org/editionTab.php?song={$song/substring(@corresp, 2)}">Ver edición tabular</a></p>
                        <div
                            class="body">
                            {
                                
                                for $witness in $song/tei:head/descendant::tei:rdg
                                let $parameter :=
                                <parameters>
                                    <param
                                        name="wit"
                                        value="{$witness/@wit}"/>
                                    <param
                                        name="line"
                                        value="{$line}"/>
                                </parameters>
                                return
                                    <div
                                        class="witness">
                                        <h3><span
                                                class="pt gl">Testemu<span
                                                    class="pt">nh</span><span
                                                    class="gl">ñ</span>o</span><span
                                                class="en">Witness</span>: {$witness/substring(@wit, 2)}</h3>
                                        <h4>Text<span
                                                class="pt gl">o</span>: {$witness/tei:idno/string()}</h4>
                                        <h4><span
                                                class="pt gl">Localiza<span
                                                    class="pt">ção</span><span
                                                    class="gl">ción</span></span><span
                                                class="en">Location</span>: {djb:locus($witness/tei:locus/@from, $witness/tei:locus/@to)}</h4>
                                        <h4><span
                                                class="pt gl">Copista</span><span
                                                class="en">Copyist</span>: {$witness/substring(@hand, 2)}</h4>
                                        
                                        {transform:transform($song//tei:lg, doc('/db/VTLGP/xslt/reading.xsl'), $parameter)}
                                    
                                    </div>
                            
                            }
                        </div>
                    </div>
            }
        </section>
        <aside
            id="summary">
            {
                (if (count($songs) gt 1) then
                    (<h3
                        class="pt">Cantigas</h3>,
                    <h3
                        class="en">Songs</h3>,
                    <ul>{
                            for $song in $songs
                            order by $song/number(substring-before(substring(@corresp, 3), 'B'))
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
                    class="gl">Cambiar criterios</span><span
                    class="en">Change criteria</span></p>
        </aside>
    </div>