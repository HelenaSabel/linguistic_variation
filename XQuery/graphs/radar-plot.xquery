xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml');
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;
declare variable $equipolent := $fs//tei:fvLib[@n eq 'equipolent readings']/tei:fs/@xml:id;
declare variable $scribalError := $fs//tei:fvLib[@corresp eq '#scribal']/tei:fs/@xml:id;
declare variable $significant := $equipolent | $scribalError | $ling-features;
declare variable $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $songs//tei:name[@role eq 'author']/@ref];
declare variable $periods := $poets[@xml:id = $songs//tei:name/substring(@ref, 2)]/tei:floruit/@period;
declare variable $fixedWidth := number('400');
declare variable $radio := number("3.5");
declare variable $color := ('#2B3966', '#BD6D03', '#B3A8CC', '#CF4205', '#6C659D', '#009CA2', '#BC9650', '#233310', '#FFC938', '#5C647F',
'#22461E', '#EDDF81', '#6A643A', '#B0E9ED', '#B788A4', '#889BB7', '#73843A', '#3d4144', '#6A685A', '#2B6273',
'#73473C', '#490301', '#f2cf95', '#1B0CA2', '#630C03', '#025256', '#E25C05', '#11894A', '#009CA2', '#895F11');
declare variable $max := number('320');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="820"
    height="720">
    <g
        transform="translate(440,350)">
        <line
            x1="-{$max}"
            y1="0"
            x2="{$max}"
            y2="0"
            stroke="#32281b"
            stroke-width="1"/>
        <line
            x1="0"
            y1="-{$max}"
            x2="0"
            y2="{$max}"
            stroke="#32281b"
            stroke-width="1"/>
        <polyline
            points="0,{$max} -{$max},0 0,-{$max} {$max},0 0,{$max}"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,280 -280,0 0,-280 280,0 0,280"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,40 -40,0 0,-40 40,0 0,40"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,80 -80,0 0,-80 80,0 0,80"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,120 -120,0 0,-120 120,0 0,120"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,160 -160,0 0,-160 160,0 0,160"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,200 -200,0 0,-200 200,0 0,200"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <polyline
            points="0,240 -240,0 0,-240 240,0 0,240"
            stroke-dasharray="2,2"
            stroke="#32281b"
            stroke-width="1"
            fill="none"/>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="-5"
            text-anchor="start">0</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="45"
            text-anchor="start">10</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="-80"
            text-anchor="start">20</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="-160"
            text-anchor="start">40</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="-240"
            text-anchor="start">60</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="-320"
            text-anchor="start">80</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="125"
            text-anchor="start">30</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="205"
            text-anchor="start">50</text>
        <text
            font-size="11"
            fill="#32281b"
            x="5"
            y="285"
            text-anchor="start">70</text>
        <text
            font-size="11"
            fill="#32281b"
            x="-45"
            y="-5"
            text-anchor="middle">10</text>
        <text
            font-size="11"
            fill="#32281b"
            x="-125"
            y="-5"
            text-anchor="middle">30</text>
        <text
            font-size="11"
            fill="#32281b"
            x="-205"
            y="-5"
            text-anchor="middle">50</text>
        <text
            font-size="11"
            fill="#32281b"
            x="-285"
            y="-5"
            text-anchor="middle">70</text>
        <text
            font-size="11"
            fill="#32281b"
            x="80"
            y="-5"
            text-anchor="start">20</text>
        <text
            font-size="11"
            fill="#32281b"
            x="160"
            y="-5"
            text-anchor="start">40</text>
        <text
            font-size="11"
            fill="#32281b"
            x="240"
            y="-5"
            text-anchor="start">60</text>
        <text
            font-size="11"
            fill="#32281b"
            x="320"
            y="-5"
            text-anchor="start">80</text>
        <text
            x="25"
            y="-307">Variantes de língua</text>
        <text
            x="-300"
            y="-30"
            text-anchor="end">Erros de cópia</text>
        <text
            y="17"
            x="323">Outras</text>
        <text
            x="-32"
            text-anchor="end"
            y="310">Equipolentes</text>
    </g>
    {
        for $period at $pos in distinct-values($periods)
        let $booksong := $songs[.//tei:name/substring(@ref, 2) = $poets[./tei:floruit/@period eq $period]/@xml:id]
        let $total := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
        let $errors := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $scribalError]/string-length(.)) * $fixedWidth div $total
        let $equip := sum($booksong/descendant::tei:rdg[contains(@ana, '#equip')]/string-length(.)) * $fixedWidth div $total
        let $ling := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string-length(.)) * $fixedWidth div $total
        let $outras := $total * $fixedWidth div $total - $errors - $equip - $ling
        return
            <g
                transform="translate(440,350)"
                class="per{$period}">
                <polyline
                    stroke="{$color[$pos]}"
                    fill="none"
                    stroke-width="2"
                    points="{concat('0,-', $ling, ' -', $errors, ',0 0,', $equip, ' ', $outras, ',0 ', '0,-', $ling)}"/>
                <polyline
                    stroke="none"
                    fill="{$color[$pos]}"
                    opacity=".4"
                    points="{concat('0,-', $ling, ' -', $errors, ',0 0,', $equip, ' ', $outras, ',0 ', '0,-', $ling)}"/>
                <circle
                    fill="{$color[$pos]}"
                    r="{$radio}"
                    cy="-{$ling}"
                    cx="0"/>
                <circle
                    fill="{$color[$pos]}"
                    r="{$radio}"
                    cy="{$equip}"
                    cx="0"/>
                <circle
                    fill="{$color[$pos]}"
                    r="{$radio}"
                    cx="-{$errors}"
                    cy="0"/>
                <circle
                    fill="{$color[$pos]}"
                    r="{$radio}"
                    cx="{$outras}"
                    cy="0"/>
            </g>
    }
    {
        
        let $sortedAuthors := for $author in $poets
        order by $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)][1]/descendant::tei:title/descendant::tei:rdg[@wit eq
        '#A']/tei:locus/number(replace(@from, '(v|r)', ''))
        return
            $author
        for $author at $pos in $sortedAuthors
        let $booksong := $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]
        let $total := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
        let $errors := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $scribalError]/string-length(.)) * $fixedWidth div $total
        let $equip := sum($booksong/descendant::tei:rdg[contains(@ana, '#equip')]/string-length(.)) * $fixedWidth div $total
        let $ling := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string-length(.)) * $fixedWidth div $total
        let $outras := $total * $fixedWidth div $total - $errors - $equip - $ling
        let $no := $pos + 2
        return
            <g
                id="esc{$pos}"
                transform="translate(440,350)"
                class="{$author/@xml:id}">
                <polyline
                    stroke="{$color[$no]}"
                    fill="none"
                    stroke-width="2"
                    points="{concat('0,-', $ling, ' -', $errors, ',0 0,', $equip, ' ', $outras, ',0 ', '0,-', $ling)}"/>
                <polyline
                    stroke="none"
                    fill="{$color[$no]}"
                    opacity=".4"
                    points="{concat('0,-', $ling, ' -', $errors, ',0 0,', $equip, ' ', $outras, ',0 ', '0,-', $ling)}"/>
                <circle
                    fill="{$color[$no]}"
                    r="{$radio}"
                    cy="-{$ling}"
                    cx="0"/>
                <circle
                    fill="{$color[$no]}"
                    r="{$radio}"
                    cy="{$equip}"
                    cx="0"/>
                <circle
                    fill="{$color[$no]}"
                    r="{$radio}"
                    cx="-{$errors}"
                    cy="0"/>
                <circle
                    fill="{$color[$no]}"
                    r="{$radio}"
                    cx="{$outras}"
                    cy="0"/>
            </g>
    }
</svg>