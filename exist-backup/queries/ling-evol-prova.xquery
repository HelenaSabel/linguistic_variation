xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (:corpus of songs:)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (:variants file:)
declare variable $ling-features := $fs//tei:fs[tei:f/tei:fs[@type eq 'linguistic']]/@xml:id;
(: Since there is a gap in my edition regarding the location of the songs, I manually create the intervals :)
declare variable $sections :=
<sections>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) = 1][descendant::tei:locus/number(replace(@to, 'v|r', '')) = 1]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 1][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 5]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 5][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 10]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 10][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 15]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 15][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 20]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 20][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 25]}</item>
    (: Gap in my edition :)
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) >= 51][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 55]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 55][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 60]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 60][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 65]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 65][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 70]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 70][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 75]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 75][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 80]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 80][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 85]}</item>
</sections>;
declare variable $legendWidth := number('22');
declare variable $legendHeight := number('22');
declare variable $increased := number('2');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="610"
    height="620">
    <g
        transform="translate(80,400)">
        <polyline
            fill="none"
            stroke="#32281b"
            stroke-width="1"
            points="0,0 248,0 258,15 262,-15 272,0 540,0"></polyline>
        <line
            x1="0"
            x2="0"
            y1="0"
            y2="-{190 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <text
            x="-50"
            y="-{95 * $increased}"
            text-anchor="middle"
            fill="#32281b"
            style="writing-mode:tb"
            transform="rotate(180 -50 -190)">Número ocorrências</text>
        <text
            x="290"
            text-anchor="middle"
            y="70"
            fill="#32281b">Folio Ms. A</text>
        <line
            x1="-3"
            x2="3"
            y1="-{20 * $increased}"
            y2="-{20 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{40 * $increased}"
            y2="-{40 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{60 * $increased}"
            y2="-{60 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{80 * $increased}"
            y2="-{80 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{100 * $increased}"
            y2="-{100 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{120 * $increased}"
            y2="-{120 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{140 * $increased}"
            y2="-{140 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{160 * $increased}"
            y2="-{160 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-{180 * $increased}"
            y2="-{180 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{10 * $increased}"
            y2="-{10 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{30 * $increased}"
            y2="-{30 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{50 * $increased}"
            y2="-{50 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{70 * $increased}"
            y2="-{70 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{90 * $increased}"
            y2="-{90 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{110 * $increased}"
            y2="-{110 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{130 * $increased}"
            y2="-{130 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{150 * $increased}"
            y2="-{150 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-2"
            x2="2"
            y1="-{170 * $increased}"
            y2="-{170 * $increased}"
            stroke="#32281b"
            stroke-width="1"/>
        
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{20 * $increased - 4}">20</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{40 * $increased - 4}">40</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{60 * $increased - 4}">60</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{80 * $increased - 4}">80</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{100 * $increased - 4}">100</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{120 * $increased - 4}">120</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{140 * $increased - 4}">140</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{160 * $increased - 4}">160</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-{180 * $increased - 4}">180</text>
        
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="40"
            x2="40"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="80"
            x2="80"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="120"
            x2="120"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="160"
            x2="160"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="200"
            x2="200"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="240"
            x2="240"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="280"
            x2="280"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="320"
            x2="320"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="360"
            x2="360"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="400"
            x2="400"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="440"
            x2="440"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="480"
            x2="480"/>
        <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="520"
            x2="520"/>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="40">1</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="80">5</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="120">10</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="160">15</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="200">20</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="240">25</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="280">55</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="320">60</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="360">65</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="400">70</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="440">75</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="480">80</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="520">85</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="100"
            y="105"
            fill="#11894A"
            stroke-width=".5"
            stroke="#32281b"/>
        <text
            fill="#32281b"
            font-size="11"
            x="125"
            y="120">Variantes de língua</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="325"
            y="105"
            fill="#2b3966"
            stroke-width=".5"
            stroke="#32281b"/>
        <text
            fill="#32281b"
            font-size="11"
            x="350"
            y="120">Número de fenómenos únicos</text>
    </g>
    <g
        transform="translate(80,400)">
        {
            for $section at $pos in $sections/*
            let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
            let $y2 := count($section/following-sibling::*[1]/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]) * $increased
            let $y := count($ling) * $increased
            let $dist-ling := count(distinct-values($ling)) * $increased
            let $yControl := ($y - $y2) div 2 - $y2
            let $x := 40 * $pos (:40 is the interval between the sections:)
            return
                
                (<circle
                    r="3.5"
                    cx="{$x}"
                    cy="-{$y}"
                    fill="#11894A"/>
                ,
                <circle
                    r="3.5"
                    cx="{$x}"
                    cy="-{$dist-ling}"
                    fill="#2B3966"/>
                ,
                <path
                    stroke-width="3"
                    stroke="pink"
                    opacity="0.9"
                    fill="none"
                    d="M{$x} -{$y} Q {$x + 20} {$yControl} {$x + 40} -{$y2}"/>
                
                )
        
        }
        {
            for $section at $pos in $sections/*[position() mod 2 = 1]
            let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
            let $y2 := count($section/following-sibling::*[2]/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]) * $increased
            let $y := count($ling) * $increased
            let $controlY := count($section/following-sibling::*[1]/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]) * $increased
            let $x := (($pos - 1) + $pos) * 40
            return
                <path
                    stroke-width="3"
                    stroke="orange"
                    fill="none"
                    d="M{$x} -{$y} Q {$x + 40} -{$controlY} {$x + 80} -{$y2}"/>
        }
        
        <path
            fill="none"
            stroke="yellow"
            opacity="1"
            stroke-width="3"
            d="M40 -48 Q {
                    for $section at $pos in $sections/*
                    let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
                    let $dist-ling := count(distinct-values($ling)) * $increased
                    let $x := $pos * 40
                    return
                        concat($x, ' -', $dist-ling)
                } 520 -52"/>
        
        <path
            fill="none"
            stroke="red"
            opacity="0.7"
            stroke-width="3"
            d="M40 -48 Q 60 -90 80 -132 S {
                    for $section at $pos in $sections/*[position() != 1]
                    let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
                    let $dist-ling := count(distinct-values($ling)) * $increased
                    let $x := ($pos + 1) * 40
                    return
                        concat($x, ' -', $dist-ling)
                } 520 -52"/>
    </g>
</svg>