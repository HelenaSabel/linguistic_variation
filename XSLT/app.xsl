<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="B" select="document('../BV.xml')//div[@wit='#B']"/>
    <xsl:template match="/">
        <xsl:element name="tei">
            <xsl:apply-templates select="//div[@corresp = $B/@corresp]"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div">
        <xsl:element name="div">
            <xsl:attribute name="type">poem</xsl:attribute>
            <xsl:attribute name="corresp" select="current()/@corresp"/> 
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l">
        <xsl:element name="l">
            <xsl:attribute name="n" select="count(preceding-sibling::l)+1"/>
            <xsl:element name="app">
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#A</xsl:attribute>
                    <xsl:copy-of select="current()/node()"/>
                </xsl:element>
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#B</xsl:attribute>
                    <xsl:sequence
                        select="$B[@corresp = current()/parent::*/@corresp]//l[@n = current()/@n]"
                    />
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
