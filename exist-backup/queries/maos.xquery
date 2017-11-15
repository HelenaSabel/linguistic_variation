xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $increase := number('5');
declare variable $result := request:get-parameter("phenomenon", ("misread"));
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $readings := $songs//tei:rdg;

    <svg 
    xmlns="http://www.w3.org/2000/svg"
                        width="3300"
                        height="200">
                        {
                            
                            let $ocorrencias := $readings[some $ana in tokenize(@ana, '\s+') satisfies $ana = concat('#', $result)]
                            let $witnesses:= distinct-values($ocorrencias/tokenize(./@wit, '\s+'))
                            let $orderedWitness := for $i in $witnesses order by $i descending return $i
                            for $wit at $position in $orderedWitness
                            let $hands := $songs[.//tei:rdg[. intersect $ocorrencias[contains(@wit, $wit)]]]/tei:head//tei:rdg[@wit = $wit]/@hand
                            let $orderedDistinctHands := for $hand in distinct-values($hands) order by $hand return $hand
                            for $h at $pos in $orderedDistinctHands
                            let $width := count($songs[tei:head//tei:rdg[@wit = $wit][@hand = $h]]
                                //tei:rdg[. intersect $ocorrencias][contains(@wit, $wit)])
                            let $div := count($songs[./tei:head//tei:rdg/@hand = $h]//tei:l)
                            order by $h
                            return
                                <g>
                                     <rect
                                                    fill="#2B3966"
                                                    height="22"
                                                    width="{$width * 4}"
                                                    x="70"
                                                    y="{$pos * 22 + ($position * 22)}"
                                                    stroke="white"
                                                    stroke-width="2"/>
                                    <text
                                        fill="black"
                                        x="10"
                                        y="{$pos * 22 + ($position * 22) + 16}"
                                    >Mão {substring($h, 2)}</text>
                                </g>
                            
                                    
                        } 
                </svg>