xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(:declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (\:corpus of songs:\)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (\:variants file:\):)
declare variable $songs := collection('../../edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('../../ancillary/feature-library.xml');
declare variable $ling-features := $fs//tei:fs[tei:f/tei:fs[@type eq 'linguistic']]/@xml:id;
declare variable $legendWidth := number('22');
declare variable $legendHeight := number('22');
declare variable $increased := number('12');
declare variable $sep := number('9');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="1500"
    height="580">
    <g
        transform="translate(20,500)">
        <line
            fill="none"
            stroke="black"
            stroke-width="1"
            x1="0"
            y1="0"
            x2="{151 * $sep}"
            y2="0"/>
        <line
            x1="{151 * $sep}"
            x2="{151 * $sep}"
            y1="0"
            y2="-{23 * $increased}"
            stroke="black"
            stroke-width="1"/>
        <text
            x="1430"
            y="-140"
            text-anchor="middle"
            fill="black"
            style="writing-mode:tb"
            transform="rotate(180 1430 -140)">Número ocorrências</text>
        <text
            fill="black"
            x="{151 * $sep div 2}"
            y="50"
            text-anchor="middle"
            transform="{concat('rotate(180 ', 151 * $sep div 2, ' 50)')}">Cantiga</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="600"
            y="-{$increased * 29}"
            fill="orange"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="black"
            font-size="11"
            x="612"
            style="writing-mode:tb"
            transform="rotate(180 612 -372)"
            y="-{$increased * 32}">Variantes de língua</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="750"
            y="-{$increased * 29}"
            fill="#2b3966"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="black"
            font-size="11"
            x="762"
            style="writing-mode:tb"
            transform="rotate(180 762 -372)"
            y="-{$increased * 32}">Formas únicas</text>
        
        {
            for $section at $pos in
            for $i in $songs
            order by number($i//tei:title//tei:rdg[@wit eq '#A']/substring(tei:idno, 2)) descending
            return
                $i
            let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
            let $song := $section//tei:title//tei:rdg[@wit eq '#A']/tei:idno/string()
            let $y := count($ling) * $increased
            let $dist-ling := count(distinct-values($ling/string())) * $increased
            let $x := $sep * $pos
            return
                
                (<circle
                    stroke="black"
                    stroke-width=".5"
                    r="4"
                    cx="{$x}"
                    cy="-{$y}"
                    fill="orange"/>
                ,
                <line
                    fill="none"
                    stroke="black"
                    stroke-width="1"
                    y1="3"
                    y2="-3"
                    x1="{$x}"
                    x2="{$x}"
                />,
                
                <text
                    fill="black"
                    style="writing-mode:tb"
                    x="{$x}"
                    y="10"
                    text-anchor="end"
                    transform="{concat('rotate(180 ', $x, ' 10)')}"
                    font-size="9">{$song}</text>,
                
                <circle
                    stroke="black"
                    stroke-width=".5"
                    r="4"
                    cx="{$x}"
                    cy="-{$dist-ling}"
                    fill="#2B3966"/>
                
                )
        
        }
    </g>
    <g
        transform="translate(20,500)">
        {
            for $i in 1 to 22
            return
                <line
                    x1="{150.5 * $sep}"
                    x2="{151.5 * $sep}"
                    y1="-{$i * $increased}"
                    y2="-{$i * $increased}"
                    fill="none"
                    stroke="black"
                    stroke-width="1"/>
        }
    
    </g>
    <g
        transform="translate(20,500)">
        {
            for $x in 1 to 4
            return
                <text
                    font-size="12"
                    x="1380"
                    y="-{$x * 5 * $increased - $increased - 7}"
                    text-anchor="middle"
                    fill="black"
                    style="writing-mode:tb"
                    transform="rotate(180 1380 -140)">{($x + 4 - $x * 2 + 1) * 5}</text>
        }</g>
    
    <g
        transform="translate(20,500)">
        <text
            font-size="12"
            x="1380"
            y="-{23 * $increased - 7}"
            text-anchor="middle"
            fill="black"
            style="writing-mode:tb"
            transform="rotate(180 1380 -140)">1</text></g>

</svg>
