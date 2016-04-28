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
declare variable $radio := number("3");
<svg xmlns="http://www.w3.org/2000/svg" width="1020" height="1020">
    <g transform="translate(500,500)">
        <line x1="-360" y1="0" x2="360" y2="0" stroke="black" stroke-width="1"/>
        <line x1="0" y1="-360" x2="0" y2="360" stroke="black" stroke-width="1"/>
        <polyline points="0,360 -360,0 0,-360 360,0 0,360" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,320 -320,0 0,-320 320,0 0,320" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,280 -280,0 0,-280 280,0 0,280" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,40 -40,0 0,-40 40,0 0,40" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,80 -80,0 0,-80 80,0 0,80" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,120 -120,0 0,-120 120,0 0,120" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,160 -160,0 0,-160 160,0 0,160" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,200 -200,0 0,-200 200,0 0,200" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <polyline points="0,240 -240,0 0,-240 240,0 0,240" stroke-dasharray="2,2" stroke="black" stroke-width="1" fill="none"/>
        <text font-size="11" fill="black" x="5" y="-5" text-anchor="start">0</text>
        <text font-size="11" fill="black" x="5" y="45" text-anchor="start">10</text>
        <text font-size="11" fill="black" x="5" y="-80" text-anchor="start">20</text>
        <text font-size="11" fill="black" x="5" y="-160" text-anchor="start">40</text>
        <text font-size="11" fill="black" x="5" y="-240" text-anchor="start">60</text>
        <text font-size="11" fill="black" x="5" y="-320" text-anchor="start">80</text>
        <text font-size="11" fill="black" x="5" y="125" text-anchor="start">30</text>
        <text font-size="11" fill="black" x="5" y="205" text-anchor="start">50</text>
        <text font-size="11" fill="black" x="5" y="285" text-anchor="start">70</text>
        <text font-size="11" fill="black" x="5" y="365" text-anchor="start">90</text>
        <text font-size="11" fill="black" x="-45" y="-5" text-anchor="middle">10</text>
        <text font-size="11" fill="black" x="-125" y="-5" text-anchor="middle">30</text>
        <text font-size="11" fill="black" x="-205" y="-5" text-anchor="middle">50</text>
        <text font-size="11" fill="black" x="-285" y="-5" text-anchor="middle">70</text>
        <text font-size="11" fill="black" x="-365" y="-5" text-anchor="middle">90</text>
        <text font-size="11" fill="black" x="80" y="-5" text-anchor="start">20</text>
        <text font-size="11" fill="black" x="160" y="-5" text-anchor="start">40</text>
        <text font-size="11" fill="black" x="240" y="-5" text-anchor="start">60</text>        
        <text font-size="11" fill="black" x="320" y="-5" text-anchor="start">80</text>
        <text x="22" y="-350">Variantes de língua</text>
        <text x="-340" y="-40" text-anchor="end">Erros de cópia</text>
        <text y="-40" x="365">Outras</text>
        <text x="-32" text-anchor="end" y="350">Equipolentes</text>
    </g>
    {for $period in distinct-values($periods)
    let $booksong := $songs[.//tei:name/substring(@ref, 2) = $poets[./tei:floruit/@period eq $period]/@xml:id]
    let $total := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $significant]/string-length(.))
    let $errors := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $scribalError]/string-length(.)) * $fixedWidth div $total
    let $equip := sum($booksong/descendant::tei:rdg[contains(@ana, '#equip')]/string-length(.)) * $fixedWidth div $total
    let $ling := sum($booksong/descendant::tei:rdg[tokenize(replace(@ana, '#', ''), '\s+') = $ling-features]/string-length(.)) * $fixedWidth div $total
    let $outras := $total * $fixedWidth div $total - $errors - $equip - $ling
     return
         <g transform="translate(500,500)" class="per{$period}">
         <polyline stroke="black" fill="none" stroke-width="1" points="{concat('0,-', $ling, ' -', $errors, ',0 0,', $equip,  ' ', $outras, ',0 ', '0,-', $ling)}"/>
         <circle r="{$radio}" cy="-{$ling}" cx="0"/>
         <circle r="{$radio}" cy="{$equip}" cx="0"/>
         <circle r="{$radio}" cx="-{$errors}" cy="0"/>
         <circle r="{$radio}" cx="{$outras}" cy="0"/>
     </g>
    }
</svg>