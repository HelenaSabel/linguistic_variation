<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:variable name="string">
            <xsl:apply-templates mode="string"/>
        </xsl:variable>
        <xsl:apply-templates select="$string" mode="tokens"/>
    </xsl:template>

    <!-- String conversion -->
    <xsl:template match="node() | @*" mode="string">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="string"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()" mode="string">
        <xsl:comment select="."/>
    </xsl:template>
    <!-- Elements with children but no attributes-->
    <xsl:template match="ex | am | add[not(@*)] | del[not(@*)]" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <!-- Empty elements with attributes-->
    <xsl:template match="gap" mode="string">
        <xsl:choose>
            <xsl:when test="current()[@reason]">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:for-each select="@*">
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="name()"/>
                    <xsl:text>="</xsl:text>
                    <xsl:value-of select="current()"/>
                    <xsl:text>"</xsl:text>
                </xsl:for-each>
                <xsl:text>/&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>/&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Elements with attributes and children-->
    <xsl:template match="hi | del[@*] | add[@*]" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="@*">
            <xsl:text>_</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="current()"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="choice" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="reg | orig">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="text()[parent::orig | parent::reg | parent::del | parent::add]">
        <xsl:value-of select="replace(., ' ', '_')"/>
    </xsl:template>
    <xsl:template match="orig/ex | orig/am | reg/ex | reg/am | del/ex | del/am | add/ex | add/am">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
<xsl:template match="orig/hi|reg/hi">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:for-each select="@*">
        <xsl:text>_</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>="</xsl:text>
        <xsl:value-of select="current()"/>
        <xsl:text>"</xsl:text>
    </xsl:for-each>
    <xsl:text>&gt;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&lt;/</xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>&gt;</xsl:text>
</xsl:template>
    <xsl:template match="node() | @*" mode="tokens">

        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="tokens"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()" mode="tokens">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="app" mode="tokens">
        <xsl:variable name="Atokens" select="tokenize(rdg[@wit eq '#A'], '\s+')"/>
        <xsl:variable name="Btokens" select="tokenize(rdg[@wit eq '#B'], '\s+')"/>
        <xsl:variable name="count" select="max((count($Atokens), count($Btokens)))"/>
        <xsl:for-each select="1 to $count">
            <xsl:choose>
                <xsl:when test="$Atokens[current()] eq $Btokens[current()]">
                    <xsl:element name="app">
                        <xsl:element name="rdg">
                            <xsl:attribute name="wit">#A #B</xsl:attribute>
                            <xsl:value-of
                                select="insert-before(replace($Atokens[current()], '_', ' '), 2, '')"
                                disable-output-escaping="yes"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <app>
                        <rdg wit="#A">
                            <xsl:choose>
                                <xsl:when test="$Atokens[current()]">
                                    <xsl:value-of select="replace($Atokens[current()], '_', ' ')" disable-output-escaping="yes"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gap/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdg>
                        <rdg wit="#B">
                            <xsl:choose>
                                <xsl:when test="$Btokens[current()]">
                                    <xsl:value-of select="replace($Btokens[current()], '_', ' ')" disable-output-escaping="yes"/>
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
