<?xml version="1.0" encoding="UTF-8"?>

<!--    Code written by David J. Birnbaum, www.obdurodon.org -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="l">
        <l n="{@n}">
            <xsl:for-each-group select="app"
                group-adjacent="
                if (rdg/@wit = '#A #B') then
                0
                else
                position()">
                <xsl:apply-templates select="."/>
            </xsl:for-each-group>
        </l>
    </xsl:template>
    <xsl:template match="app[not(parent::title)]">
        <xsl:choose>
            <xsl:when test="count(current-group()) eq 1">
                <xsl:sequence select="current-group()"/>
            </xsl:when>
            <xsl:otherwise>
                <app>
                    <rdg wit="#A #B">
                        <xsl:apply-templates select="current-group()/node()" mode="group"/>
                    </rdg>
                </app>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="rdg" mode="group">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
