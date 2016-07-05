<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <pattern>
        <rule context="tei:fvLib//tei:fs">
            <let name="feature" value="//tei:fLib/tei:f/@xml:id"/>
            <let name="values"
                value="
                for $i in tokenize(@feats, '\s+')
                return
                substring-after($i, '#')"/>
            <assert
                test="if (@feats) then every $value in $values satisfies $value = $feature else true()"
                >Non-existent feature</assert>
        </rule>
    </pattern>
</schema>
