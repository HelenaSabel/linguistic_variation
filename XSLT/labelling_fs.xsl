<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="fs/@*">
        <xsl:attribute name="xml:id">
            <xsl:value-of select="../@xml:id"/>
        </xsl:attribute>
        <xsl:if test="..[@feats]">
            <xsl:attribute name="feats">
                <xsl:value-of select="../@feats"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:attribute name="n">
            <xsl:value-of select="../comment()[1]"/>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
