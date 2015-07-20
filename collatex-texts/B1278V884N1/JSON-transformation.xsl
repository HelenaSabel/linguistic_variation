<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text"/>
    <xsl:template match="poem[@xml:id = 'B']">
        <xsl:for-each select="l">
        <xsl:variable name="currentPosition" select="position()" as="xs:integer"/>
        <xsl:result-document href="{$currentPosition}.json"> 
            {"witnesses": [ 
            { "id": "B", 
            "tokens": [<xsl:apply-templates select="current()"/>]},
            {"id": "V", "tokens": [<xsl:apply-templates select="../..//poem[@xml:id = 'V']//l[position() = $currentPosition]"/>]},
            {"id": "N", "tokens": [<xsl:apply-templates select="../..//poem[@xml:id = 'N']//l[position() = $currentPosition]"/>]} 
            ]} 
        </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="l">
            <xsl:variable name="tokens" select="tokenize(., '\s')"/>
            <xsl:variable name="count" select="count($tokens)"/>
                <xsl:for-each select="1 to $count">
                    <xsl:text>{"t" : "</xsl:text>
                    <xsl:value-of select="$tokens[current()]"/>
                    <xsl:text>"}</xsl:text>
                    <xsl:if test="current() lt $count">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>        
    </xsl:template>
</xsl:stylesheet>
