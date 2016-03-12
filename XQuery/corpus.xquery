xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
let $authors := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[@xml:id/string() = collection('/db/VTLGP/edition')//tei:name[@role eq 'author']/substring(@ref, 2)]
let $periods := $authors/tei:floruit/@period
let $copyists := collection('/db/VTLGP/edition')//tei:div//tei:title//tei:rdg/substring(@hand, 2)
return
    (<form
        method="GET"
        action="edition.php">
        {
            for $i in 1 to (count($authors))
            let $author := $authors[$i]
            let $songs := collection('/db/VTLGP/edition')//tei:name[@role eq 'author'][substring(@ref, 2) = $author/string(@xml:id)]/ancestor::tei:div
            order by $author
            return
                <fieldset>
                    <legend>{$author/tei:persName/string()}</legend>
                    <div>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            value="{$author/@xml:id}"
                            class="all"/>
                        <span
                            class="pt">Todas</span>
                        <span
                            class="en">All</span>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            class="show"/>
                        <span
                            class="pt">Seleccionar</span>
                        <span
                            class="en">Select</span>
                        <ul
                            class="hide">
                            {
                                for $song in $songs
                                return
                                    <li><input
                                            type="checkbox"
                                            name="song[]"
                                            value="{$song/substring(@corresp, 2)}"/>
                                        {string-join($song//tei:title//tei:idno, ', ')}</li>
                            }</ul>
                    </div>
                </fieldset>
        }
        <button
            class="submit"
            type="submit"><span
                class="pt">Pesquisa</span><span
                class="en">Search</span></button>
    </form>,
    <h2
        id="period"><span
            class="pt">Por período</span><span
            class="en">By period</span></h2>,
    <form
        method="GET"
        action="edition.php">
        {
            for $period in distinct-values($periods)
            let $songs := collection('/db/VTLGP/edition')//tei:name[@role eq 'author'][substring(@ref, 2) = $authors[tei:floruit/@period eq $period]/@xml:id]/ancestor::tei:div
            order by number($period)
            return
                <fieldset>
                    <legend><span
                            class="pt">Período {$period}</span><span
                            class="en">Period {$period}</span></legend>
                    <div>
                        <input
                            type="radio"
                            name="period[{$period}]"
                            value="{$period}"
                            class="all"/>
                        <span
                            class="pt">Todas</span>
                        <span
                            class="en">All</span>
                        <input
                            type="radio"
                            name="period[{$period}]"
                            class="show"/>
                        <span
                            class="pt">Seleccionar</span>
                        <span
                            class="en">Select</span>
                        <ul
                            class="hide">
                            {
                                for $song in $songs
                                return
                                    <li><input
                                            type="checkbox"
                                            name="song[]"
                                            value="{$song/substring(@corresp, 2)}"/>
                                        {string-join($song//tei:title//tei:idno, ', ')}</li>
                            }</ul>
                    </div>
                </fieldset>
        }
        <button
            class="submit"
            type="submit"><span
                class="pt">Pesquisa</span><span
                class="en">Search</span></button>
    </form>,
    <h2
        id="copyist"><span
            class="pt">Copista</span><span
            class="en">Scribe</span></h2>,
    <form
        method="GET"
        action="edition.php">
        {
            for $hand in distinct-values($copyists)
            let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'][.//tei:title//tei:rdg/substring(@hand, 2) = $hand]
            order by $hand
            return
                <fieldset>
                    <legend><span
                            class="pt">Copista {$hand} (manuscrito{
                                (if ($hand = ('b', 'c', 'a', 'd', 'e')) then
                                    ' B'
                                else
                                    (if ($hand = 'v') then
                                        ' V'
                                    else
                                        ' A'))
                            })</span>
                        <span
                            class="en">Scribe {$hand} (witness{
                                (if ($hand = ('b', 'c', 'a', 'd', 'e')) then
                                    ' B'
                                else
                                    (if ($hand = 'v') then
                                        ' V'
                                    else
                                        ' A'))
                            })</span></legend>
                    <div>
                        <input
                            type="radio"
                            name="scribe[{$hand}]"
                            value="{$hand}"
                            class="all"/>
                        <span
                            class="pt">Todas</span>
                        <span
                            class="en">All</span>
                        <input
                            type="radio"
                            name="scribe[{$hand}]"
                            class="show"/>
                        <span
                            class="pt">Seleccionar</span>
                        <span
                            class="en">Select</span>
                        <ul
                            class="hide">
                            {
                                for $song in $songs
                                return
                                    <li><input
                                            type="checkbox"
                                            name="song[]"
                                            value="{$song/substring(@corresp, 2)}"/>
                                        {string-join($song//tei:title//tei:idno, ', ')}</li>
                            }</ul>
                    </div>
                </fieldset>
        }
        <button
            class="submit"
            type="submit"><span
                class="pt">Pesquisa</span><span
                class="en">Search</span></button>
    </form>
    )
