xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace heb = "www.usc.es/athene";
declare function heb:loc($from as xs:string, $to as xs:string)
{
    if ($from eq $to)
    then
        concat('f. ', $from)
    else
        (if (replace($from, 'v|r', '') eq replace($to, 'v|r', ''))
        then
            concat('f. ', $from, '-v')
        else
            concat('f. ', $from, '-', $to))
};
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml');
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;
declare variable $equipolent := $fs//tei:fvLib[@n eq 'equipolent readings']/tei:fs/@xml:id;
declare variable $scribalError := $fs//tei:fvLib[@corresp eq '#scribal']/tei:fs/@xml:id;
declare variable $significant := $equipolent | $scribalError | $ling-features;
declare variable $authors := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $songs//tei:name[@role eq 'author']/@ref];
declare variable $fixedWidth := number('600');
declare variable $fixedHeight := number('25');
declare variable $legendWidth := number('22');
declare variable $legendHeight := number('22');
<svg
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    width="850"
    height="{count($authors) * 26 + 75}">
    <g
        transform="translate(190, 0)">
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="0"
            y="{count($authors) * 26 + 50}"
            fill="#555137"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="#32281b"
            font-size="11"
            x="25"
            y="{count($authors) * 26 + 65}">Língua</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="150"
            y="{count($authors) * 26 + 50}"
            fill="#FFC938"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="#32281b"
            font-size="11"
            x="175"
            y="{count($authors) * 26 + 65}">Erros</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="300"
            y="{count($authors) * 26 + 50}"
            fill="#2b3966"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="#32281b"
            font-size="11"
            x="325"
            y="{count($authors) * 26 + 65}">Equipolentes</text>
        <rect
            height="{$legendHeight}"
            width="{$legendWidth}"
            x="450"
            y="{count($authors) * 26 + 50}"
            fill="#CF4205"
            stroke-width=".5"
            stroke="black"/>
        <text
            fill="#32281b"
            font-size="11"
            x="475"
            y="{count($authors) * 26 + 65}">Outras*</text>
    </g>
    {
        let $sortedAuthors := for $author in $authors
        order by $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)][1]/descendant::tei:title/descendant::tei:rdg[@wit eq
        '#A']/tei:locus/number(replace(@from, '(v|r)', ''))
        return
            $author
        for $author at $pos in $sortedAuthors
        let $booksong := $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]
        let $area := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
        let $errors := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $scribalError]/string-length(.)) * $fixedWidth div $area
        let $equip := sum($booksong/descendant::tei:rdg[contains(@ana, '#equip')]/string-length(.)) * $fixedWidth div $area
        let $ling := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string-length(.)) * $fixedWidth div $area
        let $y := 26 * $pos
        let $min := min($songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]/descendant::tei:title/descendant::tei:rdg[@wit eq
        '#A']/tei:locus/number(replace(@from, 'v|r', '')))
        let $max := max($songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]/descendant::tei:title/descendant::tei:rdg[@wit eq
        '#A']/tei:locus/number(replace(@to, 'v|r', '')))
        let $from := if ($songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]/descendant::tei:title/descendant::tei:rdg[@wit eq
        '#A']/tei:locus/contains(@from, concat($min, 'r'))) then
            concat($min, 'r')
        else
            concat($min, 'v')
        let $to := if ($songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]/descendant::tei:title/descendant::tei:rdg[@wit eq
        '#A']/tei:locus/contains(@to, concat($max, 'v'))) then
            concat($max, 'v')
        else
            concat($max, 'r')
        return
            <a
                xlink:href="{concat('http://gl-pt.obdurodon.org/edition.php?author[]=', $author/@xml:id/string())}"
                target="_blank">
                <g
                    transform="translate(190,0)">
                    <rect
                        height="{$fixedHeight}"
                        width="{$ling}"
                        y="{$y}"
                        fill="#555137"
                        stroke="#eae5c5"
                        stroke-width="1"/>
                    <rect
                        height="{$fixedHeight}"
                        width="{$errors}"
                        y="{$y}"
                        x="{$ling}"
                        fill="#FFC938"
                        stroke="#eae5c5"
                        stroke-width="1"/>
                    <rect
                        height="{$fixedHeight}"
                        width="{$equip}"
                        y="{$y}"
                        x="{$ling + $errors}"
                        fill="#2b3966"
                        stroke="#eae5c5"
                        stroke-width="1"/>
                    <rect
                        height="{$fixedHeight}"
                        width="{$fixedWidth - $ling - $errors - $equip}"
                        y="{$y}"
                        x="{$ling + $errors + $equip}"
                        fill="#CF4205"
                        stroke="#eae5c5"
                        stroke-width="1"/>
                    <text
                        x="-3"
                        y="{$y + 15}"
                        fill="#32281b"
                        text-anchor="end"
                        font-size="11">{$author/tei:persName/string()}</text>
                    <text
                        x="605"
                        y="{$y + 15}"
                        fill="#32281b"
                        font-size="11">{heb:loc($from, $to)}</text>
                
                </g>
            </a>
    }
</svg>
