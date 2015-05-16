<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:template match="tei:ex">
        <xsl:element name="span">
            <xsl:attribute name="class">ex</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:seg">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:value-of select="current()/substring(@ana, 2)"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
