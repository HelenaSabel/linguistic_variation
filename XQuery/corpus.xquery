xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xhtml";
declare option output:indent "yes";
declare option output:encoding "UTF-8";
let $authors := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = collection('/db/VTLGP/edition')//tei:name[@role eq 'author']/@ref]
let $periods := $authors/tei:floruit/@period
let $copyists := collection('/db/VTLGP/edition')//tei:div//tei:title//tei:rdg/substring(@hand, 2)
let $authorsImpar := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = collection('/db/VTLGP/edition')//tei:name[@role eq 'author']/@ref][tei:persName/matches(., '^[A-J]')]
let $authorsPar := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = collection('/db/VTLGP/edition')//tei:name[@role eq 'author']/@ref][tei:persName/matches(., '^[L-Z]')]
return
    
    (<form class="authors"
        method="GET"
        action="edition.php">
        <div class="form">
        <div class="item">
        {
            for $i in 1 to (count($authorsImpar))
            let $author := $authorsImpar[$i]
            let $songs := collection('/db/VTLGP/edition')//tei:name[@role eq 'author'][@ref = $author/concat('#', @xml:id)]/ancestor::tei:div
            order by $author
            return
                <fieldset>
                    <legend id="{$author/@xml:id/string()}">{$author/tei:persName/string()}</legend>
                    <div>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            class="all"
                            id="none{$i}"
                            checked="checked"/>
                        <label
                            class="all"
                            for="none{$i}"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span><span class="gl">Ningunha</span></label>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            value="{$author/@xml:id}"
                            id="author{$i}"
                            class="all"/>
                        <label class="corpus all"
                            for="author{$i}"><span
                                class="pt gl">Todas</span>
                            <span
                                class="en">All</span> ({count($songs)})</label>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            class="show"
                            id="select{$i}"/>
                        <label
                            for="select{$i}"><span
                                class="pt gl">Sele<span class="gl">c</span>cionar</span>
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
        }</div>
        <div class="item">
         {
            for $x in 1 to (count($authorsPar))
            let $author := $authorsPar[$x]
            let $i := $x + 14
            let $songs := collection('/db/VTLGP/edition')//tei:name[@role eq 'author'][@ref = $author/concat('#', @xml:id)]/ancestor::tei:div
            order by $author
            return
                <fieldset>
                    <legend id="{$author/@xml:id/string()}">{$author/tei:persName/string()}</legend>
                    <div>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            class="all"
                            id="none{$i}"
                            checked="checked"/>
                        <label
                            class="all"
                            for="none{$i}"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span><span class="gl">Ningunha</span></label>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            value="{$author/@xml:id}"
                            id="author{$i}"
                            class="all"/>
                        <label class="corpus all"
                            for="author{$i}"><span
                                class="pt gl">Todas</span>
                            <span
                                class="en">All</span> ({count($songs)})</label>
                        <input
                            type="radio"
                            name="author[{$i}]"
                            class="show"
                            id="select{$i}"/>
                        <label
                            for="select{$i}"><span
                                class="pt gl">Sele<span class="gl">c</span>cionar</span>
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
        
        </div>
        </div>
        <button
            class="submit"
            type="submit"><span
                class="pt gl">Pesquisa</span><span
                class="en">Search</span></button>
    </form>,
   (: <h2
        id="period"><span
            class="pt">Por período</span><span
            class="en">By period</span></h2>,
    <form
        method="GET"
        action="edition.php">
        {
            for $period in distinct-values($periods)
            let $songs := collection('/db/VTLGP/edition')//tei:name[@role eq 'author'][@ref = $authors[tei:floruit/@period eq $period]/concat('#', @xml:id)]/ancestor::tei:div
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
                            id="none{$period}"
                            checked="checked"/>
                        <label
                            for="none{$period}"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span></label>
                        <input
                            type="radio"
                            name="period[{$period}]"
                            value="{$period}"
                            id="{$period}"
                            class="all"/>
                        <label class="corpus"
                            for="{$period}"><span
                                class="pt">Todas</span>
                            <span
                                class="en">All</span> ({count($songs)})</label>
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
    </form>,:)
    <h2
        id="copyist"><span
            class="pt gl">Por copista</span><span
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
                            class="pt gl">Copista {$hand} (manuscrito{
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
                            id="none{$hand}"
                            checked="checked"/>
                        <label
                            for="none{$hand}"><span
                                class="en">None</span>
                            <span
                                class="pt">Nenhuma</span><span class="gl">Ningunha</span></label>
                        <input
                            type="radio"
                            name="scribe[{$hand}]"
                            value="{$hand}"
                            id="{$hand}"
                            class="all"/>
                        <label class="corpus"
                            for="{$hand}"><span
                                class="pt gl">Todas</span>
                            <span
                                class="en">All</span> ({count($songs)})</label>
                        <input
                            type="radio"
                            name="scribe[{$hand}]"
                            class="show"
                            id="select{$hand}"/>
                        <label
                            for="select{$hand}"><span
                                class="pt gl">Sele<span class="gl">c</span>cionar</span>
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
                class="pt gl">Pesquisa</span><span
                class="en">Search</span></button>
    </form>
    )
