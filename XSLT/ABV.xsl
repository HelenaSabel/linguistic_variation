<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- java -jar ../../SaxonHE9-6-0-7J/saxon9he.jar -s:in-progress XSLT/ABV.xsl -o:unfinished  -->

    <xsl:variable name="done" select="collection('../temporary')//tei:div/@corresp"/>
    <xsl:variable name="A"
        select="collection('../in-progress')//div[@wit = '#A'][not(@corresp = $done)]"/>
    <xsl:variable name="B"
        select="collection('../in-progress')//div[@wit = '#B'][not(@corresp = $done)]"/>
    <xsl:variable name="V"
        select="collection('../in-progress')//div[@wit = '#V'][not(@corresp = $done)]"/>
    <xsl:template match="/">

        <xsl:result-document href="AB-app.xml">
            <xsl:element name="tei">
                <xsl:apply-templates select="//$A[@corresp = $B/@corresp][@corresp != $V/@corresp]"
                />
            </xsl:element>
        </xsl:result-document>

        <xsl:result-document href="ABV-app.xml">
            <xsl:element name="tei">
                <xsl:apply-templates select="//$A[@corresp = $B/@corresp][@corresp = $V/@corresp]"/>
            </xsl:element>
        </xsl:result-document>

    </xsl:template>
    <xsl:template match="div">
        <xsl:element name="div">
            <xsl:attribute name="type">poem</xsl:attribute>
            <xsl:attribute name="corresp" select="current()/@corresp"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l">
        <xsl:element name="l">
            <xsl:attribute name="n" select="count(preceding-sibling::l) + 1"/>
            <xsl:element name="app">
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#A</xsl:attribute>
                    <xsl:copy-of select="current()/node()"/>
                </xsl:element>
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#B</xsl:attribute>
                    <xsl:sequence
                        select="$B[@corresp = current()/parent::*/@corresp]/l[position() eq count(current()/preceding-sibling::l) + 1]/node()"
                    />
                </xsl:element>
                <xsl:if test="$V[@corresp = current()/parent::*/@corresp]">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">#V</xsl:attribute>
                        <xsl:sequence
                            select="$V[@corresp = current()/parent::*/@corresp]/l[position() eq count(current()/preceding-sibling::l) + 1]/node()"
                        />
                    </xsl:element>
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
