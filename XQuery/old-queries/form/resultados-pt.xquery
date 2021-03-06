xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare function local:locus($from as node(), $to as node())
{(if ($from eq $to)
then $from/string()
else
    if (substring($from,1,string-length($from) - 1) eq substring($to,1,string-length($to) - 1))
            then concat($from,'-v')
            else concat($from,'-',$to))};
declare variable $search:= request:get-parameter("fenomeno", ("dat"));
let $fenomena := doc('/db/tese/drafts/songs/ancillary/feature_library.xml')//tei:fs
let $songs := collection('/db/tese/drafts/songs/songs')//tei:div[@type='poem']
(:  :let $ling := $songs//tei:rdg[tokenize(replace(@ana, '#', ''), ' ') = $fenomena[@feats[contains(., '#ling')]]/@xml:id]:)
let $ling := $songs//tei:rdg
let $poets := doc('/db/tese/drafts/songs/ancillary/corpus_autores.xml')//tei:person
return
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
       <link href="form.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="sorttable.js">/**/</script>
        <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js" type="text/javascript">/**/</script>
        <script type="text/javascript" src="ScrollToFixed.js" >/**/</script>
        <script type="text/javascript" src="sidebar.js">/**/</script>
    </head>
    <body>
        <div class="body">
            <div class="banner"><img src="banner-ms.jpg" alt="banner" />
            </div>
            <div class="container">
            <div class="main">
        <h2>Variação linguística</h2>
        {for $result in $search
        return
        (<h3>{$fenomena[./@xml:id = $result]/@n/string()}</h3>,
        <h4 id="graphs{$result}">Período</h4>,
        <svg xmlns="http://www.w3.org/2000/svg" width="950" height="100">
            {
              
              let $fen:= $ling[matches(@ana, concat('#',$result))]
              for $period at $pos in
              for $i in distinct-values($poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref,2)]/tei:floruit/@period) 
              order by count($fen[ancestor::tei:div[1]//tei:name/substring(@ref,2) = $poets/tei:floruit[@period = $i]/../@xml:id]) descending
                    return $i  
              let $count:= count($fen[ancestor::tei:div[1]//tei:name/substring(@ref,2) = $poets/tei:floruit[@period = $period]/../@xml:id])
              let $sum:= count($fen)
              let $percentage:= round-half-to-even((100 * $count div $sum), 2)
              order by $count descending
              return
                   <g>
                        <rect            
                            fill="darkred"
                            height="20"
                            width="{$count * 15}"
                            x="90"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="black"
                           font-size="12"
                           x="{100+ $count * 15}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="black"
                        x="10"
                        y="{$pos *20 + 18}"
                        >Period {$period}</text>
                    </g>
            }</svg>,
            <h4>Testemunho</h4>,
        <svg xmlns="http://www.w3.org/2000/svg" width="950" height="100">
            {
              
              let $fen:= $ling[matches(@ana, concat('#',$result))]
              for $wit at $pos in
                for $i in distinct-values($fen/@wit) 
                order by count($fen[@wit=$i]) descending
                return $i  
              let $count:= count($fen[@wit=$wit])
              let $sum:= count($fen)
              let $percentage:= round-half-to-even((100 * $count div $sum), 2)
              order by $count descending
              return
                   <g>
                        <rect            
                            fill="darkred"
                            height="20"
                            width="{$count * 15}"
                            x="90"
                            y="{$pos *20}"
                            stroke="black"
                            />
                        <text
                           fill="black"
                           font-size="12"
                           x="{100 + $count * 15}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="black"
                        x="10"
                        y="{$pos *20 + 18}"
                        >Ms. {substring($wit,2)}</text>
                        
                        {
                        let $hand := $songs[.//tei:rdg[. intersect $fen[@wit = $wit]]]/tei:head//tei:rdg[@wit = $wit]/@hand
                        let $distinctHands := distinct-values($hand)
                        for $h in 1 to count($distinctHands)
                        let $x := count($songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[position() lt $h]]]
                            //tei:rdg[. intersect $fen][@wit = $wit])
                        let $div := $songs[tei:head//tei:rdg[@wit = $wit][@hand = $distinctHands[$h]]][.//tei:rdg[. intersect $fen]]
                        let $conta:= count($div//tei:rdg[. intersect $fen[@wit = $wit]])
                        order by $h descending
                        return
                            <g>
                                <rect
                                    fill="darkred"
                                    height="20"
                                    width="{$conta * 15}"
                                    x="{$x * 15 + 90}"
                                    y="{$pos*20}"
                                    stroke="black"
                                    stroke-width="2"/>
                                <text
                                    fill="white"
                                    font-size="10.5"
                                    x="{($x * 15 + 88) + (($conta * 15) div 2) }"
                                    y="{$pos *20 + 12}">{substring($distinctHands[$h],2)}</text>
                            </g>
                        }
                    </g>
            }</svg>,
         <table class="sortable" id="ling{$result}">
            <thead>
                <tr class="head">
                    <th>Fenómeno </th>
                    <th>Testemunho </th>
                    <th>Localização </th>
                    <th>Copista </th>
                    <th>Autor </th>
                    <th>Período </th>
                    <th>Cantiga </th>
                    <th>V. </th>
                </tr>
            </thead>
            <tbody>
            {for $fen in $ling[matches(@ana, concat('#',$result))]
            let $author := $poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref,2)]
            return
                <tr>
                    <td>{(if ($fen//tei:choice) then $fen//tei:reg/string() else
                    (if (string-length($fen) = 0) then <span class="normal">omissão</span>
                    else transform:transform($fen,'xmldb:exist:///db/tese/drafts/xslt/ex.xsl',())
)),' (', <span class="normal">vs</span>, '. ',
                    (if ($fen/../*[not(@wit = $fen/@wit)]/tei:choice) then $fen/../*[not(@wit = $fen/@wit)]//tei:reg/string()
                    else
                    if (string-length($fen/../*[not(@wit = $fen/@wit)]) = 0) then <span class="normal">omissão</span> else $fen/../*[not(@wit = $fen/@wit)]/transform:transform(.,'xmldb:exist:///db/tese/drafts/xslt/ex.xsl',())),')'}</td>
                    <td>{$fen/substring(@wit, 2)}</td>
                    <td>{local:locus($fen/ancestor::tei:div[1]//tei:rdg[@wit = $fen/@wit]/tei:locus/@from, $fen/ancestor::tei:div[1]//tei:rdg[@wit = $fen/@wit]/tei:locus/@to)}</td>
                    <td>{$fen/ancestor::tei:div[1]//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2)}</td>
                    <td>{$author/tei:persName/string()}</td>
                    <td>{$author/tei:floruit/@from||'-'||$author/tei:floruit/@to|| ' (' ||$author/tei:floruit/@period||')'}</td>
                     <td>{$fen/ancestor::tei:div[1]/substring(@corresp, 2)}</td>
                    <td>{$fen/ancestor::tei:l/@n/string()}</td>
                </tr>
             }
             </tbody>
        </table>)
        }
       </div>
                <div class="rightSide" id="move">
                    <div class="gl">
                        <h3>Conteúdos</h3>
                        <ul>
                        {for $result in $search
        return
        (<li>{$fenomena[./@xml:id = $result]/@n/string()}
                        <ul>
                            <li><a href="#graphs{$result}">Gráficas</a></li>
                            <li><a href="#ling{$result}">Tabela</a></li>
                            </ul>
                            </li>)}
                        </ul>
                    </div>
                   </div>
            </div>
        </div>
        <div id="footer"></div>
    </body>
</html>
