<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:pattern>
        <sch:rule context="tei:fvLib/tei:fs">
            <sch:assert test="@xml:id">ID required</sch:assert>
            <sch:assert test="tei:f[@name eq 'description']">Required f[@name eq 'description']/string with prose
            description of the phenomenon</sch:assert>
            <sch:assert test="tei:f[@name eq 'taxonomy']">Required f[@name eq 'taxonomy']</sch:assert>
        </sch:rule>
        <sch:rule context="tei:f[@name eq 'description'][ancestor::tei:fvLib]">
            <sch:assert test="count(tei:string) = 3">Required f[@name eq 'description']/string with prose
                description of the phenomenon in the three languages</sch:assert>
            <sch:assert test="count(distinct-values(tei:string/@xml:lang)) = 3">Required f[@name eq 'description']/string with prose
                description of the phenomenon in the three languages</sch:assert>
        </sch:rule>
        <sch:rule context="tei:f[@name eq 'taxonomy'][ancestor::tei:fvLib]">
            <sch:assert test="tei:fs[@type = ('linguistic', 'error', 'material', 'equipolent', 'graphic')]">Incorrect type</sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'linguistic'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'category']/tei:fs[@type = ('phonetic', 'morphosyntatic', 'language-transfer', 'lexical')]">If 'linguistic', categories are 'phonetic', 'morphosintatic', 'language-transfer', 'lexical'</sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'phonetic'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'process'][./tei:symbol[@value = ('addition', 'reduction')] or ./tei:fs[@type eq 'alteration']]">process</sch:assert>
            <sch:assert test="tei:f[@name eq 'position']/tei:symbol[@value = ('start', 'end', 'intern', 'intervocalic', 'interconsonantic')]">position</sch:assert>
            <sch:assert test="tei:f[@name eq 'constriction']/tei:binary">constriction</sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'alteration'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'type'][./tei:symbol[@value = ('lenition', 'fortition', 'metathesis', 'dissimilation', 'analogy')] or ./tei:fs[@type eq 'assimilation']]"></sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'assimilation'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'direction']/tei:symbol[@value = ('adjacent', 'long-distance', 'regressive', 'progressive')]"></sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'morphosyntatic'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'POS']
                [./tei:symbol[@value = ('N', 'DET', 'CONJ', 'PREP', 'ADV')] or ./tei:fs[@type = ('VB', 'PR')]]"></sch:assert>
            <sch:assert test="tei:f[@name eq 'process']/tei:symbol[@value = ('stem', 'inflection', 'analogy')]"></sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'VB'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'stem-tense']/tei:symbol[@value = ('present', 'past')]"></sch:assert>
            <sch:assert test="tei:f[@name eq 'agreement']/tei:fs[@type eq 'concord']"></sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'concord'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'PERS']/tei:symbol[@value = ('1', '2', '3')]"></sch:assert>
            <sch:assert test="tei:f[@name eq 'NUM']/tei:symbol[@value = ('sg', 'pl')]"></sch:assert>
        </sch:rule>
        <sch:rule context="tei:fs[@type eq 'PR'][ancestor::tei:fvLib]">
            <sch:assert test="tei:f[@name eq 'agreement']"></sch:assert>
        </sch:rule>
        
        
        
        
        
        
        
        
        
    </sch:pattern>
</sch:schema>