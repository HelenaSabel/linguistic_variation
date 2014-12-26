<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="poems" value="doc('../ancillary-files/biblList.xml')//tei:bibl/@xml:id"/>
    <pattern>
    <rule context="div[@type='poem']">
        <assert test="@corresp">This poem has no reference</assert>
        <assert test="if (@corresp) then substring(@corresp,2) = $poems else true()">The value
            of the @corresp attribute does not occur in the list of cantigas</assert>
    </rule>
    </pattern>
</schema>