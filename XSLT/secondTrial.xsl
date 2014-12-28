<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"></xsl:output>
    <xsl:variable name="bibl" select="//bibl"></xsl:variable>
    <xsl:template match="@*|node()">
        <xsl:apply-templates/>
    </xsl:template>
   <xsl:template match="div">
        <xsl:if test="substring(current()/@corresp,2) = tokenize($bibl,',')">
            <xsl:attribute name="corresp" select="concat('#',$bibl[tokenize(.,',') = substring(current(),2)]/@xml:id)"></xsl:attribute>            
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>