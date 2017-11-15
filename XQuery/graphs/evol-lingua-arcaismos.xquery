xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(:declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']; (\:corpus of songs:\)
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml'); (\:variants file:\):)
declare variable $songs := collection('../../edition')//tei:div[@type eq 'poem'];
declare variable $names := doc('../../ancillary/corpus-autores.xml')//tei:person;
declare variable $authors := $songs//tei:name;
declare variable $fs := doc('../../ancillary/feature-library.xml')//tei:fs[@type];
declare variable $ling-features := for $i in $fs[@type eq 'arcaico']/@xml:id
return
    concat('#', $i);
declare variable $legendWidth := number('22');
declare variable $legendHeight := number('22');
declare variable $increased := number('15');
declare variable $sep := number('9');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="1500"
    height="1000">
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
            y2="-{9 * $increased}"
            stroke="black"
            stroke-width="1"/>
        <text
            x="1380"
            y="-60"
            font-size="12.5"
            text-anchor="middle"
            fill="black"
            style="writing-mode:tb"
            transform="rotate(180 1380 -60)">Número ocorrências</text>
        
        {
            for $section at $pos in
            for $i in $songs
            order by number($i//tei:title//tei:rdg[@wit eq '#A']/substring(tei:idno, 2)) descending
            return
                $i
            let $ling := $section/descendant::tei:rdg[tokenize(@ana, '\s+') = $ling-features]
            let $song := $section//tei:title//tei:rdg[@wit eq '#A']/tei:idno/string()
            let $y := count($ling) * $increased
            let $dist-ling := count(distinct-values($ling/string())) * $increased
            let $x := $sep * $pos
            return
                
                (<line
                    fill="none"
                    stroke="gray"
                    stroke-dasharray="5,5"
                    stroke-width="1"
                    y1="0"
                    y2="-{9 * $increased}"
                    x1="{$x}"
                    x2="{$x}"
                />,
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
                    r="2.8"
                    cx="{$x}"
                    cy="-{$dist-ling}"
                    fill="#2B3966"/>
                
                )
        
        }
    </g>
    <g transform="translate(20,500)">
    <polyline
    fill="none"
    stroke="#2B3966"
    stroke-width="1"
    points="{for $section at $pos in
            for $i in $songs
            order by number($i//tei:title//tei:rdg[@wit eq '#A']/substring(tei:idno, 2)) descending
            return
                $i
            let $ling := $section/descendant::tei:rdg[tokenize(@ana, '\s+') = $ling-features]
            let $dist-ling := count(distinct-values($ling/string())) * $increased
            let $x := $sep * $pos
            
            return
            $x || ',-' || $dist-ling
    
    }" />
    
    
    </g>
    <g
        transform="translate(20,500)">
        {
            for $i in 1 to 9
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
    
    <g transform="translate(20,500)">
    {
    for $poet at $pos in
            for $i in distinct-values($authors/@ref)
            order by number($songs[descendant::tei:name/@ref = $i][1]//tei:title//tei:rdg[@wit eq '#A']/substring(tei:idno, 2)) descending
            return
                $i
    let $name := $names[@xml:id = substring($poet, 2)]/tei:persName
    
    let $x := $sep * count($songs//tei:name/@ref = $poet) * $pos
    return
    
    <text y="50" x="{$x}" 
      font-size="10"
      transform="{concat('rotate(180 ', $x, ' 50)')}"
      style="writing-mode:tb" 
      text-anchor="end">{$name/string()}</text>
    }
    
    </g>

</svg>
