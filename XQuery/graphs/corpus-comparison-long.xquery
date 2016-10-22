xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := //song[@class eq 'A'];
declare variable $b := //song[@class eq 'B'];
declare variable $collection := collection('../../edition')//tei:div[@type eq 'poem'];
declare variable $authors := distinct-values($songs/author);
declare variable $realauthors := $songs/author[not(. = ' ')];
declare variable $colors := ('#B54D1A', '#4E240A', '#351278', '#FFFDF0', '#B0E9ED', '#848DF1', '#58B94C', '#B15282', '#5B77EE', '#FD2F8D', '#311CE1',
'#E399DE', '#6A685A', '#D03471', '#EAE5C5', '#6C659D', '#398566', '#74A0D7', '#F20EDA', '#6BA901', '#A38A9E', '#1D8A3E', '#1A2BB0', '#5C647F', '#EFC88C', '#A303DA', '#2F7A9B', '#9A5C61', '#CABFE5',
'#1C4D5D', '#679DA1', '#B788A4', '#9D9875', '#F45B43', '#050526', '#2D648A', '#4C0391', '#B1CFF3', '#AE709B', '#4A14F4', '#A21169', '#BA6CDF', '#D91A91', '#D40549', '#1842D3',
'#68579C', '#157715', '#7FF998', '#4EA807');
declare variable $colors2 := ('#B54D1A', '#4E240A', '#351278', '#FFFDF0', '#B0E9ED', '#848DF1', '#58B94C', '#B15282', '#5B77EE', '#FD2F8D', '#311CE1', 
'#E399DE', '#6A685A', '#D03471', '#6C659D', '#398566', '#74A0D7', '#F20EDA', '#6BA901', '#A38A9E', '#1D8A3E', '#1A2BB0', '#5C647F', '#EFC88C', 
'#A303DA', '#2F7A9B', '#9A5C61', '#CABFE5', '#1C4D5D', '#679DA1', '#B788A4', '#9D9875', '#F45B43', '#050526', '#2D648A', '#4C0391', '#B1CFF3', '#AE709B', 
'#4A14F4', '#A21169', '#BA6CDF', '#D91A91', '#D40549', '#1842D3', '#68579C', '#157715', '#7FF998', '#4EA807');
<svg
    xmlns="http://www.w3.org/2000/svg"
    width="100%"
    height="300"
    view-box="0 0 1635 300"
    preserveAspectRatio="xMidYMid meet">
    <text
        y="45"
        x="110"
        text-anchor="end"
        font-size="11">All</text>
    <text
        y="100"
        x="110"
        text-anchor="end"
        font-size="11">Other witnesses</text>
    <text
        y="155"
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
                (if ((number($song/*[1]) + 2) mod 3 = 0) then
                    <rect
                        x="{(($position + 2) div 3 * 15) + $margin}"
                        y="20"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        fill="{$colors[$current]}"/>
                
                else
                    (if ((number($song/*[1]) + 1) mod 3 = 0)
                    
                    then
                        <rect
                            x="{(($position + 1) div 3 * 15) + $margin}"
                            y="35"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors[$current]}"/>
                    
                    else
                        <rect
                            x="{($position div 3 * 15) + $margin}"
                            y="50"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors[$current]}"/>
                    )
                
                ,
                if ($song/*[1]/@id = $b/*[1]/@id and (number($song/*[1]) + 2) mod 3 = 0) then
                    <rect
                        x="{(($position + 2) div 3 * 15) + $margin}"
                        y="75"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        fill="{$colors[$current]}"/>
                else
                    (if ($song/*[1]/@id = $b/*[1]/@id and (number($song/*[1]) + 1) mod 3 = 0)
                    then
                        <rect
                            x="{(($position + 1) div 3 * 15) + $margin}"
                            y="90"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors[$current]}"/>
                    else
                        (if ($song/*[1]/@id = $b/*[1]/@id and number($song/*[1] mod 3 = 0))
                        then
                            <rect
                                x="{($position div 3 * 15) + $margin}"
                                y="105"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                fill="{$colors[$current]}"/>
                        else
                            ())),
                if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                and (number($song/*[1]) + 2) mod 3 = 0) then
                    <rect
                        x="{(($position + 2) div 3 * 15) + $margin}"
                        y="130"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        fill="{$colors[$current]}"/>
                else
                    (if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                    and (number($song/*[1]) + 1) mod 3 = 0) then
                        <rect
                            x="{(($position + 1) div 3 * 15) + $margin}"
                            y="145"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            fill="{$colors[$current]}"/>
                    else
                        (if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')
                        and number($song/*[1]) mod 3 = 0) then
                            <rect
                                x="{($position div 3 * 15) + $margin}"
                                y="160"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                fill="{$colors[$current]}"/>
                        else
                            ()))
                )
        }
    </g>
    <g>{
            for $author at $pos in distinct-values($realauthors)
            let $current := $colors2[$pos]
            return
                if (($pos + 3) mod 4 = 0) then
                    (<text
                        y="210"
                        x="{$pos * 47 + 82}"
                        font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                    <rect
                        y="200"
                        fill="{$current}"
                        height="15"
                        width="15"
                        stroke="#EAE5C5"
                        x="{$pos * 47 + 62}"/>)
                else
                    (if (($pos + 2) mod 4 = 0)
                    then
                        (<text
                            y="235"
                            x="{($pos - 1) * 47 + 82}"
                            font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                        <rect
                            y="225"
                            fill="{$current}"
                            height="15"
                            width="15"
                            stroke="#EAE5C5"
                            x="{($pos - 1) * 47 + 62}"/>)
                    else
                        (if (($pos + 1) mod 4 = 0) then
                            (<text
                                y="260"
                                x="{($pos - 2) * 47 + 82}"
                                font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                            <rect
                                y="250"
                                fill="{$current}"
                                height="15"
                                width="15"
                                stroke="#EAE5C5"
                                x="{($pos - 2) * 47 + 62}"/>)
                        else
                            (if ($pos mod 4 = 0)
                            then
                                (<text
                                    y="285"
                                    x="{($pos - 3) * 47 + 82}"
                                    font-size="11">{replace($author, '\(.*?\)', '')}</text>,
                                <rect
                                    y="275"
                                    fill="{$current}"
                                    height="15"
                                    width="15"
                                    stroke="#EAE5C5"
                                    x="{($pos - 3) * 47 + 62}"/>)
                            else
                                ())))
        }
    </g>
</svg>