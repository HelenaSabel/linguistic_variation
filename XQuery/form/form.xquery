xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $fenomenos := doc('/db/tese/drafts/songs/ancillary/feature_library.xml')//tei:fs[@feats[contains(., '#ling')]]
return
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
       <title>Estudos lingüísticos</title>
       <link href="index.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="body">
            <div class="banner"><img src="banner-ms.jpg" alt="banner" /></div>
        <h2>Variação linguística</h2>
        <div class="form">
        <form method='POST' action='ling.xq'>
        {for $ana in $fenomenos/@xml:id
        let $name:= $fenomenos[@xml:id = $ana]/@n/string()
        order by $name
            return
                (<input type="checkbox" name="fenomeno" value="{$ana}">{$name}</input>,<br/>)
                
        }
        <button class="submit" type="submit">Pesquisa</button>
        </form>
        </div>
        </div>
    </body>
    </html>