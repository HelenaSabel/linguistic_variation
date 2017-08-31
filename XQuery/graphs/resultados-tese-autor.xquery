xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(:declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (\:corpus of songs:\)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (\:variants file:\):)
declare variable $songs := collection('../../edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('../../ancillary/feature-library.xml');
declare variable $ling-features := $fs//tei:fs[tei:f/tei:fs[@type eq 'linguistic']]/@xml:id;
declare variable $legendWidth := number('22');
declare variable $legendHeight := number('22');
declare variable $increased := number('20');
declare variable $sep := number('20');
declare variable $authors := doc('../../ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $songs//tei:name/@ref];
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="800"
    height="700">
    <pattern id="diagonalHatch" patternUnits="userSpaceOnUse" width="4" height="4">
  <path d="M-1,1 l2,-2
           M0,4 l4,-4
           M3,5 l2,-2" 
        style="stroke:orange; stroke-width:.3" />
</pattern>
    <g
        transform="translate(240,600)">
        <line
            fill="none"
            stroke="black"
            stroke-width="1"
            x1="0"
            x2="0"
            y1="0"
            y2="-{2 + count($authors) * $sep}"></line>
        <line
            fill="none"
            stroke="black"
            stroke-width="1"
            x1="0"
            x2="370"
            y1="0"
            y2="0"/>
        <text
            x="200"
            y="50"
            text-anchor="middle"
            fill="black">Índice de formas únicas por verso</text>
        <text
            y="-{2 + count($authors) * $sep div 2}"
            text-anchor="middle"
            x="-185"
            transform="{concat('rotate(270 -185 -', 2 + count($authors) * $sep div 2, ')')}">Autores</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="390"
            y="-250"
            fill="orange"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="black"
            font-size="12"
            x="428"
            y="-235">Ms. B</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="390"
            y="-280"
            fill="#2b3966"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="black"
            font-size="12"
            x="428"
            y="-265">Ms. A</text>
        
        {   let $orderedAuthors := for $i in $authors order by $i/tei:nationality/@key descending return $i
            for $author at $pos in $orderedAuthors
            let $booksong := $songs[descendant::tei:name[substring(@ref, 2) = $author/@xml:id]]
            let $lines := count($booksong//tei:l)
            let $ling-A := distinct-values($booksong/descendant::tei:rdg[contains(@wit, '#A')]
            [tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string())
            let $ling-B := distinct-values($booksong/descendant::tei:rdg[contains(@wit, '#B')]
            [tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string())
            let $x-A := count($ling-A) * $increased * 100 div $lines
            let $x-B := count($ling-B) * $increased * 100 div $lines
            let $y := $sep * $pos
            return
                
                (<line
                    fill="none"
                    stroke="gray"
                    stroke-width="1"
                    stroke-dasharray="3,3"
                    y1="-{$y}"
                    y2="-{$y}"
                    x1="0"
                    x2="370"/>,
                <circle
                    stroke="black"
                    stroke-width=".5"
                    r="4"
                    cx="{$x-B}"
                    cy="-{$y}"
                    fill="orange"/>
                ,
                <circle
                    stroke="black"
                    stroke-width=".5"
                    r="4"
                    cx="{$x-A}"
                    cy="-{$y}"
                    opacity="{if ($x-A eq $x-B) then '.5' else '1'}"
                    fill="#2B3966"/>,
                <line
                    fill="none"
                    stroke="black"
                    stroke-width="1"
                    y1="-{$y}"
                    y2="-{$y}"
                    x1="-2"
                    x2="2"/>,
                
                
                <text
                    fill="black"
                    stroke="{if ($author/tei:floruit/@period eq '2') then 'black' else 'none'}"
                    y="-{$y - 2}"
                    x="-5"
                    stroke-width=".5"
                    text-anchor="end"
                    font-size="10">{$author/tei:persName/text()}</text>
                
                )
        
        }
        {
            for $i in 1 to 36
            return
                <line
                    x1="{$i div 2 * $increased}"
                    x2="{$i div 2 * $increased}"
                    y1="-2"
                    y2="2"
                    fill="none"
                    stroke="black"
                    stroke-width="1"/>
        }
        
        {
            for $i in 1 to 18
            return
                <text
                    fill="black"
                    x="{$i * $increased}"
                    y="20"
                    text-anchor="middle"
                    font-size="10">{$i}</text>
        }
    </g>

</svg>
