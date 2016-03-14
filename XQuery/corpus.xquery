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
                            class="all"
                            id="none1"
                            checked="checked"/>
                        <label
                            for="none1"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span></label>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            value="{$author/@xml:id}"
                            id="author{$i}"
                            class="all"/>
                        <label
                            for="author{$i}"><span
                                class="pt">Todas</span>
                            <span
                                class="en">All</span></label>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            class="show"
                            id="select{$i}"/>
                        <label
                            for="select{$i}"><span
                                class="pt">Seleccionar</span>
                            <span
                                class="en">Select</span></label>
                        <ul
                            class="hide">
                            {
                                for $song in $songs
                                order by $song/number(substring-before(substring(@corresp, 3), 'B'))
                                return
                                    <li><input
                                            type="checkbox"
                                            id="{$song/substring(@corresp, 2)}"
                                            name="song[]"
                                            value="{$song/substring(@corresp, 2)}"/>
                                        <label
                                            for="{$song/substring(@corresp, 2)}">{string-join($song//tei:title//tei:idno, ', ')}</label></li>
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
                            class="all"
                            id="none2"
                            checked="checked"/>
                        <label
                            for="none2"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span></label>
                        <input
                            type="radio"
                            name="period[{$period}]"
                            value="{$period}"
                            id="{$period}"
                            class="all"/>
                        <label
                            for="{$period}"><span
                                class="pt">Todas</span>
                            <span
                                class="en">All</span></label>
                        <input
                            type="radio"
                            name="period[{$period}]"
                            id="select{$period}"
                            class="show"/>
                        <label
                            for="select{$period}"><span
                                class="pt">Seleccionar</span>
                            <span
                                class="en">Select</span></label>
                        <ul
                            class="hide">
                            {
                                for $song in $songs
                                order by $song/number(substring-before(substring(@corresp, 3), 'B'))
                                return
                                    <li><input
                                            type="checkbox"
                                            id="{$song/substring(@corresp, 2)}"
                                            name="song[]"
                                            value="{$song/substring(@corresp, 2)}"/>
                                        <label
                                            for="{$song/substring(@corresp, 2)}">{string-join($song//tei:title//tei:idno, ', ')}</label></li>
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
            class="pt">Por copista</span><span
            class="en">By scribe</span></h2>,
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
                            class="all"
                            id="none3"
                            checked="checked"/>
                        <label
                            for="none3"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span></label>
                        <input
                            type="radio"
                            name="scribe[{$hand}]"
                            value="{$hand}"
                            id="{$hand}"
                            class="all"/>
                        <label
                            for="{$hand}"><span
                                class="pt">Todas</span>
                            <span
                                class="en">All</span></label>
                        <input
                            type="radio"
                            name="scribe[{$hand}]"
                            class="show"
                            id="select{$hand}"/>
                        <label
                            for="select{$hand}"><span
                                class="pt">Seleccionar</span>
                            <span
                                class="en">Select</span></label>
                        <ul
                            class="hide">
                            {
                                for $song in $songs
                                order by $song/number(substring-before(substring(@corresp, 3), 'B'))
                                return
                                    <li><input
                                            type="checkbox"
                                            id="{$song/substring(@corresp, 2)}"
                                            name="song[]"
                                            value="{$song/substring(@corresp, 2)}"/>
                                        <label
                                            for="{$song/substring(@corresp, 2)}">{string-join($song//tei:title//tei:idno, ', ')}</label></li>
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
