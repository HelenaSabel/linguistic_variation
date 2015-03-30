<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="div/@*">
        <xsl:attribute name="type"><xsl:value-of select="./@type"/></xsl:attribute>
        <xsl:attribute name="corresp"><xsl:value-of select="./@corresp"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="div">
        <xsl:element name="div">
            <xsl:element name="head">
                <xsl:element name="title">
                    <xsl:element name="app">
                        <xsl:element name="rdg">
                            <xsl:attribute name="wit">#A</xsl:attribute>
                            <xsl:attribute name="hand">#a</xsl:attribute>
                            <xsl:analyze-string select="string(./@corresp)" regex="#\w\d+">
                                <xsl:matching-substring>
                                    <xsl:message></xsl:message>
                                </xsl:matching-substring>
                            </xsl:analyze-string>                        
                        </xsl:element>
                        <xsl:element name="rdg">
                            <xsl:attribute name="wit">#B</xsl:attribute>
                            <xsl:attribute name="hand">#</xsl:attribute>
                            <xsl:analyze-string select="string(./@corresp)" regex="#\w\d+">
                                <xsl:non-matching-substring/>
                            </xsl:analyze-string>                        
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="name">
                    <xsl:attribute name="role">author</xsl:attribute>
                    <xsl:attribute name="ref">#</xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:copy-of select="//l"/>
            
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>