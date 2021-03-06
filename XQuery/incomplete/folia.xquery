xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (:corpus of songs:)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (:variants file:)
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;
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
        transform="translate(80,400)">{
let $pages:= $songs/descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', ''))
let $orderedPages:= for $page in distinct-values($pages) order by $page return $page
let $sections :=
        for $page in $orderedPages
        return
    <section>
        {$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) = $page]}
    </section>
for $section at $pos in $sections
let $ling := $section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]
let $number := $section/descendant::tei:rdg[1][@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', ''))

            
        }
</g>
</svg>