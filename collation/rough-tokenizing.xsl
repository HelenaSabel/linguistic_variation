<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:heb="iberian.obdurodon.org"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:function name="heb:matches" as="xs:string*">
        <xsl:param name="A" as="node()"/>
        <xsl:param name="B" as="node()"/>
        <xsl:variable name="ATokens" select="tokenize($A,'\s+')" as="xs:string+"/>
        <xsl:variable name="BTokens" select="tokenize($B,'\s+')" as="xs:string+"/>
        <xsl:for-each select="1 to count($ATokens)">
            <xsl:if test="$ATokens[current()] = $BTokens[current()]">
                <xsl:value-of select="$ATokens[current()]"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    <xsl:function name="heb:app" as="node()*">
        <xsl:param name="A" as="node()"/>
        <xsl:param name="B" as="node()"/>
        <xsl:variable name="ATokens" select="tokenize($A,'\s+')"/>
        <xsl:variable name="BTokens" select="tokenize($B,'\s+')"/>
        <xsl:for-each select="1 to count($ATokens)">
            <xsl:if test="$ATokens[current()] != $BTokens[current()]">
                <xsl:element name="app">
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#A</xsl:attribute>
                    <xsl:value-of select="$ATokens[current()]"/>
                </xsl:element>
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#B</xsl:attribute>
                    <xsl:value-of select="$BTokens[current()]"/>
                </xsl:element>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
<xsl:template match="div">
    <xsl:element name="div">
        <xsl:attribute name="type">poem</xsl:attribute>
        <xsl:attribute name="corresp">
            <xsl:value-of select="current()/@corresp"/>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>    
    <xsl:template match="l">
        <xsl:element name="l">
            <xsl:attribute name="n">
                <xsl:value-of select="count(preceding-sibling::l)+1"/>
            </xsl:attribute>
        <xsl:apply-templates select="app"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="app">
        <xsl:value-of select="heb:matches(rdg[@wit='#A'], rdg[@wit='#B'])"/>
        <xsl:sequence select="heb:app(rdg[@wit='#A'],rdg[@wit='#B'])"/>
    </xsl:template>
</xsl:stylesheet>