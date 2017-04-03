<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="cantiga" select="collection('../edition')//div[@type eq 'poem']"/>
    <xsl:variable name="corresp" select="$cantiga/@corresp"/>
    <xsl:output method="text" indent="no"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//bibl"/>
    </xsl:template>
    <xsl:template match="bibl">
        <xsl:if test="concat('#', @xml:id) = $corresp">
            <xsl:apply-templates/>
            <xsl:text> &amp; </xsl:text>
            <xsl:value-of
                select="$cantiga[substring(@corresp, 2) = current()/@xml:id]//title//rdg[@wit eq '#A']/locus/@from"
            />
            <xsl:text> &amp; </xsl:text>
            <xsl:value-of
                select="$cantiga[substring(@corresp, 2) = current()/@xml:id]//title//rdg[@wit eq '#A']/substring(@hand, 2)"
            />
            <xsl:text> &amp; </xsl:text>
            <xsl:value-of
                select="$cantiga[substring(@corresp, 2) = current()/@xml:id]//title//rdg[@wit eq '#B']/locus/@from"
            />
            <xsl:text> &amp; </xsl:text>
            <xsl:value-of
                select="$cantiga[substring(@corresp, 2) = current()/@xml:id]//title//rdg[@wit eq '#B']/substring(@hand, 2)"
            />
            <xsl:text> &amp; </xsl:text>
            <xsl:value-of
                select="$cantiga[substring(@corresp, 2) = current()/@xml:id]//title//rdg[@wit eq '#V']/locus/@from"
            />
            <xsl:text>\\
            </xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
