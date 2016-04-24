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
let $barShift := number('26')
return
    <svg
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        width="2000"
        height="{count($authors) * 30}">
        <g
            transform="translate(190,520)">
            <text
                x="45"
                y="-500"
                text-anchor="end">Ms. A</text>
            <rect
                x="55"
                y="-515"
                width="22"
                height="22"
                fill="#777E90"
                stroke-width=".5"
                stroke="black"/>
            <text
                x="150"
                y="-500"
                text-anchor="end">Ms. B</text>
            <rect
                x="155"
                y="-515"
                width="22"
                height="22"
                fill="#C1705A"
                stroke-width=".5"
                stroke="black"/>
            
            {
                
                let $sortedAuthors := for $author in $authors
                order by sum($songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]/descendant::tei:rdg[contains(@wit, '#A')]/string-length(.))
                return
                    $author
                for $author at $pos in $sortedAuthors
                let $div := number('13')
                let $booksong := $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]
                let $widthA := sum($booksong/descendant::tei:rdg[contains(@wit, '#A')]/string-length(.)) div $div
                let $widthB := sum($booksong/descendant::tei:rdg[contains(@wit, '#B')]/string-length(.)) div $div
                let $xB1 := sum($booksong/descendant::tei:rdg[@wit = ('#A', '#A #V')][tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.)) div $div
                let $xB2 := sum($booksong/descendant::tei:rdg[@wit = ('#A', '#A #V')][following-sibling::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]]/string-length(.)) div $div
                return
                    <a
                        xlink:href="{concat('http://gl-pt.obdurodon.org/edition.php?author[]=', $author/@xml:id/string())}"
                        target="_blank">
                        <g>
                            <rect
                                height="25"
                                fill="#A73415"
                                x="{$xB1 + $xB2}"
                                width="{$widthB}"
                                y="-{$barShift * ($pos - 1)}"
                                opacity=".7"/>
                            <rect
                                height="25"
                                fill="#3E4861"
                                x="0"
                                width="{$widthA}"
                                y="-{$barShift * ($pos - 1)}"
                                opacity=".7"/>
                            <text
                                x="-3"
                                y="{-1 * ($barShift * $pos - 43)}"
                                text-anchor="end"
                                font-size="11">{$author/tei:persName/string()}</text>
                        </g>
                    </a>
            }</g>
    
    </svg>