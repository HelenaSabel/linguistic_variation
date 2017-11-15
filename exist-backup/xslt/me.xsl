<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="text" encoding="utf-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:template match="tei:app">
        <xsl:apply-templates select="tei:rdg[not(contains(@ana, 'dat'))][matches(., '[^\w][mM]e[^\w]') or (tei:supplied[preceding-sibling::node()[1][matches(., '[^\w][mM]$')]]) or (matches(., '[^\w][mM]e$')) or (matches(., '^[mM]e$'))             or (matches(., '^[mM]e[^\w]'))]"/>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::tei:rdg[not(contains(@ana, 'dat'))][matches(., '[^\w][mM]e[^\w]') or              (tei:supplied[preceding-sibling::node()[1][matches(., '[^\w][mM]$')]]) or (matches(., '[^\w][mM]e$')) or (matches(., '^[mM]e$')) or (matches(., '^[mM]e[^\w]'))]">
            <xsl:text> / </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:choice">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:seg[@corersp]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:reg"/>
    <xsl:template match="tei:ex"/>
    <xsl:template match="tei:supplied"/>
    <xsl:template match="tei:del">
        <xsl:value-of select="concat('(', ., ')')"/>
    </xsl:template>
    <xsl:template match="tei:add">
        <xsl:value-of select="concat('\', ., '/')"/>
    </xsl:template>
</xsl:stylesheet>