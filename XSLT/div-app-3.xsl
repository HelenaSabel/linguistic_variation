<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="xml" indent="yes"/>   
    <xsl:variable name="header" select="doc('../edition/sandim1.xml')//tei:teiHeader"/>
    <xsl:template match="/">
        <xsl:element name="TEI">
            <xsl:copy-of select="$header"/>
            <text>
                <front>
                    <div>
                        <listWit>
                            <witness corresp="#A">Cancioneiro da Ajuda</witness>
                            <witness corresp="#B">Cancioneiro da Biblioteca Nacional</witness>
                            <witness corresp="#V">Cancioneiro da Biblioteca Vaticana</witness>
                        </listWit>
                    </div>
                </front>
                <body>
        <xsl:copy>
            <xsl:apply-templates select="//div"/>
        </xsl:copy>
                </body>
            </text>
        </xsl:element>
    </xsl:template>    
    <xsl:template match="comment()">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="div[@type='poem']">
        <xsl:element name="div">
            <xsl:attribute name="type">
                <xsl:value-of select="current()/@type"/>
            </xsl:attribute>
            <xsl:attribute name="corresp">
                <xsl:value-of select="current()/@corresp"/>
            </xsl:attribute>
            <xsl:element name="head">
                <xsl:element name="title">
                    <xsl:element name="app">
                        <xsl:element name="rdg">                            
                            <xsl:attribute name="wit">
                                <xsl:analyze-string select="string(./@corresp)" regex="(#\w)\d+\w\d+\w\d+">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="regex-group(1)"/>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>
                            </xsl:attribute>
                            <xsl:attribute name="hand">#missing</xsl:attribute>
                            <xsl:element name="idno">
                                <xsl:analyze-string select="string(./@corresp)" regex="#(\w\d+)(\w\d+)\w\d+">
                                <xsl:matching-substring>
                                    <xsl:value-of select="regex-group(1)"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                            </xsl:element>
                            <xsl:element name="locus">
                                <xsl:attribute name="from"/>
                                <xsl:attribute name="to"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="rdg">
                            <xsl:attribute name="wit">
                                <xsl:analyze-string select="string(./@corresp)" regex="#\w\d+(\w)\d+\w\d+">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="concat('#',regex-group(1))"/>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>
                            </xsl:attribute>
                            <xsl:attribute name="hand">#d</xsl:attribute>
                            <xsl:element name="idno">
                                <xsl:analyze-string select="string(./@corresp)" regex="#(\w\d+)(\w\d+)\w\d+">
                                <xsl:matching-substring>
                                    <xsl:value-of select="regex-group(2)"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                            </xsl:element>
                        <xsl:element name="locus">
                            <xsl:attribute name="from"/>
                            <xsl:attribute name="to"/>
                        </xsl:element>
                    </xsl:element>
                            <xsl:element name="rdg">
                                <xsl:attribute name="wit">
                                    <xsl:analyze-string select="string(./@corresp)" regex="#\w\d+\w\d+(\w)\d+">
                                        <xsl:matching-substring>
                                            <xsl:value-of select="concat('#',regex-group(1))"/>
                                        </xsl:matching-substring>
                                    </xsl:analyze-string>
                                </xsl:attribute>
                                <xsl:attribute name="hand">#v</xsl:attribute>
                                <xsl:element name="idno">
                                    <xsl:analyze-string select="string(./@corresp)" regex="#\w\d+\w\d+(\w\d+)">
                                        <xsl:matching-substring>
                                            <xsl:value-of select="regex-group(1)"/>
                                        </xsl:matching-substring>
                                    </xsl:analyze-string>
                                </xsl:element>                                
                                <xsl:element name="locus">
                                    <xsl:attribute name="from"/>
                                    <xsl:attribute name="to"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                <xsl:element name="name">
                    <xsl:attribute name="role">author</xsl:attribute>
                    <xsl:attribute name="ref">#FerVelho</xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:sequence select="current()//l"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
