xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs:= //song[@class eq 'A'][label/@id = (preceding::label/@id|following::label/@id)];
<svg xmlns="http://www.w3.org/2000/svg" width="600" height="39550">
    <g>
        {
        let $sorted := for $song in $songs order by $song/*[1]/number(replace(.,'-.*', ''))
        return $song
        for $song at $position in $sorted
        let $collection := collection('../edition/corrigidas')//tei:div[@type eq 'poem']
            return 
                (<rect x="20" y="{($position * 15) + 40}" height="15" width="96" stroke="#EAE5C5" fill="{
                    if($song/*[1]/@class/string() eq 'A') then '#6E0A00' else (if ($song/*[1]/@class/string() eq 
                    'E') then '#2B3966' else (if($song/*[1]/@class/string() eq 
                    'M') then '#48462E' else '#77659D'))
                }" class="{$song/*[1]/@id/string()}"/>,
                <text fill="#EAE5C5" x="68" text-anchor="middle" y="{$position * 15 + 51}" font-size="10">{$song/*[1]/replace(., '-([a-z])', '$1')}</text>,
                if ($collection//tei:head/descendant::tei:rdg[@wit eq '#A']/substring(tei:idno, 2) = $song/*[1]/replace(., '-([a-z])', '$1')) then
                <rect x="200" y="{($position * 15) + 40}"  height="15" width="96" stroke="#EAE5C5" fill="{
                    if($song/*[1]/@class/string() eq 'A') then '#6E0A00' else (if ($song/*[1]/@class/string() eq 
                    'E') then '#2B3966' else (if($song/*[1]/@class/string() eq 
                    'M') then '#48462E' else '#77659D'))
                }" class="{$song/*[1]/@id/string()}"/> else ()
        )}
    </g>
</svg>