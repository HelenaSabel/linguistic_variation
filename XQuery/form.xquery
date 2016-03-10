xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $anas := $songs//tei:rdg/@ana
let $ana := distinct-values(for $values in $anas
return
    tokenize($values, '\s+'))
let $ling-features := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#linguistic']/tei:fs[concat('#', @xml:id) = $ana]
let $phonetic := $ling-features[tei:f/tei:fs[not(@n)][some $i in tokenize(@feats,'\s+') satisfies $i = ('#vowel', '#cons', '#nasal', '#sibil', '#diphthong', '#pal')]]
let $morph := $ling-features[tei:f/tei:fs[not(@n)][some $i in tokenize(@feats,'\s+') satisfies $i = ('#past', '#pr', '#det')]]
let $other := $ling-features[tei:f/tei:fs[not(@n)][not(some $i in tokenize(@feats,'\s+') satisfies $i = ('#past', '#pr', '#det', '#vowel', '#cons', '#nasal', '#sibil', '#diphthong', '#pal'))]]
let $scribalError := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#scribal']/tei:fs[concat('#', @xml:id) = $ana]
let $equipolent := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib[@n eq 'equipolent readings']/tei:fs[concat('#', @xml:id) = $ana]


return
    
    (<form
        class="lingua pt"
        method='GET'
        action='results.php'>
        <fieldset>
            <legend>Fenómenos fonéticos</legend>
            
            {
                for $id in $phonetic
                let $name := $id//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ()), <br/>)
            }
        </fieldset>
        <fieldset>
            <legend>Principais fenómenos morfológicos</legend>
            
            {
                for $id in $morph
                let $name := $id//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ()), <br/>)
            }
        </fieldset>
        <fieldset>
            <legend>Outros fenómenos</legend>
            
            {
                for $id in $other
                let $name := $id//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ()), <br/>)
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
            <legend>Phonetic phenomena</legend>
            
            {
                for $id in $phonetic
                let $name := $id//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ()), <br/>)
            }
        </fieldset>
        <fieldset>
            <legend>Main morphological phenomena</legend>
            
            {
                for $id in $morph
                let $name := $id//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ()), <br/>)
            }
        </fieldset>
        <fieldset>
            <legend>Other phenomena</legend>
            
            {
                for $id in $other
                let $name := $id//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="phenomenon[]"
                        value="{$id/@xml:id}"/>, transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ()), <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="en">Search</span></button>
    </form>,
    <h2 id="error"><span
            class="pt">Erros de cópia</span><span class="en">Scribal errors</span></h2>,
    <form
    action='results-sc.php'
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
    action='results-sc.php'
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
    </form>,
    <h2 id="other"><span class="pt">Outras variantes</span><span class="en">Other variants</span></h2>,
     <form
    action='results-eq.php'
    method='GET'
        class="pt lingua">
        <fieldset>
            {
                for $equip in $equipolent
                let $name := $equip//tei:string[@xml:lang eq 'pt']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="equip[]"
                        value="{$equip/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="pt">Pesquisa</span></button>
    </form>,
    <form
    method='GET'
    action='results-eq.php'
        class="en lingua">
        <fieldset>
            {
                for $equip in $equipolent
                let $name := $equip//tei:string[@xml:lang eq 'en']/text()
                order by $name
                return
                    (<input
                        type="checkbox"
                        name="equip[]"
                        value="{$equip/@xml:id}"/>, $name, <br/>)
            }
        </fieldset>
        <button
            class="submit"
            type="submit"><span
                class="en">Search</span></button>
    </form>
    
    )
