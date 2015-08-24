<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output indent="yes"/>
    <xsl:variable name="barHeight" select="30"/>
    <xsl:variable name="barShift" select="10"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//total"/>
    </xsl:template>
    <xsl:template match="total">
        <xsl:variable name="sumY">
            <xsl:value-of select="sum(.//y)"/>
        </xsl:variable>
        <xsl:variable name="sumI">
            <xsl:value-of select="sum(.//i)"/>
        </xsl:variable>
        <xsl:variable name="sumJ">
            <xsl:value-of select="sum(.//j)"/>
        </xsl:variable>
        <!--<xsl:variable name="sumDypth" select="sum(//unique//*[@type='dypthong'])"/>
        <xsl:variable name="sumConso" select="sum(//unique//*[@type='consonant'])"/>
        <xsl:variable name="sumNucleus" select="sum(//unique//*[@type='nucleus'])"/>-->
        <xsl:variable name="SUM" select="sum(.//*)"/>
        <svg height="500">
            <g>
                <rect fill="none" height="{$barHeight}" width="{$sumY * $barShift}" y="5" x="20"
                    stroke="black" stroke-width="2"/>
                <rect fill="#0D3955" height="{$barHeight}" width="{y[@type='dypthong'] * $barShift}"
                    y="5" x="20"/>
                <text fill="white" font-size="small" y="25"
                    x="{5 + y[@type='dypthong'] * $barShift div 2}">
                    <xsl:value-of
                        select="round-half-to-even(y[@type = 'dypthong'] * 100 div $sumY, 1)"/>
                </text>
                <rect fill="darkred" height="{$barHeight}"
                    width="{number(y[@type='nucleus']) * $barShift}" y="5"
                    x="{20 + (number(y[@type='dypthong'])  * $barShift)}" stroke="black"
                    stroke-width="1"/>
                <text fill="white" font-size="small" y="25"
                    x="{(number(y[@type='nucleus']) * $barShift div 2) + (number(y[@type='dypthong']) * $barShift) + 3}">
                    <xsl:value-of
                        select="round-half-to-even(number(y[@type = 'nucleus']) * 100 div $sumY, 1)"
                    /></text>
                <rect fill="none" height="{$barHeight}" width="{$sumI * $barShift}" y="35"
                    stroke="black" stroke-width="2" x="20"/>
                <rect fill="#0D3955" height="{$barHeight}"
                    width="{number(i[@type='dypthong']) * $barShift}" y="35" x="20" stroke="black"
                    stroke-width="1"/>
                <text fill="white" font-size="small" y="55"
                    x="{3 + number(i[@type='dypthong']) * $barShift div 2}">
                    <xsl:value-of
                        select="round-half-to-even(i[@type = 'dypthong'] * 100 div $sumI, 1)"/>
                </text>
                <rect fill="darkred" height="{$barHeight}"
                    width="{number(i[@type='nucleus']) * $barShift}" y="35"
                    x="{20 + (number(i[@type='dypthong'])  * $barShift)}" stroke="black"
                    stroke-width="1"/>
                <text fill="white" font-size="small" y="55"
                    x="{(number(i[@type='nucleus']) * $barShift div 2) + (number(i[@type='dypthong']) * $barShift) + 3}">
                    <xsl:value-of
                        select="round-half-to-even(number(i[@type = 'nucleus']) * 100 div $sumI, 1)"
                    />
                </text>
                <rect fill="#033B13" height="{$barHeight}"
                    width="{number(i[@type='consonant']) * $barShift}" y="35"
                    x="{20 + number(i[@type='dypthong']) * $barShift + (number(i[@type='nucleus'])  * $barShift)}"
                    stroke="black" stroke-width="1"/>
                <text fill="white" font-size="small" y="55"
                    x="{10 + number(i[@type='dypthong']) * $barShift + (number(i[@type='nucleus'])  * $barShift) + (number(i[@type='consonant']) * $barShift div 2)}">
                    <xsl:value-of
                        select="round-half-to-even(number(i[@type = 'consonant']) * 100 div $sumI, 1)"
                    />
                </text>
                <rect fill="none" height="{$barHeight}" width="{$sumJ * $barShift}" y="65"
                    stroke="black" stroke-width="2" x="20"/>
                <rect fill="#0D3955" height="{$barHeight}"
                    width="{number(j[@type='dypthong']) * $barShift}" y="65" x="20" stroke="black"
                    stroke-width="1"/>
                <text fill="white" font-size="small" y="85"
                    x="20">
                    <xsl:value-of
                        select="round-half-to-even(j[@type = 'dypthong'] * 100 div $sumJ, 1)"/>
                </text>
                <rect fill="darkred" height="{$barHeight}"
                    width="{number(j[@type='nucleus']) * $barShift}" y="65"
                    x="{20 + number(j[@type='dypthong']) * $barShift}" stroke="black"
                    stroke-width="1"/>
                <text fill="white" font-size="small" y="85"
                    x="{(number(j[@type='dypthong']) * $barShift) + (number(j[@type='nucleus']) * $barShift div 2)}">
                    <xsl:value-of
                        select="round-half-to-even(number(j[@type = 'nucleus']) * 100 div $sumJ, 1)"
                    />
                </text>
                <text x="2" y="25" font-size="large">y</text>
                <text y="25" x="{$sumY * $barShift + 25}"><xsl:value-of
                    select="round-half-to-even($sumY * 100 div $SUM, 2)"/>%</text>
                <text x="2" y="55" font-size="large">i</text>
                <text y="55" x="{$sumI * $barShift + 25}"><xsl:value-of
                    select="round-half-to-even($sumI * 100 div $SUM, 2)"/>%</text>
                <text x="2" y="85" font-size="large">j</text>
                <text y="85" x="{$sumJ * $barShift + 25}"><xsl:value-of
                    select="round-half-to-even($sumJ * 100 div $SUM, 2)"/>%</text>
            </g>
            <g>
                <rect y="14" x="670" width="15" height="15" fill="#0D3955" stroke="black"
                    stroke-width="1"/>
                <text y="25" x="692" font-size="small">dypthong</text>
                <rect y="44" x="670" width="15" height="15" fill="darkred" stroke="black"
                    stroke-width="1"/>
                <text y="55" x="692" font-size="small">stable vowel</text>
                <rect y="74" x="670" width="15" height="15" fill="#033B13" stroke="black"
                    stroke-width="1"/>
                <text y="85" x="692" font-size="small">consonant</text>
                
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
