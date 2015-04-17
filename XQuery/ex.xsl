<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ex">
        <xsl:text>&lt;span class="ex"&gt;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&lt;/span&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="seg">
        <xsl:text>&lt;span class="</xsl:text>
        <xsl:value-of select="current()/substring(@ana,2)"/>
        <xsl:text>"&gt;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&lt;/span&gt;</xsl:text>
    </xsl:template>
</xsl:stylesheet>