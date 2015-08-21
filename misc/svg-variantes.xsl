<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output indent="yes"/>    
    <xsl:variable name="barWidth" select="300"/>
    <xsl:variable name="barInterval" select="$barWidth + 10"/>
    <xsl:variable name="barHeight" select="30"/>
    <xsl:variable name="barShift" select="22"/>    
    <xsl:template match="/">
        <xsl:variable name="sumY"><xsl:value-of select="sum(//unique//y)"/></xsl:variable>
        <xsl:variable name="sumI"><xsl:value-of select="sum(//unique//i)"/></xsl:variable>
        <xsl:variable name="sumJ"><xsl:value-of select="sum(//unique//j)"/></xsl:variable>
        <!--<xsl:variable name="sumDypth" select="sum(//unique//*[@type='dypthong'])"/>
        <xsl:variable name="sumConso" select="sum(//unique//*[@type='consonant'])"/>
        <xsl:variable name="sumNucleus" select="sum(//unique//*[@type='nucleus'])"/>-->
        <xsl:variable name="SUM" select="//unique/sum(.//*)"/>
        <svg height="400">
            <g>
                <rect fill="none" height="{$barHeight}" width="{$sumY * $barShift}" y="5"  stroke="black"
                    stroke-width="2"/>
                <rect fill="none" height="{$barHeight}" width="{$sumI * $barShift}" y="35"  stroke="black"
                    stroke-width="2"/>
                <rect fill="none" height="{$barHeight}" width="{$sumJ * $barShift}" y="65"  stroke="black"
                    stroke-width="2"/>
                <text y="25" x="{$sumY * $barShift + 15}"><xsl:value-of select="$sumY * 100 div $SUM"/>%</text>
                <text y="55" x="{$sumI * $barShift + 15}"><xsl:value-of select="$sumI * 100 div $SUM"/>%</text>
                <text y="95" x="{$sumJ * $barShift + 15}"><xsl:value-of select="$sumJ * 100 div $SUM"/>%</text>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>