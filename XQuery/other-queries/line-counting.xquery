xquery version "3.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";
let $transcriptions := collection('/db/tese/drafts/temporary')
let $A := $transcriptions//div[@wit="#A"]
let $B := $transcriptions//div[@wit="#B"]
let $V := $transcriptions//div[@wit eq '#V']
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
                let $v := $V[@corresp eq $corresp]
                let $b-count := count($b/l)
                let $a-count := count($a/l)
                let $v-count:= count($v/l)
                where count(distinct-values(($a-count, $b-count, if ($v) then $v-count else ()))) ne 1
                return <li>{$corresp || ': A ' || $a-count || '; B ' || $b-count || (if ($v-count gt 0) then ('; V ' || $v-count) else ())}</li>
                }</ul>
            </body>
        </html>