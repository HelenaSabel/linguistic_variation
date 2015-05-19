<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:template match="tei:l">                
        <xsl:choose>
            <xsl:when test="current()[.//tei:rdg[contains(., '{$search}')]]">
                <xsl:variable name="rdg">
                    <xsl:sequence select="current()//tei:rdg[contains(., '{$search}')]"/>
                </xsl:variable>
                <xsl:if test="current()//tei:rdg[. = $rdg]">
                    <xsl:sequence select="current()//node()[not(. = tei:rdg[@wit ne $rdg/@wit])]"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                    <ul>
                        <li>
                            <xsl:sequence select="current()//node()[not(. = app//tei:rdg[2])]"/>
                        </li>
                        <li>
                            <xsl:sequence select="current()//node()[not(. = app//tei:rdg[1])]"/>
                        </li>
                    </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:choice">
        <span class="reg">
            <xsl:attribute name="data-ana">Disposição original: <em><xsl:apply-templates
                select="tei:orig"/></em></xsl:attribute>
            <xsl:apply-templates select="tei:reg"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:ex">
        <span class="ex">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
