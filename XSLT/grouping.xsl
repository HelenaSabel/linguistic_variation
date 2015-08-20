<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="l">
        <xsl:copy>
            <xsl:for-each-group select="node()" group-starting-with="app">
                <xsl:choose>
                    <xsl:when test="name(.) eq 'app'">
                        <xsl:copy-of select="."/>
                        <xsl:if test="current-group()[2]">
                            <app>
                                <rdg wit="#A #B"><xsl:copy-of select="current-group() except ."/></rdg>
                            </app>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <app>
                            <rdg wit="#A #B"><xsl:copy-of select="current-group()"/></rdg>
                        </app>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>