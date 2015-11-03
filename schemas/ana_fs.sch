<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="featureFile" value="doc('../ancillary-files/feature_library.xml')"/>
    <let name="featureStructures" value="$featureFile//tei:fs/@xml:id"/>
    <let name="biblFile" value="doc('../ancillary-files/biblList.xml')"/>
    <let name="poems" value="$biblFile//tei:bibl/@xml:id"/>
    <let name="personografia" value="doc('../ancillary-files/corpus_autores.xml')"/>
    <let name="poets" value="$personografia//tei:person/@xml:id"/>
   <pattern>
        <rule context="tei:l/tei:app[not(.//tei:choice)][count(tei:rdg) gt 1]">
            <assert test="count(tei:rdg[@ana]) gt 0">Missing @ana</assert>
        </rule>
        <rule context="tei:l/tei:app[not(.//tei:choice)][count(tei:rdg) gt 2]">
            <assert test="count(tei:rdg[@ana]) gt 1">Missing @ana</assert>
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
            <assert test="tei:head[tei:title/tei:app/count(tei:rdg) gt 1][tei:name]">Missing
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
            <assert
                test=".[@reason = 'error'] | .[@reason = 'economy'] | .[@reason = 'unfinished'] | .[@reason = 'damage'] | .[@reason = 'illegible'] | .[@reason = 'model']"
                > "error," "economy," "damage," "unfinished," "model," or "illegible" are the only
                permitted values of @reason on the gap element </assert>
        </rule>
        <rule context="tei:add">
            <let name="values" value="tokenize('above margin overwrite inline', ' ')"/>
            <assert test="@place = $values">Additions must express the place the added text was located (possible values:
                “above”, “margin” or “overwrite”</assert>
        </rule>
        <rule context="tei:del">
            <let name="values" value="for $i in tokenize('overstrike underdot scrape overwrite double-overstrike', ' ') return $i"/>
            <let name="renditions" value="for $i in tokenize(@rend, '\s+') return $i"/>
            <assert test="@rend">Missing @rend</assert>
            <assert test="every $rendition in $renditions satisfies $values = $rendition">A @rend must express how the deletion was made(possible values:
                “overstrike”, “underdot”, ”scrape” or “overwrite”</assert>
        </rule>
    </pattern>
</schema>
