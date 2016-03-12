xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
let $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $periods := $poets[@xml:id = $songs//tei:name/substring(@ref, 2)]/tei:floruit/@period
let $witnesses := $songs//tei:title//tei:rdg/@wit
let $copyists := $songs//tei:title//tei:rdg/@hand

return
    <div
        class="stats">
        <h3><span
                class="pt">Cantigas segundo o período</span><span
                class="en">Songs by period</span></h3>
        
        <svg
            xmlns="http://www.w3.org/2000/svg"
            width="950"
            height="100">
            {
                
                for $period at $pos in distinct-values($periods)
                let $count := count($songs)
                let $sum := count($songs[.//tei:name/substring(@ref, 2) = $poets[./tei:floruit/@period eq $period]/@xml:id])
                let $percentage := round-half-to-even((100 * $sum div $count), 2)
                order by count($sum) descending
                return
                    <g>
                        <rect
                            fill="#2B3966"
                            height="20"
                            width="{$sum * 6.5}"
                            x="100"
                            y="{$pos * 20}"
                            stroke="#EAE5C5"
                            stroke-width="2"/>
                        <text
                            fill="black"
                            font-size="12"
                            x="{110 + $sum * 6.5}"
                            y="{$pos * 20 + 14}"
                        >{' (' || $percentage || '%)'}</text>
                        <text
                            class="pt"
                            fill="black"
                            x="10"
                            y="{$pos * 20 + 18}"
                        >Período {$period}</text>
                        <text
                            class="en"
                            fill="black"
                            x="10"
                            y="{$pos * 20 + 18}"
                        >Period {$period}</text>
                    </g>
            }</svg>
        <h3><span
                class="pt">Cantigas por testemunho</span><span
                class="en">Songs by witness</span></h3>
        <svg
            xmlns="http://www.w3.org/2000/svg"
            width="950"
            height="100">
            {
                
                for $wit at $pos in distinct-values($witnesses)
                let $count := count($songs)
                let $sum := count($songs[.//tei:title//tei:rdg/@wit = $wit])
                let $percentage := round-half-to-even((100 * $sum div $count), 2)
                order by $count descending
                return
                    <g>
                        <rect
                            fill="blue"
                            height="20"
                            width="{$sum * 6.5}"
                            x="70"
                            y="{$pos * 20}"
                            stroke="#EAE5C5"
                        />
                        <text
                            fill="black"
                            font-size="12"
                            x="{80 + $sum * 6.5}"
                            y="{$pos * 20 + 14}"
                        >{' (' || $percentage || '%)'}</text>
                        <text
                            fill="black"
                            x="10"
                            y="{$pos * 20 + 18}"
                        >Ms. {substring($wit, 2)}</text>
                        
                        {
                            let $hand := $songs/tei:head//tei:rdg[@wit = $wit]/@hand
                            let $distinctHands := distinct-values($hand)
                            for $h in 1 to count($distinctHands)
                            let $x := count($songs[.//tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[position() lt $h]]])
                            let $div := $songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[$h]]]
                            let $conta := count($div)
                            order by $h descending
                            return
                                
                                (<rect
                                    fill="#2B3966"
                                    height="20"
                                    width="{$conta * 6.5}"
                                    x="{$x * 6.5 + 70}"
                                    y="{$pos * 20}"
                                    stroke="#EAE5C5"
                                    stroke-width="2"/>,
                                <text
                                    fill="white"
                                    font-size="10.5"
                                    x="{($x * 6.5 + 68) + (($conta * 6.5) div 2)}"
                                    y="{$pos * 20 + 12}">{substring($distinctHands[$h], 2)}</text>)
                        
                        
                        }</g>
            }</svg>
        <h3><span
                class="pt">Cantigas segundo o copista</span><span
                class="en">Songs by scribe</span></h3>
        <svg
            xmlns="http://www.w3.org/2000/svg"
            width="950"
            height="100">
            {
                
                for $hand at $pos in distinct-values($copyists)
                let $count := count($songs)
                let $sum := count($songs[.//tei:title//tei:rdg/@hand = $hand])
                let $percentage := round-half-to-even((100 * $sum div $count), 2)
                order by count($sum) descending
                return
                    <g>
                        <rect
                            fill="#2B3966"
                            height="20"
                            width="{$sum * 6.5}"
                            x="100"
                            y="{$pos * 20}"
                            stroke="#EAE5C5"
                            stroke-width="2"/>
                        <text
                            fill="black"
                            font-size="12"
                            x="{110 + $sum * 6.5}"
                            y="{$pos * 20 + 14}"
                        >{' (' || $percentage || '%)'}</text>
                        <text
                            class="pt"
                            fill="black"
                            x="10"
                            y="{$pos * 20 + 18}"
                        >Copista {substring($hand, 2)}</text>
                        <text
                            class="en"
                            fill="black"
                            x="10"
                            y="{$pos * 20 + 18}"
                        >Copyist {substring($hand, 2)}</text>
                    </g>
            }</svg>
    
    </div>