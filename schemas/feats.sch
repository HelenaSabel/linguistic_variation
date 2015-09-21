<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <pattern>
        <rule context="tei:fs">
            <assert
                test="if (@feats) then tokenize(replace(@feats, '#', ''), '\s+') = preceding::tei:fLib[@n = current()/../@n]//tei:f/@xml:id else true()"
                >Non-existent feature</assert>
        </rule>
    </pattern>
</schema>
