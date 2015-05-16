<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>   
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>    
    <xsl:template match="comment()">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="div[@type='poem']">
        <xsl:element name="div">
            <xsl:attribute name="type">
                <xsl:value-of select="current()/@type"/>
            </xsl:attribute>
            <xsl:attribute name="corresp">
                <xsl:value-of select="current()/@corresp"/>
            </xsl:attribute>
            <xsl:element name="head">
                <xsl:element name="title">
                    <xsl:element name="app">
                        <xsl:element name="rdg">                            
                            <xsl:attribute name="wit">
                                <xsl:analyze-string select="string(./@corresp)" regex="(#\w)d+\w\d+">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="regex-group(1)"/>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>
                            </xsl:attribute>
                            <xsl:attribute name="hand">#a</xsl:attribute>
                            <xsl:element name="idno">
                            <xsl:analyze-string select="string(./@corresp)" regex="#(\w\d+)(\w\d+)">
                                <xsl:matching-substring>
                                    <xsl:value-of select="regex-group(1)"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                            </xsl:element>
                            <xsl:element name="locus">
                                <xsl:attribute name="from"/>
                                <xsl:attribute name="to"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="rdg">
                            <xsl:attribute name="wit">
                                <xsl:analyze-string select="string(./@corresp)" regex="#\w\d+(\w)\d+">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="concat('#',regex-group(1))"/>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>
                            </xsl:attribute>
                            <xsl:attribute name="hand">#</xsl:attribute>
                            <xsl:element name="idno">
                            <xsl:analyze-string select="string(./@corresp)" regex="#(\w\d+)(\w\d+)">
                                <xsl:matching-substring>
                                    <xsl:value-of select="regex-group(2)"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                            </xsl:element>
                            <xsl:element name="locus">
                                <xsl:attribute name="from"/>
                                <xsl:attribute name="to"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="name">
                    <xsl:attribute name="role">author</xsl:attribute>
                    <xsl:attribute name="ref">#MartSrz</xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:copy-of select="current()//l"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
