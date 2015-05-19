<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
<!--    <xsl:template match="tei:l">
        <xsl:choose>
            <xsl:when test="tei:rdg[contains(.,$searchphrase)]">
                <xsl:apply-templates select="not(tei:rdg/@wit ne tei:rdg[contains(.,$searchphrase)]/@wit)"/>
            </xsl:when>            
            <xsl:when test="tei:rdg[not(contains(.,$searchphrase))]">
                <xsl:apply-templates select="current()//*[not(tei:rdg[2])]"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>-->
    <xsl:template match="tei:choice">
        <span class="reg">
            <xsl:attribute name="data-ana">Disposição original: <em><xsl:apply-templates
                select="tei:orig"/></em></xsl:attribute>
            <xsl:apply-templates select="tei:reg"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:ex">
        <span class="abbr">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>