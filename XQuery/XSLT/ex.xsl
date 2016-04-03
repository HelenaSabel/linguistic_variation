<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no"
        omit-xml-declaration="yes"/>
    <xsl:param name="rdg"/>
    <xsl:param name="ana"/>
    <xsl:template match="tei:app">
        <xsl:apply-templates select="tei:rdg[. = $rdg]" mode="init"/>
    </xsl:template>
    <xsl:template match="tei:rdg" mode="init">
        <xsl:apply-templates/>
        <xsl:text>] </xsl:text>
        <xsl:apply-templates select="../tei:rdg[@wit ne current()/@wit][not(contains(@ana, $ana))][1]" mode="second"/>
        <xsl:if test="../count(tei:rdg[not(contains(@ana, $ana))]) eq 2">
            <xsl:text> // </xsl:text>
            <xsl:apply-templates select="../tei:rdg[@wit ne current()/@wit][not(contains(@ana, $ana))][2]" mode="second"/>
        </xsl:if>
        <xsl:if test="../count(tei:rdg) eq 1">
            <xsl:text>--</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:choice">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:reg"/>
    <xsl:template match="tei:ex"/>
    <xsl:template match="tei:supplied"/>
    <xsl:template match="tei:gap">
        <xsl:text>--</xsl:text>
    </xsl:template>
    <xsl:template match="tei:del">
        <xsl:value-of select="concat('(', ., ')')"/>
    </xsl:template>
    <xsl:template match="tei:add">
        <xsl:value-of select="concat('\', ., '/')"/>
    </xsl:template>
    <xsl:template match="tei:rdg" mode="second">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
