xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := //song[@class eq 'A'];
declare variable $b := //song[@class eq 'B'];
declare variable $collection := collection('../../edition')//tei:div[@type eq 'poem'];
declare variable $authors := distinct-values($songs/author);
declare variable $realauthors := $songs/author[not(. = ' ')];
declare variable $colors := ('#B54D1A', '#EAE5C5', '#4E240A', '#351278', '#B0E9ED', '#FFFDF0', '#848DF1', '#58B94C', '#B15282', '#5B77EE', '#FD2F8D', '#311CE1',
'#E399DE', '#6A685A', '#D03471', '#6C659D', '#398566', '#74A0D7', '#F20EDA', '#6BA901', '#A38A9E', '#1D8A3E', '#1A2BB0', '#5C647F', '#EFC88C', '#A303DA', '#2F7A9B', '#9A5C61', '#CABFE5',
'#1C4D5D', '#679DA1', '#B788A4', '#9D9875', '#F45B43', '#050526', '#2D648A', '#4C0391', '#B1CFF3', '#AE709B', '#4A14F4', '#A21169', '#BA6CDF', '#D91A91', '#D40549', '#1842D3',
'#68579C', '#157715', '#7FF998', '#4EA807');
declare variable $colors2 := ('#B54D1A', '#4E240A', '#351278', '#B0E9ED', '#FFFDF0', '#848DF1', '#58B94C', '#B15282', '#5B77EE', '#FD2F8D', '#311CE1', 
'#E399DE', '#6A685A', '#D03471', '#6C659D', '#398566', '#74A0D7', '#F20EDA', '#6BA901', '#A38A9E', '#1D8A3E', '#1A2BB0', '#5C647F', '#EFC88C', 
'#A303DA', '#2F7A9B', '#9A5C61', '#CABFE5', '#1C4D5D', '#679DA1', '#B788A4', '#9D9875', '#F45B43', '#050526', '#2D648A', '#4C0391', '#B1CFF3', '#AE709B', 
'#4A14F4', '#A21169', '#BA6CDF', '#D91A91', '#D40549', '#1842D3', '#68579C', '#157715', '#7FF998', '#4EA807');
declare variable $colors3 := ('#B54D1A', '#EAE5C5', '#4E240A', '#351278', '#B0E9ED', '#EAE5C5', '#848DF1', '#58B94C', '#B15282', '#5B77EE', '#FD2F8D', '#311CE1',
'#E399DE', '#6A685A', '#D03471', '#6C659D', '#398566', '#74A0D7', '#F20EDA', '#6BA901', '#A38A9E', '#1D8A3E', '#1A2BB0', '#5C647F', '#EFC88C', '#A303DA', '#2F7A9B', '#9A5C61', '#CABFE5',
'#1C4D5D', '#679DA1', '#B788A4', '#9D9875', '#F45B43', '#050526', '#2D648A', '#4C0391', '#B1CFF3', '#AE709B', '#4A14F4', '#A21169', '#BA6CDF', '#D91A91', '#D40549', '#1842D3',
'#68579C', '#157715', '#7FF998', '#4EA807');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="100%"
    height="450"
    view-box="0 0 1600 450"
    preserveAspectRatio="xMidYMid meet">
    <text
        y="56"
        x="110"
        text-anchor="end"
        font-size="11">All</text>
    <text
        y="130"
        x="110"
        text-anchor="end"
        font-size="11">Other witnesses</text>
    <text
        y="204"
        x="110"
        text-anchor="end"
        font-size="11">Done</text>
    <g>
        {
            let $sorted := for $song in $songs
            order by $song/*[1]/number(replace(., '-.*', ''))
            return
                $song
            for $song at $position in $sorted
            let $margin := number('100')
            let $current := index-of($authors, $song/*[3])
            return
                (if ((number($song/*[1]) + 3) mod 4 = 0) then
                    <rect
                        x="{(($position + 3) div 4 * 15) + $margin}"
                        y="20"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        fill="{$colors[$current]}"/>
                
                else
                    (if ((number($song/*[1]) + 2) mod 4 = 0)
                    
                    then
                        <rect
                            x="{(($position + 2) div 4 * 15) + $margin}"
                            y="35"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors[$current]}"/>
                    
                    else
                        (if ((number($song/*[1]) + 1) mod 4 = 0) then
                            <rect
                                x="{(($position + 1) div 4 * 15) + $margin}"
                                y="50"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                fill="{$colors[$current]}"/>
                        else
                            <rect
                                x="{($position div 4 * 15) + $margin}"
                                y="65"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                fill="{$colors[$current]}"/>
                        ))
                
                ,
                if ($song/*[1]/@id = $b/*[1]/@id and (number($song/*[1]) + 3) mod 4 = 0) then
                    <rect
                        x="{(($position + 3) div 4 * 15) + $margin}"
                        y="95"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        fill="{$colors3[$current]}"/>
                else
                    (if ($song/*[1]/@id = $b/*[1]/@id and (number($song/*[1]) + 2) mod 4 = 0)
                    then
                        <rect
                            x="{(($position + 2) div 4 * 15) + $margin}"
                            y="110"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors3[$current]}"/>
                    else
                        (if ($song/*[1]/@id = $b/*[1]/@id and (number($song/*[1] + 1) mod 4 = 0))
                        then
                            <rect
                                x="{(($position + 1) div 4 * 15) + $margin}"
                                y="125"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                fill="{$colors3[$current]}"/>
                        else
                            (if ($song/*[1]/@id = $b/*[1]/@id and number($song/*[1] mod 4 = 0)) then
                                <rect
                                    x="{($position div 4 * 15) + $margin}"
                                    y="140"
                                    height="15"
                                    width="15"
                                    stroke="#EAE5C5"
                                    fill="{$colors3[$current]}"/>
                            else
                                ()))),
                
                if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                and (number($song/*[1]) + 3) mod 4 = 0) then
                    <rect
                        x="{(($position + 3) div 4 * 15) + $margin}"
                        y="170"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        fill="{$colors[$current]}"/>
                else
                    (if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                    and (number($song/*[1]) + 2) mod 4 = 0) then
                        <rect
                            x="{(($position + 2) div 4 * 15) + $margin}"
                            y="185"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors[$current]}"/>
                    else
                        (if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                        and number($song/*[1] + 1) mod 4 = 0) then
                            <rect
                                x="{(($position + 1) div 4 * 15) + $margin}"
                                y="200"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                fill="{$colors[$current]}"/>
                        else
                            (if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                            and number($song/*[1]) mod 4 = 0) then
                                <rect
                                    x="{($position div 4 * 15) + $margin}"
                                    y="215"
                                    height="15"
                                    width="15"
                                    stroke="#EAE5C5"
                                    fill="{$colors[$current]}"/>
                            else
                                ())))
                )
        }
    </g>
    <g>{
            for $author at $pos in distinct-values($realauthors)
            let $current := $colors2[$pos]
            return
                if (($pos + 5) mod 6 = 0) then
                    (<text
                        y="310"
                        x="{$pos * 36 + 82}"
                        font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                    <rect
                        y="300"
                        fill="{$current}"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        x="{$pos * 36 + 62}"/>)
                else
                    (if (($pos + 4) mod 6 = 0)
                    then
                        (<text
                            y="335"
                            x="{($pos - 1) * 36 + 82}"
                            font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                        <rect
                            y="325"
                            fill="{$current}"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            x="{($pos - 1) * 36 + 62}"/>)
                    else
                        (if (($pos + 3) mod 6 = 0) then
                            (<text
                                y="360"
                                x="{($pos - 2) * 36 + 82}"
                                font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                            <rect
                                y="350"
                                fill="{$current}"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                x="{($pos - 2) * 36 + 62}"/>)
                        else
                            (if (($pos + 2) mod 6 = 0) then
                                (<text
                                    y="385"
                                    x="{($pos - 3) * 36 + 82}"
                                    font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                                <rect
                                    y="375"
                                    fill="{$current}"
                                    height="15"
                                    width="15"
                                    stroke="#EAE5C5"
                                    x="{($pos - 3) * 36 + 62}"/>)
                            else
                                (if (($pos + 1) mod 6 = 0)
                                then
                                    (<text
                                        y="410"
                                        x="{($pos - 4) * 36 + 82}"
                                        font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                                    <rect
                                        y="400"
                                        fill="{$current}"
                                        height="15"
                                        width="15"
                                        stroke="#EAE5C5"
                                        x="{($pos - 4) * 36 + 62}"/>)
                                else
                                    (if ($pos mod 6 = 0)
                                    then
                                        (<text
                                            y="435"
                                            x="{($pos - 5) * 36 + 82}"
                                            font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                                        <rect
                                            y="425"
                                            fill="{$current}"
                                            height="15"
                                            width="15"
                                            stroke="#EAE5C5"
                                            x="{($pos - 5) * 36 + 62}"/>)
                                    else
                                        ())))))
        }
    </g>
</svg>