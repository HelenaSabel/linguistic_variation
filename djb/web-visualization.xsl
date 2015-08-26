<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:variable name="witnesses" select="//tei:witness[@xml:id]"/>
    <xsl:variable name="fenomenos" select="doc('other-files/features.xml')//tei:fs[@feats[not(contains(., '#ling'))]]"/>
    <xsl:variable name="ling" select="doc('.other-files/features.xml')//tei:fs[@feats[contains(., '#ling')]]"/>
    <xsl:variable name="poets" select="doc('other-files/corpus_autores.xml')//tei:person"/>
    <xsl:template match="/">
        <xsl:variable name="span">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:apply-templates select="$span" mode="div"/>
    </xsl:template>
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <title>Ediçom sinóptica</title>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <link href="CSS/index.css" rel="stylesheet" type="text/css" />
                <link href="CSS/poems.css" rel="stylesheet" type="text/css"/>
                <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
                <script src="JavaScript/language.js" type="text/javascript">/**/</script>
                <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js" type="text/javascript">/**/</script>
                <!--#include virtual="SSI/favicon.html"-->
            </head>
            <body>
                <xsl:comment>#include virtual="SSI/initials.html"</xsl:comment>
                <div class="body">
                    <xsl:comment>#include virtual="SSI/menu.html"</xsl:comment>
                    <div class="banner">
                        <img src="images/banner-ms.jpg" alt="banner"/>
                    </div>
                    <h1>
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                    </h1>
                    <div class="container">

                        <div class="main">
                            <xsl:apply-templates/>
                        </div>
                        <div class="rightSide" id="move">
                            <div class="gl">
                                <h3>Conteúdos</h3>
                                <ul>
                                    <xsl:for-each select="//tei:div[@type='poem']">
                                        <li><a href="{current()/@corresp}"><xsl:value-of select="current()/substring(@corresp,2)"/></a></li>
                                    </xsl:for-each>
                                </ul>
                            </div>
                            <div class="en">
                                <h3>Table of contents</h3>
                                <ul>
                                    <xsl:for-each select="//tei:div[@type='poem']">
                                        <li><a href="{current()/@corresp}"><xsl:value-of select="current()/substring(@corresp,2)"/></a></li>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="footer"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:teiHeader">
        <h2>Metadata</h2>
        <p>
            <xsl:apply-templates select="//tei:resp"/>
        </p>
        <p>
            <xsl:apply-templates select="//tei:sourceDesc//tei:p"/>
        </p>
    </xsl:template>
    <xsl:template match="tei:front">
        <xsl:variable name="witnesses" select="//tei:witness"/>
        <h3>Testemunhos</h3>
        <ul>
            <xsl:for-each select="$witnesses">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ul>
        <h2>Cantigas</h2>
    </xsl:template>
    <xsl:template match="tei:div[@type='poem']">
        <xsl:variable name="wit1" select="tei:head//tei:rdg[1]/@wit"/>
        <xsl:variable name="wit2" select="tei:head//tei:rdg[2]/@wit"/>
        <xsl:variable name="wit3" select="tei:head//tei:rdg[3]/@wit"/>
        <xsl:variable name="author" select="$poets[@xml:id = current()//tei:name/substring(@ref,2)]"/>
        <xsl:variable name="song" select="current()/substring(@corresp,2)"/>
        <div class="metadata">
            <h4 id="{$song}">Cantiga: <xsl:value-of select="$song"/></h4>
            <h4>
                <xsl:text>Autor: </xsl:text>
                <xsl:value-of select="$author/tei:persName"/>
            </h4>
            <h4><xsl:text>Período: </xsl:text><xsl:value-of select="$author/tei:floruit/@from"
                    />-<xsl:value-of select="$author/tei:floruit/@to"/> (período <xsl:value-of
                    select="$author/tei:floruit/@period"/>)</h4>
        </div>
        <div class="poem">
            <h4>
                <xsl:attribute name="class">
                    <xsl:value-of select="substring($wit1,2)"/>
                </xsl:attribute>
                <xsl:text>Testemunho: </xsl:text>
                <xsl:value-of select="substring($wit1,2)"/>
            </h4>
            <ul>
                <xsl:attribute name="class">
                    <xsl:value-of select="substring($wit1,2)"/>
                </xsl:attribute>

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
            <h4>
                <xsl:attribute name="class">
                    <xsl:value-of select="substring($wit2,2)"/>
                </xsl:attribute>
                <xsl:text>Testemunho: </xsl:text>
                <xsl:value-of select="substring($wit2,2)"/>
            </h4>
            <ul>
                <xsl:attribute name="class">
                    <xsl:value-of select="substring($wit2,2)"/>
                </xsl:attribute>
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
                                >-<xsl:value-of
                                select="tei:head//tei:rdg[@wit = $wit3]/tei:locus/@to"/></xsl:if>
                    </li>
                    <li>Mão: <xsl:value-of
                            select="tei:head//tei:rdg[@wit = $wit3]/substring(@hand,2)"/></li>
                </ul>
            </xsl:if>
            <ol>
                <xsl:for-each select="tei:l">
                    <li>
                        <xsl:apply-templates/>
                    </li>
                </xsl:for-each>
            </ol>
        </div>
    </xsl:template>
    <xsl:template match="tei:app">
        <xsl:for-each select="tei:rdg">
            <xsl:variable name="ana" select="tokenize(replace(@ana, '#', ''), ' ')"/>
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:value-of select="replace(replace(@wit,'#', ''), ' ', '')"/>
                </xsl:attribute>
                <xsl:if test=".[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos/@xml:id][not(tei:seg)][not(tei:choice)]">
                    <xsl:attribute name="data-ana">
                        <xsl:value-of select="$fenomenos[@xml:id = $ana]/@n"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test=".[tokenize(replace(@ana, '#', ''), ' ') = $ling/@xml:id][not(tei:seg)][not(tei:choice)]">
                    <xsl:attribute name="data-ling">
                        <xsl:value-of select="$ling[@xml:id = $ana]/@n"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:for-each>
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="tei:seg">
        <xsl:variable name="ana" select="tokenize(replace(@ana, '#', ''), ' ')"/>
        <span class="seg">
            <xsl:if test=".[tokenize(replace(@ana, '#', ''), ' ') = $fenomenos/@xml:id]">           
            <xsl:attribute name="data-ana">
                <xsl:value-of select="$fenomenos[@xml:id = $ana]/@n"/>
            </xsl:attribute>
            </xsl:if> 
            <xsl:if test=".[tokenize(replace(@ana, '#', ''), ' ') = $ling/@xml:id]">
            <xsl:attribute name="data-ling">
                <xsl:value-of select="$ling[@xml:id = $ana]/@n"/>
            </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:ex">
        <span class="abbr">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:choice">
        <span class="reg">
            <xsl:attribute name="data-ana">Disposição original: <em><xsl:apply-templates
                        select="tei:orig"/></em></xsl:attribute>
            <xsl:apply-templates select="tei:reg"/>
        </span>
    </xsl:template>
<xsl:template match="tei:gap">
<!--        <xsl:element name="span">
            <xsl:if test="@reason">
                <xsl:attribute name="class"><xsl:value-of select="@reason"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="not(@reason)">
                <xsl:attribute name="class">title</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="class">title</xsl:attribute>
            <xsl:text>Omissão</xsl:text>
        </xsl:element>-->
    <span class="gap">[ ]</span>
    </xsl:template>
    <xsl:template match="tei:add">
        <span class="add">[<xsl:apply-templates/>]</span>
    </xsl:template>
    <xsl:template match="tei:del">
        <span class="del">(<xsl:apply-templates/>)</span>
    </xsl:template>
    <xsl:template match="tei:hi">
        <span class="hi">[<xsl:apply-templates/>]</span>
    </xsl:template>
    <xsl:template match="node()|@*" mode="div">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="div"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="html:div[@class='poem']" mode="div">
        <xsl:variable name="wit1" select="html:div//html:ul[1]/@class"/>
        <xsl:variable name="wit2" select="html:div//html:ul[2]/@class"/>
        <xsl:variable name="wit3" select="html:div//html:ul[3]/@class"/>
        <xsl:element name="div">
            <xsl:attribute name="class">frame</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">first</xsl:attribute>
                <xsl:copy-of select="."/>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="class">second</xsl:attribute>
                <xsl:copy-of select="."/>
            </xsl:element>
            <xsl:if test="count(html:div//html:ul) eq 3">
                <xsl:element name="div">
                    <xsl:attribute name="class">third</xsl:attribute>
                    <xsl:copy-of select="."/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="html:span[@data-ana='Variante gráfica com distribuição irregular '][.//html:span/@class='abbr']" mode="div">
        <xsl:element name="span">
            <xsl:if test="@class">
                <xsl:attribute name="class"><xsl:value-of select="current()/@class"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@data-ling">
                <xsl:attribute name="data-ling"><xsl:value-of select="current()/@data-ling"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="html:span[@class='abbr'][parent::html:span[@data-ana='Variante gráfica com distribuição irregular ']]" mode="div">
        <span class="abbr">
            <xsl:attribute name='data-ana'><xsl:text>Variante gráfica com distribuição irregular</xsl:text></xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
