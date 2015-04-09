<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="app">
        <xsl:element name="app">
            <xsl:element name="rdg">
                <xsl:attribute name="wit">
                    <xsl:value-of select="current()/rdg[1]/@wit"/>
                </xsl:attribute>
                <xsl:attribute name="ana">
                    <xsl:if test="rdg[1][ex] and rdg[2][not(ex)]">
                        <xsl:text>#irreg</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1][hi/@rend='guide']">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'ff') and not(contains(rdg[2],'ff'))">
                        <xsl:text>#irreg</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'uus') and contains(rdg[2],'os')">
                        <xsl:text>#irreg</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'n') and contains(rdg[2],'nh')">
                        <xsl:text>#reg</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'll') and contains(rdg[2],'lh')">
                        <xsl:text>#reg</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <xsl:sequence select="current()/rdg[1]/node()"/>
            </xsl:element>
            <xsl:element name="rdg">
                <xsl:attribute name="wit">
                    <xsl:value-of select="current()/rdg[2]/@wit"/>
                </xsl:attribute>
                <xsl:attribute name="ana">
                    <xsl:if test="rdg[2][ex] and rdg[1][not(ex)]">
                        <xsl:text>#irreg</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'mia') and contains(rdg[2], 'mha')">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'me') and contains(rdg[2], 'mj')">
                        <xsl:text>#dat</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'lle') and contains(rdg[2], 'lhi')">
                        <xsl:text>#dat</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <xsl:sequence select="current()/rdg[2]/node()"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
