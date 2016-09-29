<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://purl.oclc.org/dsdl/schematron" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="apos">&apos;</xsl:variable>
    <xsl:variable name="boundary">&apos;, &apos;</xsl:variable>
    <xsl:template match="/">
        <xsl:element name="schema">
            <xsl:attribute name="queryBinding">xslt2</xsl:attribute>
            <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
            <pattern>
                <rule context="tei:fvLib/tei:fs">
                    <assert test="tei:f[@name = ('description', 'taxonomy')]">
                        One of the following features is required: 
                        'description, taxonomy'</assert>
                    <assert test="@xml:id">ID required</assert>
                </rule>
                <xsl:apply-templates select="//fsdDecl"/>
            </pattern>
        </xsl:element>
    </xsl:template>
    <xsl:template match="fsDecl[not(@type eq 'variants.taxonomy')]">        
        <xsl:variable name="names">
            <xsl:value-of select="string-join(fDecl/@name, ', ')"/> 
        </xsl:variable>
        <xsl:variable name="f-values">
            <xsl:value-of select="replace($names, ', ', $boundary)"/>
        </xsl:variable>
        <xsl:element name="rule">
            <xsl:attribute name="context">
                <xsl:value-of select="concat('tei:fs[@type eq ', $apos, current()/@type, $apos, ']', '[ancestor::tei:fvLib]')"/>
            </xsl:attribute>
                <xsl:element name="assert">
                    <xsl:attribute name="test"> 
                        <xsl:value-of select="concat('tei:f[@name = (', $apos, $f-values, $apos, ')]')"/>
                    </xsl:attribute>
                    One of the following features is required: 
                    <xsl:value-of select="concat($apos, $names, $apos)"/>
                </xsl:element>
        </xsl:element>
        <xsl:apply-templates select="fDecl"/>
    </xsl:template>
    <xsl:template match="fDecl">
            <xsl:element name="rule">
                <xsl:attribute name="context">
                    <xsl:value-of select="concat('tei:f[@name eq ', $apos, current()/@name, $apos, ']', '[parent::fs[@type eq ', $apos, current()/parent::fsDecl/@type, $apos, ']]')"/>
                </xsl:attribute>
                <xsl:if test="vRange/vNot">
                    <xsl:element name="assert">
                        <xsl:attribute name="test">tei:string/text()</xsl:attribute>
                        <xsl:text>This cannot be an empty element</xsl:text>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="vRange/vAlt/count(distinct-values(*/name())) = 1">
                    <xsl:choose>
                        <xsl:when test="vRange/vAlt/vNot">
                            <xsl:element name="assert">
                                <xsl:attribute name="test">tei:vAlt/tei:string/text()</xsl:attribute>
                                <xsl:text>This cannot be an empty element</xsl:text>
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="vRange/vAlt/fs">
                            <xsl:element name="assert">
                                <xsl:attribute name="test">
                                    <xsl:variable name="types">
                                        <xsl:value-of
                                            select="replace(string-join(./vRange/vAlt/fs/@type, '-'), '-', $boundary)"
                                        />
                                    </xsl:variable>
                                    <xsl:value-of
                                        select="concat('tei:fs[@type = (', $apos, $types, $apos, ')]')"
                                    />
                                </xsl:attribute> Incorrect @type value. Possible values are:
                                <xsl:value-of select="concat($apos, string-join(./vRange/vAlt/fs/@type, ', '), $apos)"
                                />
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="vRange/vAlt/binary">
                            <xsl:element name="assert">
                                <xsl:attribute name="test">tei:binary</xsl:attribute>
                                Binary feature.
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="assert">
                                <xsl:attribute name="test">
                                    <xsl:variable name="symbols">
                                        <xsl:value-of
                                            select="replace(string-join(./vRange/vAlt/symbol/@value, ','), ',', $boundary)"
                                        />
                                    </xsl:variable>
                                    <xsl:value-of
                                        select="concat('tei:symbol[@value = (', $apos, $symbols, $apos, ')]')"
                                    />
                                </xsl:attribute> Incorrect @type value. Possible values are:
                                    <xsl:value-of
                                        select="concat($apos, string-join(./vRange/vAlt/symbol/@value, ', '), $apos)"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="vRange/vAlt/count(distinct-values(*/name())) = 2">
                    <xsl:element name="assert">
                        <xsl:attribute name="test">
                            <xsl:variable name="types">
                                <xsl:value-of
                                    select="replace(string-join(./vRange/vAlt/fs/@type, ','), ',', $boundary)"
                                />
                            </xsl:variable>
                            <xsl:variable name="symbols">
                                <xsl:value-of
                                    select="replace(string-join(./vRange/vAlt/symbol/@value, ','), ',', $boundary)"
                                />
                            </xsl:variable>
                            <xsl:value-of
                                select="concat('tei:symbol[@value = (', $apos, $symbols, $apos, ')] or tei:fs[@type = (', $apos, $types, $apos, ')]')"
                            />
                        </xsl:attribute> Incorrect value. Possible values are: a fs element with one of the following @type attributes
                        <xsl:value-of select=" concat($apos,string-join(./vRange/vAlt/fs/@type, ', '), $apos)"
                        />
                        or a symbol element with one of the following @value attributes
                        <xsl:value-of
                            select="concat($apos, string-join(./vRange/vAlt/symbol/@value, ', '), $apos)"/>
                    </xsl:element>
                </xsl:if>                
                <xsl:if test="vRange/fs">
                    <xsl:element name="assert">
                        <xsl:attribute name="test">
                            <xsl:value-of select="concat('tei:fs[@name =',$apos, ./vRange/fs/@type, $apos, ']')"/>
                        </xsl:attribute>
                        Required fs of type <xsl:value-of select="current()/vRange/fs/@type"/>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
        
    </xsl:template>
</xsl:stylesheet>
