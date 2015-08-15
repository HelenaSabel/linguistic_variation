<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="A"
        select="
            document('A246B811V395/A.xml') |
            document('A248B816V400/A.xml') |
            document('A255B842V428/A.xml')
            "/>
    <xsl:variable name="Abis" select="document('A248B816V400/Abis.xml')"/>
    <xsl:variable name="B"
        select="
            document('A246B811V395/B.xml') | document('B1278V884N1/B.xml') | document('B1281V887N4/B.xml') | document('B1284V890N7/B.xml') | document('B526V109T3/B.xml') | document('B529V112T6/B.xml') |
            document('A248B816V400/B.xml') | document('B1279V885N2/B.xml') | document('B1282V888N5/B.xml') | document('B524V107T1/B.xml') | document('B527V110T4/B.xml') |
            document('A255B842V428/B.xml') | document('B1280V886N3/B.xml') | document('B1283V889N6/B.xml') | document('B525V108T2/B.xml') | document('B528V111T5/B.xml')
            "/>
    <xsl:variable name="V"
        select="
            document('A246B811V395/V.xml') | document('B1278V884N1/V.xml') | document('B1281V887N4/V.xml') | document('B1284V890N7/V.xml') | document('B526V109T3/V.xml') | document('B529V112T6/V.xml') |
            document('A248B816V400/V.xml') | document('B1279V885N2/V.xml') | document('B1282V888N5/V.xml') | document('B524V107T1/V.xml') | document('B527V110T4/V.xml') |
            document('A255B842V428/V.xml') | document('B1280V886N3/V.xml') | document('B1283V889N6/V.xml') | document('B525V108T2/V.xml') | document('B528V111T5/V.xml')
            "/>
    <xsl:variable name="N"
        select="
            document('B1278V884N1/N.xml') | document('B1281V887N4/N.xml') | document('B1284V890N7/N.xml') |
            document('B1279V885N2/N.xml') | document('B1282V888N5/N.xml') |
            document('B1280V886N3/N.xml') | document('B1283V889N6/N.xml')"/>
    <xsl:variable name="T"
        select="
            document('B526V109T3/T.xml') | document('B529V112T6/T.xml') |
            document('B524V107T1/T.xml') | document('B527V110T4/T.xml') |
            document('B525V108T2/T.xml') | document('B528V111T5/T.xml')
            "/>

    <xsl:template match="/">
        <xsl:element name="root">
            <xsl:apply-templates select="$B//div"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="div">
        <xsl:element name="div">
            <xsl:attribute name="type">poem</xsl:attribute>
            <xsl:attribute name="corresp" select="base-uri(.)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="l">
        <xsl:element name="l">
            <xsl:attribute name="n" select="count(preceding-sibling::l) + 1"/>
            <xsl:element name="app">
                <xsl:if test="contains(base-uri(.), 'A')">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">#A</xsl:attribute>
                        <xsl:value-of
                            select="$A//div[base-uri(.) = base-uri(current())]//l[position() = count(current()/preceding-sibling::l) + 1]"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="contains(base-uri(.), 'A248B816V400')">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">#A2</xsl:attribute>
                        <xsl:value-of
                            select="$Abis//div[base-uri(.) = base-uri(current())]//l[position() = count(current()/preceding-sibling::l) + 1]"/>
                    </xsl:element>
                </xsl:if>
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#B</xsl:attribute>
                    <xsl:copy-of select="current()/node()"/>
                </xsl:element>
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">#V</xsl:attribute>
                    <xsl:value-of
                        select="$V//div[base-uri(.) = base-uri(current())]//l[position() = count(current()/preceding-sibling::l) + 1]"/>
                </xsl:element>
                <xsl:if test="contains(base-uri(.), 'N')">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">#N</xsl:attribute>
                        <xsl:value-of
                            select="$N//div[base-uri(.) = base-uri(current())]//l[position() = count(current()/preceding-sibling::l) + 1]"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="contains(base-uri(.), 'T')">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">#T</xsl:attribute>
                        <xsl:value-of
                            select="$T//div[base-uri(.) = base-uri(current())]//l[position() = count(current()/preceding-sibling::l) + 1]"/>
                    </xsl:element>
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
