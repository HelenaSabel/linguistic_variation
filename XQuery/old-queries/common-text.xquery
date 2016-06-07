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
      <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Overlapping graphs</title>
    </head>
    <body>
{for $author in $authors
let $booksong := $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)]
order by $author
return
  
    (<h2>{$author/tei:persName/string()}</h2>,
     <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="120">
     {
         let $widthA:= sum($booksong/descendant::tei:rdg[contains(@wit, '#A')]/string-length(.)) div 10
         let $xB:= sum($booksong/descendant::tei:rdg[@wit eq'#A']/string-length(.)) div 10
         let $widthB:= sum($booksong/descendant::tei:rdg[contains(@wit, '#B')]/string-length(.)) div 10
         let $count:= count($booksong)
         return
            (: if (count($booksong) le 3) then
             <g>
                <rect width="{$widthA}" x="0" height="50" fill="#A73415" stroke="black" stroke-width="1" opacity=".8"/>
                <rect width="{$widthB}" x="{$xB}" height="50" fill="#3E4861" stroke="black" stroke-width="1" opacity=".8"/>
             </g>
             else 
                 if(count($booksong) gt 8) then 
                    <g>
                    <rect width="{$widthA div 4}" x="0" height="200" fill="#A73415" stroke="black" stroke-width="1" opacity=".8"/>
                    <rect width="{$widthB div 4}" x="{$xB div 4}" height="200" fill="#3E4861" stroke="black" stroke-width="1" opacity=".8"/>
                  </g>
                     
                     
                     else
                  <g>
                    <rect width="{$widthA div 2}" x="0" height="100" fill="#A73415" stroke="black" stroke-width="1" opacity=".8"/>
                    <rect width="{$widthB div 2}" x="{$xB div 2}" height="100" fill="#3E4861" stroke="black" stroke-width="1" opacity=".8"/>
                  </g>:)
            <g>
                <rect width="{$widthA div $count}" x="0" height="{10 * $count}" fill="#A73415" stroke="black" stroke-width="1" opacity=".8"/>
                <rect width="{$widthB div $count}" x="{$xB div $count}" height="{10 * $count}" fill="#3E4861" stroke="black" stroke-width="1" opacity=".8"/>
             </g>
                  
     }
     </svg>)}
     </body>
    </html>