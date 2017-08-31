xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $increase := number('2');
declare variable $height := number('22');
declare variable $fs := doc('../../ancillary/feature-library.xml')//tei:fs[@type];
declare variable $arcaic :=
for $i in $fs[@type eq 'arcaico']/@xml:id
return
    concat('#', $i);
declare variable $innova-pt := for $i in $fs[@type eq 'inova-pt']/@xml:id
return
    concat('#', $i);
declare variable $innova-gl := for $i in $fs[@type eq 'inova-gl']/@xml:id
return
    concat('#', $i);
declare variable $innova := for $i in $fs[@type eq 'inova']/@xml:id
return
    concat('#', $i);
declare variable $songs := collection('../../edition')//tei:div[@type eq 'poem'];
declare variable $readingsA := $songs//tei:rdg[contains(@wit, '#A')];
declare variable $readingsB := $songs//tei:rdg[contains(@wit, '#B')];
declare variable $poets := doc('../../ancillary/corpus-autores.xml')//tei:person;
let $width1a := count($readingsA[tokenize(@ana, '\s+') = $arcaic])
let $width1a-dis := count(distinct-values($readingsA[tokenize(@ana, '\s+') = $arcaic]))
let $width2a := count($readingsA[tokenize(@ana, '\s+') = $innova]) + count($readingsA[tokenize(@ana, '\s+') = $innova-gl]) +
count($readingsA[tokenize(@ana, '\s+') = $innova-pt])
let $width2a-dis := count(distinct-values($readingsA[tokenize(@ana, '\s+') = $innova])) +
count(distinct-values($readingsA[tokenize(@ana, '\s+') = $innova-gl])) + count(distinct-values($readingsA[tokenize(@ana, '\s+') = $innova-pt]))

let $width1b := count($readingsB[tokenize(@ana, '\s+') = $arcaic])
let $width1b-dis := count(distinct-values($readingsB[tokenize(@ana, '\s+') = $arcaic]))
let $width2b := count($readingsB[tokenize(@ana, '\s+') = $innova]) + count($readingsB[tokenize(@ana, '\s+') = $innova-gl]) +
count($readingsB[tokenize(@ana, '\s+') = $innova-pt])
let $width2b-dis := count(distinct-values($readingsB[tokenize(@ana, '\s+') = $innova])) +
count(distinct-values($readingsB[tokenize(@ana, '\s+') = $innova-gl])) + count(distinct-values($readingsB[tokenize(@ana, '\s+') = $innova-pt]))

let $width3a := count($readingsA[tokenize(@ana, '\s+') = $innova-gl])
let $width3a-dis := count(distinct-values($readingsA[tokenize(@ana, '\s+') = $innova-gl]))
let $width3b := count($readingsB[tokenize(@ana, '\s+') = $innova-gl])
let $width3b-dis := count(distinct-values($readingsB[tokenize(@ana, '\s+') = $innova-gl]))

let $width4a := count($readingsA[tokenize(@ana, '\s+') = $innova-pt])
let $width4a-dis := count(distinct-values($readingsA[tokenize(@ana, '\s+') = $innova-pt]))
let $width4b := count($readingsB[tokenize(@ana, '\s+') = $innova-pt])
let $width4b-dis := count(distinct-values($readingsB[tokenize(@ana, '\s+') = $innova-pt]))

return
    <html>
        <head>
            <title>Grafos</title>
        </head>
        <body>
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1200"
                height="200">
                <text
                    x="90"
                    y="{40}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">arcaísmos A</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width1a}"
                    x="100"
                    y="{$height}"
                    stroke="white"
                />
                <text
                    x="90"
                    y="{60}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">arcaísmos B</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width1b}"
                    x="100"
                    y="{$height * 2}"
                    stroke="white"
                />
                <text
                    x="90"
                    y="{80}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações A</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width2a}"
                    x="100"
                    y="{$height * 3}"
                    stroke="white"
                />
                <text
                    x="90"
                    y="{100}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações B</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width2b}"
                    x="100"
                    y="{$height * 4}"
                    stroke="white"
                />
            </svg>
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1200"
                height="200">
                <text
                    x="90"
                    y="{40}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">arcaísmos A</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width1a-dis}"
                    x="100"
                    y="{$height}"
                    stroke="white"
                />
                <text
                    x="90"
                    y="{60}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">arcaísmos B</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width1b-dis}"
                    x="100"
                    y="{$height * 2}"
                    stroke="white"
                />
                <text
                    x="90"
                    y="{80}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações A</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width2a-dis + 6}"
                    x="100"
                    y="{$height * 3}"
                    stroke="white"
                />
                <text
                    x="90"
                    y="{100}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações B</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width2b-dis + 5}"
                    x="100"
                    y="{$height * 4}"
                    stroke="white"
                />
            </svg>
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1200"
                height="200">
                <text
                    x="110"
                    y="{40}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações A (gl)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width3a}"
                    x="120"
                    y="{$height}"
                    stroke="white"
                />
                <text
                    x="110"
                    y="{60}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações B (gl)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width3b}"
                    x="120"
                    y="{$height * 2}"
                    stroke="white"
                />
                <text
                    x="110"
                    y="{80}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações A (pt)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width4a + 1}"
                    x="120"
                    y="{$height * 3}"
                    stroke="white"
                />
                <text
                    x="110"
                    y="{100}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações B (pt)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width4b}"
                    x="120"
                    y="{$height * 4}"
                    stroke="white"
                />
            </svg>
             <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1200"
                height="200">
                <text
                    x="110"
                    y="{40}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações A (gl)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width3a-dis + 2}"
                    x="120"
                    y="{$height}"
                    stroke="white"
                />
                <text
                    x="110"
                    y="{60}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações B (gl)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width3b-dis}"
                    x="120"
                    y="{$height * 2}"
                    stroke="white"
                />
                <text
                    x="110"
                    y="{80}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações A (pt)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width4a-dis + 4}"
                    x="120"
                    y="{$height * 3}"
                    stroke="white"
                />
                <text
                    x="110"
                    y="{100}"
                    text-anchor="end"
                    fill="black"
                    font-size="12">inovações B (pt)</text>
                <rect
                    fill="#2B3966"
                    height="{$height}"
                    width="{$width4b-dis + 5}"
                    x="120"
                    y="{$height * 4}"
                    stroke="white"
                />
            </svg>
        </body>
    </html>