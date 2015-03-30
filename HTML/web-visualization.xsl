<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat"/>
    
    <xsl:variable name="witnesses" select="//witness[@xml:id]" />
    <xsl:variable name="numWitnesses" select="count($witnesses)" />
    <xsl:template match="TEI">
        <html>
            <head>
                <title>Edición sinóptica</title>
                <meta charset="utf-8"/>
                <link href="CSS/index.css" rel="stylesheet" type="text/css"/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="teiHeader">
        <h1>
            <xsl:apply-templates select="//titleStmt/title"/>
        </h1>
        <div>
            <xsl:apply-templates select="//resp"/>
        </div>
        <div>
            <p>
                <xsl:apply-templates select="//sourceDesc"/>
            </p>
        </div>
    </xsl:template>
    <xsl:template match="front">
        <xsl:variable name="witnesses" select="//witness"/>
        <h3>Testemuños</h3>
        <ul class="wistnesses">
            <xsl:for-each select="$witnesses">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="div[@type='poem']">
        <xsl:variable name="wit" select="head/title/app/rdg"/>
        <xsl:if test="count($wit) eq 2">
            <div class="container">
                <div class="pane">
                    <h3>
                        <xsl:value-of select="$wit[1]"/>
                    </h3>
                    <ul>
                        <xsl:for-each select="l">
                            <li>
                                <xsl:apply-templates select="app/rdg[1]"/>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
