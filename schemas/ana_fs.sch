<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="featureFile" value="doc('../ancillary/feature-library.xml')"/>
    <let name="featureStructures"
        value="$featureFile//tei:fs/@xml:id | $featureFile//tei:fLib[@xml:id eq 'graphic']//tei:f/@xml:id"/>
    <let name="biblFile" value="doc('../ancillary/corpus-cantigas.xml')"/>
    <let name="poems" value="$biblFile//tei:bibl/@xml:id"/>
    <let name="personografia" value="doc('../ancillary/corpus-autores.xml')"/>
    <let name="poets" value="$personografia//tei:person/@xml:id"/>
    <pattern>
        <rule context="tei:l">
            <assert test="parent::tei:lg">All lines must be inside a cobra</assert>
        </rule>
        <rule context="tei:l[@type]">
            <report test="@type ne 'refrao'">Only possible line type is “refrao”</report>
        </rule>
        <rule context="tei:lg">
            <assert test="@type = ('cobra', 'finda')">Is this a “cobra” or a “finda“?</assert>
        </rule>
        <rule context="tei:l/tei:app">
            <let name="anas"
                value="tokenize(replace(replace(replace(replace(replace(string-join(.//@ana, ' '), '\s?#rev\s?', ''), '\s?#equip\s?', ''), '\s?#error\s?', ''), '\s?#abb\s?', ''), '\s?#apocope\s?', ''), '\s+')"/>
            <let name="segs" value="string-join(./descendant::tei:seg/@corresp, ' ')"/>
            <assert
                test="
                    if (not(descendant::tei:choice) and count($anas) gt 1 and not(descendant::*[@cert])) then
                        count($anas) &lt;= ./count(tokenize($segs, '\s+')) - count(descendant::tei:seg[@corresp eq '#error']) + count(descendant::tei:gap)
                    else
                        true()"
                >Need to segmentate</assert>
            <!--<assert
                test="
                    if (.//tei:choice and count($anas) gt 1) then
                        count($anas) eq ((count(.//tei:choice//tei:seg) div 2) + count(descendant::*[not(self::tei:choice)]//tei:seg) + count(.//tei:gap[@reason = ('error', 'damage')]))
                    else
                        true()"
                >Need to segmentate</assert>-->
            <assert
                test="
                    if (descendant::tei:choice and count($anas) gt 1 and not(descendant::*[@cert])) then
                        count($anas) &lt;= (count(descendant::tei:seg[ancestor::tei:choice]) div 2) + count(descendant::tei:seg[parent::tei:rdg]) + count(descendant::tei:gap)
                    else
                        true()"
                >Need to segmentate</assert>
            <assert
                test="
                    if (not(descendant::tei:choice) and count(tei:rdg) gt 1) then
                        count(tei:rdg[@ana]) gt 0
                    else
                        true()"
                >Missing @ana</assert>
            <assert
                test="
                    if (not(descendant::tei:choice) and count(tei:rdg) gt 2 and not(tei:rdg[@wit eq '#A'][@ana eq '#material'])) then
                        count(tei:rdg[@ana]) gt 1
                    else
                        true()"
                >Missing @ana</assert>
        </rule>
        <rule context="tei:rdg">
            <let name="values"
                value="
                    for $i in tokenize(@ana, '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    if (@ana) then
                        every $value in $values
                            satisfies $value = $featureStructures
                    else
                        true()"
                >The value of the attribute is not listed</assert>
            <assert test="@wit">It is mandatory to specify the witness</assert>
            <report test="tei:app">Wrong nesting of elements</report>
        </rule>
        <rule context="tei:seg">
            <assert test="@corresp"
                >Every seg must have a @corresp attribute with its FS
                code</assert>
            <assert
                test="
                    every $corresp in tokenize(./@corresp, '\s+')
                        satisfies $corresp = ancestor::tei:rdg/tokenize(@ana, '\s+')"
                >Value not present in
                the rdg container</assert>
        </rule>
        <rule context="tei:div[@type = 'poem']">
            <assert test="@corresp">This poem has no reference</assert>
            <assert
                test="
                    if (@corresp) then
                        substring(@corresp, 2) = $poems
                    else
                        true()"
                >The value of the @corresp attribute does not occur in the list of cantigas</assert>
            <assert test="tei:head[tei:title/tei:app/count(tei:rdg) gt 1][tei:name]"
                >Missing
                element. Every poem must have a head element with a title an a name. Head must
                contain an app element with the readings</assert>
        </rule>
        <rule context="tei:name[@role = 'author']">
            <assert test="@ref">Author code missing</assert>
            <assert
                test="
                    if (@ref) then
                        substring(@ref, 2) = $poets
                    else
                        true()"
                >Wrong author code</assert>
        </rule>
        <rule context="tei:gap">
            <let name="reasons"
                value="('error', 'damage', 'economy', 'unfinished', 'illegible', 'model', 'unknown')"/>
            <assert test="./@reason = $reasons"
                > "error," "economy," "damage," "unfinished,"
                "model," or "illegible" are the only permitted values of @reason on the gap element
            </assert>
        </rule>
        <rule context="tei:add">
            <let name="places" value="('above', 'margin', 'overwrite', 'inline')"/>
            <assert test="@place = $places"
                >Additions must express the place the added text was
                located (possible values: “above”, “margin” or “overwrite”</assert>
        </rule>
        <rule context="tei:del">
            <let name="values"
                value="('overstrike', 'underdot', 'scrape', 'overwrite', 'multiple-overstrike')"/>
            <let name="renditions"
                value="
                    for $i in tokenize(@rend, '\s+')
                    return
                        $i"/>
            <assert test="@rend">Missing @rend</assert>
            <assert
                test="
                    every $rendition in $renditions
                        satisfies $values = $rendition"
                >A @rend must express how the deletion was made(possible values: “overstrike”,
                “underdot”, ”scrape”, “multiple-overstrike“ or “overwrite”</assert>
        </rule>
        <rule context="tei:choice">
            <assert
                test="
                    if (tei:orig//tei:ex) then
                        tei:reg//tei:ex
                    else
                        true()"
                >Check for consistency</assert>
            <assert
                test="
                    if (tei:reg//tei:ex) then
                        tei:orig//tei:ex
                    else
                        true()"
                >Check for consistency</assert>
            <assert
                test="
                    if (tei:orig//tei:hi) then
                        tei:reg//tei:hi
                    else
                        true()"
                >Check for consistency</assert>
        </rule>
        <rule context="tei:ex[not(following-sibling::tei:am[1][. eq '̅'])]"> </rule>
        <rule context="tei:am">
            <assert test="./text()">Empty am</assert>
            <assert test=".[not(. eq '̅')]/following-sibling::*[1][self::tei:ex]"
                >All abreviations need to specify their abbreviation mark.</assert>
        </rule>
    </pattern>
</schema>
