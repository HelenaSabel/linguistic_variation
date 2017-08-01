xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $increase := number('11');
declare variable $search := request:get-parameter("phenomenon", ("oer"));
let $values := tokenize($search, ',')
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $readings := $songs//tei:rdg
let $ling-features := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fs[@xml:id]
let $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person
return
        <section>
            {
                for $result in $values
                return
                    (<h2>{transform:transform($ling-features[@xml:id = $result]//tei:string[@xml:lang eq 'pt']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</h2>,
                       <h3>Testemunho</h3>,
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
                                        width="{$count * $increase}"
                                        x="70"
                                        y="{$pos * 22}"
                                        stroke="white"
                                    />
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * $increase}"
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
                                                    width="{$conta * $increase}"
                                                    x="{$x * $increase + 70}"
                                                    y="{$pos * 22}"
                                                    stroke="white"
                                                    stroke-width="2"/>
                                                <text
                                                    fill="white"
                                                    font-size="10.5"
                                                    x="{($x * $increase + 66.5) + (($conta * $increase) div 2)}"
                                                    y="{$pos * 22 + 12}">{substring($distinctHands[$h], 2)}</text>
                                            </g>
                                    }
                                </g>
                        }</svg>,
                        <h3>Período</h3>,
                    <svg
                    xmlns="http://www.w3.org/2000/svg"
                        width="1000"
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
                                        width="{$count * $increase}"
                                        x="70"
                                        y="{$pos * 22}"
                                        stroke="white"
                                        stroke-width="2"/>
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * $increase}"
                                        y="{$pos * 22 + 14}"
                                    >{' (' || $percentage || '%)'}</text>
                                    <text
                                        fill="black"
                                        x="10"
                                        y="{$pos * 20 + 18}"
                                    >P°. {$period}</text>
                                </g>
                        }</svg>,
                                       <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="1000"
                        height="200">
                        {
                            
                            let $fen :=  $readings[some $ana in tokenize(@ana, '\s+') satisfies $ana = concat('#', $result)]
                            for $nationality at $pos in
                            for $i in distinct-values($poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]/tei:nationality/@key)
                            order by count($fen[ancestor::tei:div[1]//tei:name/substring(@ref, 2) = $poets/tei:nationality[@key = $i]/../@xml:id]) descending
                            return
                                $i
                            let $count := count($fen[ancestor::tei:div[1]//tei:name/substring(@ref, 2) = $poets/tei:nationality[@key = $nationality]/../@xml:id])
                            let $sum := count($fen)
                            let $percentage := round-half-to-even((100 * $count div $sum), 2)
                            order by $count descending
                            return
                                <g>
                                    <rect
                                        fill="#2B3966"
                                        height="22"
                                        width="{$count * $increase}"
                                        x="70"
                                        y="{$pos * 22}"
                                        stroke="white"
                                        stroke-width="2"/>
                                    <text
                                        fill="black"
                                        font-size="12"
                                        x="{80 + $count * $increase}"
                                        y="{$pos * 22 + 14}"
                                    >{' (' || $percentage || '%)'}</text>
                                    <text
                                        text-anchor="end"
                                        fill="black"
                                        x="60"
                                        y="{$pos * 21 + 20}"
                                    >{upper-case($nationality)}</text>
                                </g>
                        }</svg>
                        )
            }
        </section>
       
