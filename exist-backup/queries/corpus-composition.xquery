xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person;
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $periods := $poets[@xml:id = $songs//tei:name/substring(@ref, 2)]/tei:floruit/@period;
declare variable $witnesses := $songs//tei:title//tei:rdg/@wit;
declare variable $copyists := $songs//tei:title//tei:rdg/@hand;
declare variable $count := count($songs);
<div
    class="stats">
    <h3><span
            class="pt gl">Cantigas segundo o período</span><span
            class="en">Songs by period</span></h3>
    
    <svg
        xmlns="http://www.w3.org/2000/svg"
        width="950"
        height="{(count(distinct-values($periods)) + 2) * 20}">
        {
            
            for $period at $pos in distinct-values($periods)
            let $sum := count($songs[.//tei:name/substring(@ref, 2) = $poets[./tei:floruit/@period eq $period]/@xml:id])
            let $percentage := round-half-to-even((100 * $sum div $count), 2)
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
                        class="pt gl"
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
            class="pt gl">Cantigas por <span class="pt">testemunho</span><span class="gl">testemuño</span></span><span
            class="en">Songs by witness</span></h3>
    <svg
        xmlns="http://www.w3.org/2000/svg"
        width="100%"
        height="{(count(distinct-values($witnesses)) + 2) * 20}">
        {
            
            for $wit at $pos in distinct-values($witnesses)
            let $sum := count($songs[.//tei:title//tei:rdg/@wit = $wit])
            let $percentage := round-half-to-even((100 * $sum div $count), 2)
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
                        let $distinctHands := for $distinct-hand in distinct-values($hand) order by $distinct-hand return $distinct-hand
                        for $h in 1 to count($distinctHands) 
                        let $x := count($songs[.//tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[position() lt $h]]])
                        let $div := $songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[$h]]]
                        let $conta := count($div)
                        order by $h
                        
                        
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
                    
                    
                    }
                    </g>
        }</svg>
    <h3><span
            class="pt gl">Cantigas segundo o copista</span><span
            class="en">Songs by scribe</span></h3>
    <svg
        xmlns="http://www.w3.org/2000/svg"
        width="100%"
        height="{(count(distinct-values($copyists)) + 2) * 20}">
        {
            let $variables :=
            <variables>{
                    
                    for $hand in distinct-values($copyists)
                    let $sum := count($songs[.//tei:title//tei:rdg/@hand = $hand])
                    let $percentage := round-half-to-even((100 * $sum div $count), 2)
                    order by $sum descending
                    return
                        <item>
                            <sum>{$sum}</sum>
                            <percentage>{$percentage}</percentage>
                            <hand>{$hand}</hand>
                        </item>
                }</variables>
            for $thing at $pos in $variables/item
            return
                <g>
                    <rect
                        fill="#2B3966"
                        height="20"
                        width="{$thing/sum * 6.5}"
                        x="100"
                        y="{$pos * 20}"
                        stroke="#EAE5C5"
                        stroke-width="2"/>
                    <text
                        fill="black"
                        font-size="12"
                        x="{110 + $thing/sum * 6.5}"
                        y="{$pos * 20 + 14}"
                    >{' (' || $thing/percentage || '%)'}</text>
                    <text
                        class="pt gl"
                        fill="black"
                        x="10"
                        y="{$pos * 20 + 18}"
                    >Copista {substring($thing/hand, 2)}</text>
                    <text
                        class="en"
                        fill="black"
                        x="10"
                        y="{$pos * 20 + 18}"
                    >Copyist {substring($thing/hand, 2)}</text>
                </g>
        }</svg>
</div>