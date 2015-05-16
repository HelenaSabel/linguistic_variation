xquery version "3.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $transcriptions := collection('/db/transcriptions-draft')
let $A := $transcriptions//div[@wit="#A"]
let $B := $transcriptions//div[@wit="#B"]
return
    <html>
        <head>
            <title>Line counts</title>
        </head>
        <body>
            <ul>{
                for $b in $B[@corresp = $A/@corresp]
                let $corresp := $b/@corresp
                let $a := $A[@corresp eq $corresp]
                let $b-count := count($b//l)
                let $a-count := count($a//l)
                where $a-count ne $b-count
                return
                    <li>{'Corresp value ' || $corresp ||': A has ' ||
                    $a-count || ' lines and B has ' || $b-count|| ' lines'}</li>
                }</ul>
            </body>
        </html>