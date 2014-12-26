<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:key name="idByContent" match="bibl" use="tokenize(.,',')"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="div/@corresp">
        <xsl:choose>
            <xsl:when test="key('idByContent',substring(current(),2))">
                <xsl:attribute name="corresp"
                    select="concat('#',key('idByContent',substring(current(),2))/@xml:id)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="corresp" select="current()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
