xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare function local:locus($from as node(), $to as node())
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
declare variable $search := request:get-parameter("equip", ());
let $values := tokenize($search, ',')
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $readings := $songs//tei:rdg
let $equipolent := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib[@n eq 'equipolent readings']/tei:fs[concat('#', @xml:id)]
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
                            class="pt">{$equipolent[@xml:id = $result]//tei:string[@xml:lang eq 'pt']/text()}</span><span
                            class="en">{$equipolent[@xml:id = $result]//tei:string[@xml:lang eq 'en']/text()}</span></h2>,
                    <h3
                        id="graphs{$result}"><span
                            class="pt">Período</span><span
                            class="en">Period</span></h3>,
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="950"
                        height="100">
                        {
                            
                            let $fen := $readings[matches(@ana, concat('#', $result))]
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
                                        height="20"
                                        width="{$count * 6.5}"
                                        x="70"
                                        y="{$pos * 20}"
                                        stroke="black"
                                        stroke-width="2"/>
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * 6.5}"
                                        y="{$pos * 20 + 14}"
                                    >{' (' || $percentage || '%)'}</text>
                                    <text
                                        fill="black"
                                        x="10"
                                        y="{$pos * 20 + 18}"
                                    >Per. {$period}</text>
                                </g>
                        }</svg>,
                    <h3><span
                            class="pt">Testemunho</span><span
                            class="en">Witness</span></h3>,
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="950"
                        height="100">
                        {
                            
                            let $fen := $readings[matches(@ana, concat('#', $result))]
                            for $wit at $pos in
                            for $i in distinct-values($fen/tokenize(./@wit, '\s'))
                            order by count($fen[./tokenize(@wit, '\s') = $i]) descending
                            return
                                $i
                            let $count := count($fen[@wit = $wit])
                            let $sum := count($fen)
                            let $percentage := round-half-to-even((100 * $count div $sum), 2)
                            order by $count descending
                            return
                                <g>
                                    <rect
                                        fill="blue"
                                        height="20"
                                        width="{$count * 6.5}"
                                        x="70"
                                        y="{$pos * 20}"
                                        stroke="black"
                                    />
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * 6.5}"
                                        y="{$pos * 20 + 14}"
                                    >{' (' || $percentage || '%)'}</text>
                                    <text
                                        fill="black"
                                        x="10"
                                        y="{$pos * 20 + 18}"
                                    >Ms. {substring($wit, 2)}</text>
                                    
                                    {
                                        let $hand := $songs[.//tei:rdg[. intersect $fen[@wit = $wit]]]/tei:head//tei:rdg[@wit = $wit]/@hand
                                        let $distinctHands := distinct-values($hand)
                                        for $h in 1 to count($distinctHands)
                                        let $x := count($songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[position() lt $h]]]
                                        //tei:rdg[. intersect $fen][@wit = $wit])
                                        let $div := $songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[$h]]][.//tei:rdg[. intersect $fen]]
                                        let $conta := count($div//tei:rdg[. intersect $fen[@wit = $wit]])
                                        order by $h descending
                                        return
                                            <g>
                                                <rect
                                                    fill="#2B3966"
                                                    height="20"
                                                    width="{$conta * 6.5}"
                                                    x="{$x * 6.5 + 70}"
                                                    y="{$pos * 20}"
                                                    stroke="black"
                                                    stroke-width="2"/>
                                                <text
                                                    fill="white"
                                                    font-size="10.5"
                                                    x="{($x * 6.5 + 68) + (($conta * 6.5) div 2)}"
                                                    y="{$pos * 20 + 12}">{substring($distinctHands[$h], 2)}</text>
                                            </g>
                                    }
                                </g>
                        }</svg>,
                    <table
                        class="sortable"
                        id="ling{$result}">
                        <thead>
                            <tr
                                class="head">
                                <th><span
                                        class="pt">Fenómeno</span><span
                                        class="en">Phenomenon</span>
                                </th>
                                <th><span
                                        class="pt">Testemunho</span><span
                                        class="en">Witness</span>
                                </th>
                                <th><span
                                        class="pt">Localização</span><span
                                        class="en">Location</span>
                                </th>
                                <th><span
                                        class="pt">Copista</span><span
                                        class="en">Copyist</span>
                                </th>
                                <th><span
                                        class="pt">Autor</span><span
                                        class="en">Author</span>
                                </th>
                                <th><span
                                        class="pt">Período</span><span
                                        class="en">Period</span>
                                </th>
                                <th><span
                                        class="pt">Cantiga</span><span
                                        class="en">Song</span>
                                </th>
                                <th><span
                                        class="pt">V.</span><span
                                        class="en">L.</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                for $fen in $readings[matches(@ana, concat('#', $result))]
                                let $rdg :=
                                <parameters>
                                    <param
                                        name="rdg"
                                        value="{$fen}"/>
                                </parameters>
                                let $author := $poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]
                                return
                                    <tr>
                                        <td><a
                                                href="http://gl-pt.obdurodon.org/edition.php?&amp;song[]={$fen/ancestor::tei:div[1]/substring(@corresp, 2)}"
                                                target="_blank">{transform:transform($fen/.., 'xmldb:exist:///db/VTLGP/xslt/ex.xsl', ($rdg))}</a></td>
                                        <td>{replace($fen/substring(@wit, 2), '#', '<br/>')}</td>
                                        <td>{
                                                (if (contains($fen/@wit, ' ')) then
                                                    local:locus($fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][1]/tei:locus/@from, $fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][1]/tei:locus/@to) || <br/> || local:locus($fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][2]/tei:locus/@from, $fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][2]/tei:locus/@to)
                                                else
                                                    local:locus($fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][1]/tei:locus/@from, $fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][1]/tei:locus/@to))
                                            }</td>
                                        <td>{
                                                (if (contains($fen/@wit, ' ')) then
                                                    $fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][1]/substring(@hand, 2) || <br/> || $fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][2]/substring(@hand, 2)
                                                else
                                                    $fen/ancestor::tei:div[1]//tei:rdg[contains(@wit, tokenize($fen/@wit, ' '))][1]/substring(@hand, 2))
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
            id="move">
            <div
                class="pt">
                <h3>Conteúdos</h3>
                <ul>
                    {
                        for $result in $values
                        return
                            <li>{$equipolent[./@xml:id = $result]//tei:string[@xml:lang eq 'pt']}
                                <ul>
                                    <li><a
                                            href="#graphs{$result}">Gráficas</a></li>
                                    <li><a
                                            href="#ling{$result}">Tabela</a></li>
                                </ul>
                            </li>
                    }
                </ul>
            </div>
            <div
                class="en">
                <h3>Contents</h3>
                <ul>
                    {
                        for $result in $values
                        return
                            <li>{$equipolent[./@xml:id = $result]//tei:string[@xml:lang eq 'en']}
                                <ul>
                                    <li><a
                                            href="#graphs{$result}">Graphs</a></li>
                                    <li><a
                                            href="#ling{$result}">Table</a></li>
                                </ul>
                            </li>
                    }
                </ul>
            </div>
        </aside>
    </div>
