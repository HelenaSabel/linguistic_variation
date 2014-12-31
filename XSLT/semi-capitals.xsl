<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="l"/>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="l/text()[1]">
        <xsl:choose>
            <xsl:when test="matches(.,'^\p{Lu}{2}')">
                <!-- SE cuita grande -->
                <xsl:analyze-string select="." regex="^(.)(.)(.*)$">
                    <xsl:matching-substring>
                        <xsl:message>
                            <xsl:value-of select="concat('Matched: ',.)"/>
                        </xsl:message>
                        <xsl:sequence
                            select="concat(regex-group(1), lower-case(regex-group(2)), regex-group(3))"
                        />
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:when test="preceding-sibling::*[1][self::hi or self::gap[@reason='unfinished']]">
                <!-- <hi rend="guide">S</hi>Ennor pe or <gap reason="unfinished"/>Ennor -->
                <xsl:analyze-string select="." regex="^(.)(.*)$">
                    <xsl:matching-substring>
                        <xsl:message>
                            <xsl:value-of select="concat('Matched: ',.)"/>
                        </xsl:message>
                        <xsl:sequence select="concat(lower-case(regex-group(1)), regex-group(2))"/>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>