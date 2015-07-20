<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <!--I have multiple folders for each song. 
        Each folder is named after the song ID and inside every one of them there is an XML document
    with the transcription of each witnesses for that song. That means that all of transcriptions of A
    are in a document called A.xml but in different folders.
    So, as a first step, I create a variable so all the songs of the same witness have the same treatment-->
    <xsl:variable name="divs" select="$A|$B|$N|$T|$V"/>
    <xsl:variable name="B" select="document('//B.xml')//div"/>
    <xsl:variable name="V" select="document('//V.xml')//div"/>
    <xsl:variable name="A" select="document('//A.xml')//div"/>
    <xsl:variable name="N" select="document('//N.xml')//div"/>
    <xsl:variable name="T" select="document('//T.xml')//div"/>

    <xsl:template match="/">
        <xsl:element name="tei">
            <xsl:apply-templates select="//div"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div[./base-uri(..) = base-uri($divs)]">
        <xsl:element name="div">
            <xsl:attribute name="type">poem</xsl:attribute>
            <xsl:attribute name="corresp" select="document-uri(./..)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l">
        <xsl:element name="l">
            <xsl:attribute name="n" select="count(preceding-sibling::l)+1"/>
            <xsl:element name="app">
                <xsl:element name="rdg">
                    <xsl:copy-of select="current()/node()"/>
                </xsl:element>
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#B</xsl:attribute>
                    <xsl:sequence
                        select="$B[@corresp = current()/parent::*/@corresp]//l[@n = current()/@n]"
                    />
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
