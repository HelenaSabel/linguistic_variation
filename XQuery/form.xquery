xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $anas := $songs//tei:rdg/@ana
let $ana := distinct-values(for $values in $anas
return
    tokenize($values, '\s+'))
let $ling-features := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#linguistic']/tei:fs[concat('#', @xml:id) = $ana]
let $phonetic := $ling-features[tei:f/tei:fs[not(@n)][some $i in tokenize(@feats, '\s+')
    satisfies $i = ('#vowel', '#cons', '#nasal', '#sibil', '#diphthong', '#pal')]]
let $morph := $ling-features[tei:f/tei:fs[not(@n)][some $i in tokenize(@feats, '\s+')
    satisfies $i = ('#past', '#pr', '#det')]]
let $other := $ling-features[tei:f/tei:fs[not(@n)][not(some $i in tokenize(@feats, '\s+')
    satisfies $i = ('#past', '#pr', '#det', '#vowel', '#cons', '#nasal', '#sibil', '#diphthong', '#pal'))]]
let $scribalError := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#scribal']/tei:fs[concat('#', @xml:id) = $ana]


return
    
    (<form
        class="lingua pt"
        method='GET'
        action='results.php'>
        <fieldset>
            <legend><span
                    class="pt">Fenómenos fonéticos</span></legend>
            
            {
                for $id in $phonetic
                let $name := $id//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <fieldset>
            <legend><span
                    class="pt">Princiapais fenómenos morfológicos</span></legend>
            
            {
                for $id in $morph
                let $name := $id//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <fieldset>
            <legend><span
                    class="pt">Outros fenómenos</span></legend>
            
            {
                for $id in $other
                let $name := $id//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="pt">Pesquisa</span></button>
    </form>,
    <form
        class="lingua en"
        method='GET'
        action='results.php'>
        <fieldset>
            <legend><span
                    class="en">Phonetic phenomena</span></legend>
            
            {
                for $id in $phonetic
                let $name := $id//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <fieldset>
            <legend><span
                    class="en">Main morphological phenomena</span></legend>
            
            {
                for $id in $morph
                let $name := $id//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <fieldset>
            <legend><span
                    class="en">Other phenomena</span></legend>
            
            {
                for $id in $other
                let $name := $id//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="en">Search</span></button>
    </form>,
    <h2><span
            class="pt">Erros de cópia</span><span>Scribal errors</span></h2>,
    <form
        action='results.php'
        method='GET'
        class="pt lingua">
        <fieldset>
            {
                for $error in $scribalError
                let $name := $error//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="error[]"
                        value="{$error/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="pt">Pesquisa</span></button>
    </form>,
    <form
        method='GET'
        action='results.php'
        class="en lingua">
        <fieldset>
            {
                for $error in $scribalError
                let $name := $error//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="error[]"
                        value="{$error/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="en">Search</span></button>
    </form>
    )
