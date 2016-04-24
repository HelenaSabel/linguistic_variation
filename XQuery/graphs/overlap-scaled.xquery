xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml');
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;
declare variable $equipolent := $fs//tei:fvLib[@n eq 'equipolent readings']/tei:fs/@xml:id;
declare variable $scribalError := $fs//tei:fvLib[@corresp eq '#scribal']/tei:fs/@xml:id;
declare variable $significant := $equipolent | $scribalError | $ling-features;
let $authors := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $songs//tei:name[@role eq 'author']/@ref]
return
    <svg
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        width="{count($authors) * 50 + 130}"
        height="580">
        <g
            transform="translate(120,300)">
            <line
                stroke="black"
                stroke-width="2"
                x1="0"
                x2="{count($authors) * 50}"
                y1="-1"
                y2="-1"/>
            <line
                stroke="black"
                stroke-width="2"
                x1="0"
                x2="0"
                y1="0"
                y2="-300"/>
            <text
                x="-45"
                y="-25"
                text-anchor="end">Ms. A</text>
            <rect
                x="-35"
                y="-40"
                width="22"
                height="22"
                fill="#777E90"
                stroke-width=".5"
                stroke="black"/>
            <text
                x="-45"
                y="-200"
                text-anchor="end">Ms. B</text>
            <rect
                x="-35"
                y="-215"
                width="22"
                height="22"
                fill="#C1705A"
                stroke-width=".5"
                stroke="black"/>
            
            {
                let $sortedAuthors := for $author in $authors
                order by $author/tei:persName
                return
                    $author
                for $author at $pos in $sortedAuthors
                let $booksong := $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]
                let $heightA := number('200')
                let $realA := sum($booksong/descendant::tei:rdg[contains(@wit, '#A')]/string-length(.))
                let $heightB := sum($booksong/descendant::tei:rdg[contains(@wit, '#B')]/string-length(.)) * $heightA div $realA
                let $yB1 := sum($booksong/descendant::tei:rdg[@wit = ('#A', '#A #V')][tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.)) * $heightA div $realA
                let $yB2 := sum($booksong/descendant::tei:rdg[@wit = ('#A', '#A #V')][following-sibling::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]]/string-length(.)) * $heightA div $realA
                
                return
                    <a
                        xlink:href="{concat('http://gl-pt.obdurodon.org/edition.php?author[]=', $author/@xml:id/string())}"
                        target="_blank">
                        <g>
                            <rect
                                height="{$heightB}"
                                fill="#A73415"
                                x="{50 * ($pos - 1) + 5}"
                                width="30"
                                y="-{$yB1 + $yB2 + $heightB}"
                                opacity=".7"/>
                            <rect
                                height="{$heightA}"
                                fill="#3E4861"
                                x="{50 * ($pos - 1) + 5}"
                                width="30"
                                y="-{$heightA}"
                                opacity=".7"/>
                            <text
                                x="{50 * ($pos - 1) + 20}"
                                y="8"
                                style="writing-mode: tb;">{$author/tei:persName/string()}</text>
                        </g>
                    
                    </a>
            
            }</g>
    
    </svg>