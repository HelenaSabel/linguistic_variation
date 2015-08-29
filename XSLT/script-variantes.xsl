<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:variable name="ana">
            <xsl:apply-templates mode="ana"/>
        </xsl:variable>
        <xsl:apply-templates select="$ana" mode="correction"/>
    </xsl:template>
    <xsl:template match="node()|@*" mode="ana">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="ana"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()" mode="ana">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="app" mode="ana">
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
                    <xsl:if test="rdg[1][del]">
                        <xsl:text>#rev</xsl:text>
                    </xsl:if>
                    
                    <xsl:if test="rdg[1][add]">
                        <xsl:text>#rev</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'soff') and not(contains(rdg[2],'soff'))">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'uus') and contains(rdg[2],'os')">
                        <xsl:text>#vus</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'n') and contains(rdg[2],'nh')">
                        <xsl:text>#reg</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'll') and contains(rdg[2],'lh')">
                        <xsl:text>#reg</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1][@gap='error']">
                        <xsl:text>#error</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1][@gap='economy']">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1][@gap='damage']">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], '.')">
                        <xsl:text>#punct</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <xsl:sequence select="current()/rdg[1]/node()"/>
            </xsl:element>
            <xsl:if test="rdg[2]">
            <xsl:element name="rdg">
                <xsl:attribute name="wit">
                    <xsl:value-of select="current()/rdg[2]/@wit"/>
                </xsl:attribute>
                <xsl:attribute name="ana">
                    <xsl:if test="rdg[2][ex] and rdg[1][not(ex)]">
                        <xsl:text>#irreg</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[2][add]">
                        <xsl:text>#rev</xsl:text>
                    </xsl:if>                    
                    <xsl:if test="rdg[2][del]">
                        <xsl:text>#rev</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'mi') and contains(rdg[2], 'mh')">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'mj') and contains(rdg[2], 'mh')">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'ui') and contains(rdg[2], 'uj')">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[2], 'hu')">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'mi') and contains(rdg[2], 'mj')">
                        <xsl:text>#trend</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'me') and contains(rdg[2], 'mj')">
                        <xsl:text>#dat</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'lle') and contains(rdg[2], 'lhi')">
                        <xsl:text>#dat</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[2][@gap='error']">
                        <xsl:text>#error</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[2][@gap='economy']">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[2][@gap='damage']">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>                    
                </xsl:attribute>
                <xsl:sequence select="current()/rdg[2]/node()"/>
            </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="node()|@*" mode="correction">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="correction"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()" mode="correction">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="rdg/@*" mode="correction">
        <xsl:attribute name="wit">
            <xsl:value-of select="../@wit"/>
        </xsl:attribute>
        <xsl:if test="../@ana ne ''">
        <xsl:attribute name="ana">
            <xsl:choose>
                <xsl:when test="matches(../@ana,'\w#')">
                    <xsl:value-of select="replace(../@ana,'(\w)#', '$1 #')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../@ana"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
