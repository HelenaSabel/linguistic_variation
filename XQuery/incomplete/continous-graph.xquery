xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (:corpus of songs:)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (:variants file:)
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;
declare variable $equipolent := $fs//tei:fvLib[@n eq 'equipolent readings']/tei:fs[1]/@xml:id;
declare variable $scribalError := $fs//tei:fvLib[@corresp eq '#scribal']/tei:fs/@xml:id;
declare variable $significant := $equipolent | $scribalError | $ling-features;
declare variable $fixedHeight := number('600');
(: Since there is a gap in my edition regarding the location of the songs, I manually create the intervals :)
declare variable $sections :=
<sections>
<item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) = 1][descendant::tei:locus/number(replace(@to, 'v|r', '')) = 1]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 1][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 5]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 5][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 10]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 10][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 15]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 15][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 20]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) > 20][descendant::tei:locus/number(replace(@to, 'v|r', '')) < 25]}</item>
    <item>{$songs[descendant::tei:rdg[@wit eq '#A']/tei:locus/number(replace(@from, 'v|r', '')) >= 25][descendant::tei:locus/number(replace(@to, 'v|r', '')) <= 30]}</item>
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
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="650"
    height="620">
    <g
        transform="translate(80,450)">
        <polyline
            fill="none"
            stroke="#32281b"
            stroke-width="1"
            points="0,0 288,0 298,15 302,-15 312,0 580,0"></polyline>
        <line
            x1="0"
            x2="0"
            y1="0"
            y2="-422"
            stroke="#32281b"
            stroke-width="1"/>
        <text
            x="-50"
            y="-241"
            text-anchor="middle"
            fill="#32281b"
            style="writing-mode:tb"
            transform="rotate(180 -50 -241)">Percentagem variantes significativas</text>
        <text
            x="330"
            text-anchor="middle"
            y="70"
            fill="#32281b">Folio Ms. A</text>
        <line
            x1="-3"
            x2="3"
            y1="-60"
            y2="-60"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-120"
            y2="-120"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-180"
            y2="-180"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-240"
            y2="-240"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-300"
            y2="-300"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-360"
            y2="-360"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="-3"
            x2="3"
            y1="-420"
            y2="-420"
            stroke="#32281b"
            stroke-width="1"/>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-55">10</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-175">30</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-300">50</text>
        <text
            text-anchor="end"
            font-size="11"
            fill="#32281b"
            x="-9"
            y="-415">70</text>
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
                <line
            stroke="#32281b"
            stroke-width="1"
            y1="-3"
            y2="3"
            x1="560"
            x2="560"/>
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
            x="280">30</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="320">55</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="360">60</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="400">65</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="440">70</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="480">75</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="520">80</text>
        <text
            text-anchor="middle"
            fill="#32281b"
            font-size="11"
            y="20"
            x="560">85</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="140"
            y="105"
            fill="#11894A"
            stroke-width=".5"
            stroke="#32281b"/>
        <text
            fill="#32281b"
            font-size="11"
            x="165"
            y="120">Língua</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="290"
            y="105"
            fill="#FFC938"
            stroke-width=".5"
            stroke="#32281b"/>
        <text
            fill="#32281b"
            font-size="11"
            x="315"
            y="120">Erros</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="440"
            y="105"
            fill="#2b3966"
            stroke-width=".5"
            stroke="#32281b"/>
        <text
            fill="#32281b"
            font-size="11"
            x="465"
            y="120">Equipolentes</text>

    </g>
    <g
        transform="translate(80,450)">
        {
            for $section at $pos in $sections/*
            
            (: Total of substantive variants :)
            let $area := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
            
            (: Different type of variants multiplied by the 100% value and divided by the total of variants:)
            let $errors := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $scribalError]/string-length(.)) * $fixedHeight div $area
            let $equip := sum($section/descendant::tei:rdg[contains(@ana, '#equip')]/string-length(.)) * $fixedHeight div $area
            let $ling := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string-length(.)) * $fixedHeight div $area
            let $x := $pos * 40 (:40 is the interval between the sections:)
            return
                (<circle
                    r="3"
                    cx="{$x}"
                    cy="-{$errors}"
                    fill="#FFC938"/>,
                <circle
                    r="3"
                    cx="{$x}"
                    cy="-{$ling}"
                    fill="#11894A"/>,
                <circle
                    r="3"
                    cx="{$x}"
                    cy="-{$equip}"
                    fill="#2B3966"/>)
        
        }
        
        <polyline
            fill="none"
            stroke="#FFC938"
            stroke-width="3"
            points="{
                    for $section at $pos in $sections/*
                    let $area := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
                    let $errors := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $scribalError]/string-length(.)) * $fixedHeight div $area
                    let $x := $pos * 40
                    return
                        concat($x, ',-', $errors)
                }"/>
        <polyline
            fill="none"
            stroke="#11894A"
            stroke-width="3"
            points="{
                    for $section at $pos in $sections/*
                    let $area := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
                    let $ling := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string-length(.)) * $fixedHeight div $area
                    let $x := $pos * 40
                    return
                        concat($x, ',-', $ling)
                }"/>
        <polyline
            fill="none"
            stroke="#2B3966"
            stroke-width="3"
            points="{
                    for $section at $pos in $sections/*
                    let $area := sum($section/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
                    let $equip := sum($section/descendant::tei:rdg[contains(@ana, '#equip')]/string-length(.)) * $fixedHeight div $area
                    let $x := $pos * 40
                    return
                        concat($x, ',-', $equip)
                }"/>
       
    </g>
</svg>