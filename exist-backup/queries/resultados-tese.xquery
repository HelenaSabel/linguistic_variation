xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (:corpus of songs:)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (:variants file:)
declare variable $ling-features := $fs//tei:fs[tei:f/tei:fs[@type eq 'linguistic']]/@xml:id;
(: Since there is a gap in my edition regarding the location of the songs, I manually create the intervals :)
declare variable $legendWidth := number('22');
declare variable $legendHeight := number('22');
declare variable $increased := number('12');
declare variable $sep := number('9');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="1800"
    height="1200">
    <g
        transform="translate(10,550)">
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
            y2="-{25 * $increased}"
            stroke="black"
            stroke-width="1"/>
        <text
            x="1450"
            y="-140"            
            text-anchor="middle"
            fill="black"
            style="writing-mode:tb"
            transform="rotate(180 1450 -140)">Número ocorrências</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="600"
            y="-{$increased * 29}"
            fill="#11894A"
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
            y="-{$increased * 32}">Fenómenos únicos</text>

        {   
            for $section at $pos in 
            for $i in $songs order by number($i//tei:title//tei:rdg[@wit eq '#A']/substring(tei:idno, 2)) descending return $i
            let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
            let $song := $section//tei:title//tei:rdg[@wit eq '#A']/tei:idno/string()
            let $y := count($ling) * $increased
            let $dist-ling := count(distinct-values($ling)) * $increased
            let $x := $sep * $pos
            return
               
                (<circle
                    r="4"
                    cx="{$x}"
                    cy="-{$y}"
                    fill="#11894A"/>
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
                  
                  <text fill="black" style="writing-mode:tb" x="{$x}" y="20" transform="{concat('rotate(180 ', $x ,' 20)')}" font-size="9">{$song}</text>,

                    <circle
                    r="4"
                    cx="{$x}"
                    cy="-{$dist-ling}"
                    fill="#2B3966"/>
            
                    )
        
        }

    </g>            
</svg>