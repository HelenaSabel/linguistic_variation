<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:variable name="witnesses" select="//tei:witness[@xml:id]"/>
    <xsl:variable name="fenomenos" select="doc('../ancillary-files/feature_library.xml')//tei:fs"/>
    <xsl:variable name="poets" select="doc('../ancillary-files/corpus_autores.xml')//tei:person"/>
    <xsl:variable name="cantigas" select="doc('../ancillary-files/biblList.xml')//tei:bibl"/>
    <xsl:template match="/">
        <xsl:variable name="span">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:apply-templates select="$span" mode="div"/>
    </xsl:template>
    <xsl:template match="tei:TEI">
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
    <xsl:template match="tei:teiHeader">
        <h1>
            <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
        </h1>
        <div>
            <xsl:apply-templates select="//tei:resp"/>
        </div>
        <div>
            <xsl:apply-templates select="//tei:sourceDesc//tei:p"/>
        </div>
    </xsl:template>
    <xsl:template match="tei:front">
        <xsl:variable name="witnesses" select="//tei:witness"/>
        <h3>Testemunhos</h3>
        <ul class="wistnesses">
            <xsl:for-each select="$witnesses">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="tei:div[@type='poem']">
        <xsl:variable name="wit1" select="tei:head//tei:rdg[1]/@wit"/>
        <xsl:variable name="wit2" select="tei:head//tei:rdg[2]/@wit"/>
        <xsl:variable name="wit3" select="tei:head//tei:rdg[3]/@wit"/>
        <xsl:variable name="author" select="$poets[@xml:id = current()//tei:name/substring(@ref,2)]"/>
        <xsl:variable name="song" select="$cantigas[@xml:id = current()/substring(@corresp,2)]"/>
        <div class="poem">
            <div class="metada">
            <h4>Cantiga: <xsl:value-of select="$song"/></h4>
            <h4>
                <xsl:text>Autor: </xsl:text>
                <xsl:value-of select="$author/tei:persName"/>
            </h4>
            <h4><xsl:text>Período: </xsl:text><xsl:value-of select="$author/tei:floruit/@from"
                    />-<xsl:value-of select="$author/tei:floruit/@to"/> (período <xsl:value-of
                    select="$author/tei:floruit/@period"/>)</h4>
            <h4>
                <xsl:text>Testemunho:</xsl:text>
            </h4>
            <ul>
                <xsl:attribute name="class">
                    <xsl:value-of select="substring($wit1,2)"/>
                </xsl:attribute>
                <li>
                    <xsl:text>Manuscrito: </xsl:text>
                    <xsl:value-of select="substring($wit1,2)"/>
                </li>
                <li>
                    <xsl:text>Texto: </xsl:text>
                    <xsl:value-of select="tei:head//tei:rdg[@wit = $wit1]"/>
                </li>
                <li>
                    <xsl:text>Localização: </xsl:text>
                    <xsl:value-of select="tei:head//tei:rdg[@wit = $wit1]/tei:locus/@from"/>
                    <xsl:if
                        test="tei:head//tei:rdg[@wit = $wit1]/tei:locus/@from ne tei:head//tei:rdg[@wit = $wit1]/tei:locus/@to"
                            >-<xsl:value-of select="tei:head//tei:rdg[@wit = $wit1]/tei:locus/@to"
                        /></xsl:if>
                </li>
                <li>Mão: <xsl:value-of select="tei:head//tei:rdg[@wit = $wit1]/substring(@hand,2)"
                    /></li>
            </ul>
            <ul>
                <xsl:attribute name="class">
                    <xsl:value-of select="substring($wit2,2)"/>
                </xsl:attribute>
                <li>
                    <xsl:text>Manuscrito: </xsl:text>
                    <xsl:value-of select="substring($wit2,2)"/>
                </li>
                <li>
                    <xsl:text>Texto: </xsl:text>
                    <xsl:value-of select="tei:head//tei:rdg[@wit = $wit2]"/>
                </li>
                <li>
                    <xsl:text>Localização: </xsl:text>
                    <xsl:value-of select="tei:head//tei:rdg[@wit = $wit2]/tei:locus/@from"/>
                    <xsl:if
                        test="tei:head//tei:rdg[@wit = $wit2]/tei:locus/@from ne tei:head//tei:rdg[@wit = $wit2]/tei:locus/@to"
                        >-<xsl:value-of select="tei:head//tei:rdg[@wit = $wit2]/tei:locus/@to"
                        /></xsl:if>
                </li>
                <li>Mão: <xsl:value-of select="tei:head//tei:rdg[@wit = $wit2]/substring(@hand,2)"
                /></li>
            </ul>
            <xsl:if test="count(tei:head//tei:rdg) eq 3">
                <ul>
                    <xsl:attribute name="class">
                        <xsl:value-of select="substring($wit3,2)"/>
                    </xsl:attribute>
                    <li>
                        <xsl:text>Manuscrito: </xsl:text>
                        <xsl:value-of select="substring($wit3,2)"/>
                    </li>
                    <li>
                        <xsl:text>Texto: </xsl:text>
                        <xsl:value-of select="tei:head//tei:rdg[@wit = $wit3]"/>
                    </li>
                    <li>
                        <xsl:text>Localização: </xsl:text>
                        <xsl:value-of select="tei:head//tei:rdg[@wit = $wit3]/tei:locus/@from"/>
                        <xsl:if
                            test="tei:head//tei:rdg[@wit = $wit3]/tei:locus/@from ne tei:head//tei:rdg[@wit = $wit3]/tei:locus/@to"
                            >-<xsl:value-of select="tei:head//tei:rdg[@wit = $wit3]/tei:locus/@to"
                            /></xsl:if>
                    </li>
                    <li>Mão: <xsl:value-of select="tei:head//tei:rdg[@wit = $wit3]/substring(@hand,2)"
                    /></li>
                </ul>
            </xsl:if>
            </div>
            <div class="text">
            <ol>
                <xsl:for-each select="tei:l">
                    <li>
                        <xsl:apply-templates/>
                    </li>
                </xsl:for-each>
            </ol>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:app">
        <xsl:for-each select="tei:rdg">
            <xsl:variable name="ana" select="tokenize(replace(@ana, '#', ''), ' ')"/>
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:value-of select="replace(tokenize(@wit,' '), '#', '')"/>
                </xsl:attribute>
                <xsl:if test="@ana">
                    <xsl:attribute name="data-ana">
                        <xsl:value-of select="$fenomenos[@xml:id = $ana]/@n"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:ex">
        <span class="abbr">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:choice">
        <span class="orig">
            <xsl:apply-templates select="tei:orig"/>
        </span>
        <span class="reg">
            <xsl:apply-templates select="tei:reg"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:gap">
        <xsl:element name="span">
            <xsl:if test="@reason">
                <xsl:attribute name="class"><xsl:value-of select="@reason"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="not(@reason)">
                <xsl:attribute name="class">unknown</xsl:attribute>
            </xsl:if>
            <xsl:text>Omissão</xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:add">
        <span class="add">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:del">
        <span class="del">
            <xsl:apply-templates/>
        </span>
    </xsl:template>    
    <xsl:template match="tei:hi">
        <span class="hi">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="node()|@*" mode="div">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="div"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="div[@class='poem']" mode="div">
        <xsl:copy-of select="current()//*[@class='A']"/>
        <xsl:copy-of select="current()//*[@class='B']"/>
    </xsl:template>
</xsl:stylesheet>
