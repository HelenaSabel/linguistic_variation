xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xhtml";
declare option output:indent "yes";
declare option output:encoding "UTF-8";
let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $anas := $songs//tei:rdg/@ana
let $ana := distinct-values(for $values in $anas
return
    tokenize($values, '\s+'))
let $file := doc('/db/VTLGP/ancillary/feature-library.xml')
let $ling-features := $file//tei:fvLib/tei:fs[concat('#', @xml:id) = $ana]
let $phonetic := $ling-features[.//tei:fs[@type eq 'phonetic']]
let $morph := $ling-features[.//tei:fs[@type eq 'morphosyntactic']/tei:f[@name eq 'POS']/tei:fs]
let $other := $ling-features[.//tei:fs[@type eq 'morphosyntactic']/tei:f[@name eq 'POS']/tei:symbol]

return
    
    (<div
        class="pt">
        <form
            class="lingua"
            method='GET'
            action='results.php'>
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
                            id="{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            </fieldset>
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
                            id="{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
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
                            id="{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            </fieldset>
            <button
                class="submit"
                type="submit"><span
                    class="pt">Pesquisa</span></button>
        </form></div>,
    <div
        class="gl">
        <form
            class="lingua"
            method='GET'
            action='results.php'>
            <fieldset>
                <legend>Principais fenómenos morfolóxicos</legend>
                
                {
                    for $id in $morph
                    let $name := $id//tei:string[@xml:lang eq 'gl']/text()
                    order by $name
                    return
                        (<input
                            type="checkbox"
                            name="phenomenon[]"
                            id="gl{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="gl{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            </fieldset>
            <fieldset>
                <legend>Fenómenos fonéticos</legend>
                
                {
                    for $id in $phonetic
                    let $name := $id//tei:string[@xml:lang eq 'gl']/text()
                    order by $name
                    return
                        (<input
                            type="checkbox"
                            name="phenomenon[]"
                            id="gl{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="gl{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            </fieldset>
            <fieldset>
                <legend>Outros fenómenos</legend>
                
                {
                    for $id in $other
                    let $name := $id//tei:string[@xml:lang eq 'gl']/text()
                    order by $name
                    return
                        (<input
                            type="checkbox"
                            name="phenomenon[]"
                            id="gl{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="gl{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            
            </fieldset>
            <button
                class="submit"
                type="submit"><span
                    class="gl">Pesquisa</span></button>
        </form></div>,
    <div
        class="en">
        <form
            class="lingua"
            method='GET'
            action='results.php'>
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
                            id="en{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="en{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            </fieldset>
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
                            id="en{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="en{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
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
                            id="en{$id/@xml:id}"
                            value="{$id/@xml:id}"/>,
                        <label
                            for="en{$id/@xml:id}">{transform:transform($name, 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</label>, <br/>)
                }
            </fieldset>
            <button
                class="submit"
                type="submit"><span
                    class="en">Search</span></button>
        </form></div>
    
    )
