xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare namespace djb = "www.obdurodon.org";
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
declare variable $search := request:get-parameter("phenomenon", ());
let $values := tokenize($search, ',')
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $readings := $songs//tei:rdg
let $ling-features := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'linguistic']]
let $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person
return
    <div
        class="multiple">
        <section
            class="phenom">
            {
                for $result in $values
                return
                    (<h2><span
                            class="pt" id="graf{$result}">{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'pt']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</span>
                            <span
                            class="gl" id="grafo{$result}">{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'gl']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</span><span
                            class="en" id="graphs{$result}">{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'en']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</span></h2>,
                       <h3><span
                            class="pt">Testemunho</span><span
                            class="gl">Testemuño</span><span
                            class="en">Witness</span></h3>,
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="950"
                        height="100">
                        {
                            
                            let $fen := $readings[some $ana in tokenize(@ana, '\s+') satisfies $ana = concat('#', $result)]
                            for $wit at $pos in
                            for $i in distinct-values($fen/tokenize(./@wit, '\s+'))
                            order by count($fen[./tokenize(@wit, '\s+') = $i]) descending
                            return
                                $i
                            let $count := count($fen[contains(@wit, $wit)])
                            let $sum := count($fen)
                            let $percentage := round-half-to-even((100 * $count div $sum), 2)
                            order by $count descending
                            return
                                <g>
                                    <rect
                                        fill="blue"
                                        height="22"
                                        width="{$count * 6.5}"
                                        x="70"
                                        y="{$pos * 22}"
                                        stroke="#EAE5C5"
                                    />
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * 6.5}"
                                        y="{$pos * 22 + 14}"
                                    >{' (' || $percentage || '%)'}</text>
                                    <text
                                        fill="black"
                                        x="10"
                                        y="{$pos * 20 + 18}"
                                    >Ms. {substring($wit, 2)}</text>
                                    
                                    {
                                        let $hand := $songs[.//tei:rdg[. intersect $fen[contains(@wit, $wit)]]]/tei:head//tei:rdg[@wit = $wit]/@hand
                                        let $distinctHands := distinct-values($hand)
                                        for $h in 1 to count($distinctHands)
                                        let $x := count($songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[position() lt $h]]]
                                        //tei:rdg[. intersect $fen][contains(@wit, $wit)])
                                        let $div := $songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[$h]]][.//tei:rdg[. intersect $fen]]
                                        let $conta := count($div//tei:rdg[. intersect $fen[contains(@wit, $wit)]])
                                        order by $h descending
                                        return
                                            <g>
                                                <rect
                                                    fill="#2B3966"
                                                    height="22"
                                                    width="{$conta * 6.5}"
                                                    x="{$x * 6.5 + 70}"
                                                    y="{$pos * 22}"
                                                    stroke="#EAE5C5"
                                                    stroke-width="2"/>
                                                <text
                                                    fill="white"
                                                    font-size="10.5"
                                                    x="{($x * 6.5 + 68) + (($conta * 6.5) div 2)}"
                                                    y="{$pos * 22 + 12}">{substring($distinctHands[$h], 2)}</text>
                                            </g>
                                    }
                                </g>
                        }</svg>,
                        <h3 id="lg{$result}"><span
                            class="pt gl" id="lingua{$result}">Período</span><span
                            class="en">Period</span></h3>,
                    <svg id="ling{$result}"
                        xmlns="http://www.w3.org/2000/svg"
                        width="950"
                        height="100">
                        {
                            
                            let $fen :=  $readings[some $ana in tokenize(@ana, '\s+') satisfies $ana = concat('#', $result)]
                            for $period at $pos in
                            for $i in distinct-values($poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]/tei:floruit/@period)
                            order by count($fen[ancestor::tei:div[1]//tei:name/substring(@ref, 2) = $poets/tei:floruit[@period = $i]/../@xml:id]) descending
                            return
                                $i
                            let $count := count($fen[ancestor::tei:div[1]//tei:name/substring(@ref, 2) = $poets/tei:floruit[@period = $period]/../@xml:id])
                            let $sum := count($fen)
                            let $percentage := round-half-to-even((100 * $count div $sum), 2)
                            order by $count descending
                            return
                                <g>
                                    <rect
                                        fill="#2B3966"
                                        height="22"
                                        width="{$count * 6.5}"
                                        x="70"
                                        y="{$pos * 22}"
                                        stroke="#EAE5C5"
                                        stroke-width="2"/>
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * 6.5}"
                                        y="{$pos * 22 + 14}"
                                    >{' (' || $percentage || '%)'}</text>
                                    <text
                                        fill="black"
                                        x="10"
                                        y="{$pos * 20 + 18}"
                                    >Per. {$period}</text>
                                </g>
                        }</svg>,
                    <table
                        class="sortable">
                        <thead>
                            <tr
                                class="head">
                                <th><span
                                        class="pt gl">Fenómeno</span><span
                                        class="en">Phenomenon</span>
                                </th>
                                <th><span
                                        class="pt">Testemunho</span><span class="gl">Testemuño</span><span
                                        class="en">Witness</span>
                                </th>
                                <th><span
                                        class="pt">Localização</span><span class="gl">Localización</span><span
                                        class="en">Location</span>
                                </th>
                                <th><span
                                        class="pt gl">Copista</span><span
                                        class="en">Copyist</span>
                                </th>
                                <th><span
                                        class="pt gl">Autor</span><span
                                        class="en">Author</span>
                                </th>
                                <th><span
                                        class="pt gl">Período</span><span
                                        class="en">Period</span>
                                </th>
                                <th><span
                                        class="pt gl">Cantiga</span><span
                                        class="en">Song</span>
                                </th>
                                <th><span
                                        class="pt gl">V.</span><span
                                        class="en">L.</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                for $fen in $readings[some $ana in tokenize(@ana, '\s+') satisfies $ana = concat('#', $result)]
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
                                return
                                    <tr>
                                        <td class="intro"><a
                                                href="http://gl-pt.obdurodon.org/edition.php?&amp;song[]={$fen/ancestor::tei:div[1]/substring(@corresp, 2)}&amp;line={$fen/ancestor::tei:l/@n/string()}"
                                                target="_blank">{transform:transform($fen/.., 'xmldb:exist:///db/VTLGP/xslt/ex.xsl', ($rdg))}</a></td>
                                        <td>{
                                                (if ($fen/contains(@wit, ' ')) then
                                                    <ul>{
                                                            for $wit in tokenize($fen/@wit, '\s+')
                                                            order by $wit
                                                            return
                                                                <li>{substring($wit, 2)}</li>
                                                        }</ul>
                                                else
                                                    $fen/substring(@wit, 2)
                                                )
                                            }</td>
                                        <td>{
                                                (if (contains($fen/@wit, ' ')) then
                                                    <ul>{
                                                            
                                                            for $wit in tokenize($fen/@wit, '\s+')
                                                            order by $wit
                                                            return
                                                                <li>{djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/tei:locus/@to)
                                                                    }</li>
                                                        }</ul>
                                                else
                                                    djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@to))
                                            }</td>
                                        <td>{
                                                (if (contains($fen/@wit, ' ')) then
                                                    <ul>{
                                                            
                                                            for $wit in tokenize($fen/@wit, '\s+')
                                                            order by $wit
                                                            return
                                                                <li>{$fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/substring(@hand, 2)}</li>
                                                        }</ul>
                                                else
                                                    $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2))
                                            }</td>
                                        <td>{$author/tei:persName/string()}</td>
                                        <td>{$author/tei:floruit/@from || '-' || $author/tei:floruit/@to || ' (' || $author/tei:floruit/@period || ')'}</td>
                                        <td>{$fen/ancestor::tei:div[1]/string-join(descendant::tei:title//tei:idno, ', ')}</td>
                                        <td>{$fen/ancestor::tei:l/@n/string()}</td>
                                    </tr>
                            }
                        </tbody>
                    </table>)
            }
        </section>
        <aside
            id="summary">
                <h3><span class="pt">Conteúdos</span><span class="en">Contents</span><span class="gl">Contidos</span></h3>
                 <div class="en">
                <ul>
                    {
                        for $result in $values
                        return
                            <li>{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'en']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}
                                <ul>
                                    <li><a
                                            href="#graphs{$result}">Graph</a></li>
                                    <li><a
                                            href="#ling{$result}">Table</a></li>
                                </ul>
                            </li>
                    }
                </ul>
                </div>
                 <div class="pt">
                <ul>
                     {
                        for $result in $values
                        return
                            <li>{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'pt']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}
                                <ul>
                                    <li><a
                                            href="#graf{$result}">Gráficas</a></li>
                                    <li><a
                                            href="#lingua{$result}">Tabela</a></li>
                                </ul>
                            </li>
                    }
                </ul>
                </div>
                
                 <div class="gl">
                <ul>
                     {
                        for $result in $values
                        return
                            <li>{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'gl']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}
                                <ul>
                                    <li><a
                                            href="#grafo{$result}">Gráficas</a></li>
                                    <li><a
                                            href="#lg{$result}">Táboa</a></li>
                                </ul>
                            </li>
                    }
                </ul>
                </div>
        </aside>
    </div>
