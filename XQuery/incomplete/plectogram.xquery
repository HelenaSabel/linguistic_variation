xquery version "3.0";
declare variable $corpus:= doc('/db/VTLGP/ancillary/corpus.xml')/*;
declare variable $wits := $corpus/song/@class;
<svg xmlns="http://www.w3.org/2000/svg" width="600" height="39550">
{for $column at $pos in distinct-values($wits)
let $x := 140 * $pos
order by $column
return
    <g>
        <text x="{$x + 48}" text-anchor="middle" y="20">{$column}</text>
        {let $sorted := for $song in $corpus/*[@class = $column] order by $song/*[1]/number(replace(.,'-.*', ''))
        return $song
        for $song at $position in $sorted
            return 
                (<rect x="{$x}" y="{($position * 15) + 40}" height="15" width="96" stroke="#EAE5C5" fill="{
                    if($song/*[1]/@class/string() eq 'A') then '#6E0A00' else (if ($song/*[1]/@class/string() eq 
                    'E') then '#2B3966' else (if($song/*[1]/@class/string() eq 
                    'M') then '#48462E' else '#77659D'))
                }" class="{$song/*[1]/@id/string()}"/>,
                <text fill="#EAE5C5" x="{$x + 48}" text-anchor="middle" y="{$position * 15 + 51}" font-size="10">{$song/*[1]/replace(., '-([a-z])', '$1')}</text>)
        }
    </g>
}</svg>
