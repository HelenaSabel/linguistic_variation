<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="app">
        <xsl:variable name="Atokens" select="tokenize(rdg[@wit eq '#A'],'\s+')"/>
        <xsl:variable name="Btokens" select="tokenize(rdg[@wit eq '#B'],'\s+')"/>
        <xsl:variable name="count" select="max((count($Atokens),count($Btokens)))"/>
        <xsl:for-each select="1 to $count">
            <xsl:choose>
                <xsl:when test="$Atokens[current()] eq $Btokens[current()]">
                    <xsl:value-of select="concat(' ',$Atokens[current()],' ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <app>
                        <rdg wit="#A">
                            <xsl:choose>
                                <xsl:when test="$Atokens[current()]">
                                    <xsl:value-of select="$Atokens[current()]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gap/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdg>
                        <rdg wit="#B">
                            <xsl:choose>
                                <xsl:when test="$Btokens[current()]">
                                    <xsl:value-of select="$Btokens[current()]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gap/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdg>
                    </app>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
