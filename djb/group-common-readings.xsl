<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template
        match="app[rdg[contains(@wit, '#A #B')]][following-sibling::node()[1][self::app/rdg[contains(@wit, '#A #B')]]]">
        <app>
            <rdg wit="#A #B"><xsl:sequence select="current()/rdg/*"/><xsl:sequence select="
                        following-sibling::app/rdg[contains(@wit, '#A #B')]/*
                        except following-sibling::app[rdg[not(contains(@wit, '#A #B'))]]/following-sibling::*"/></rdg>
        </app>
    </xsl:template>
    <xsl:template
        match="app[rdg[contains(@wit, '#A #B')]][preceding-sibling::node()[1][self::app/rdg[contains(@wit, '#A #B')]]]"
    />
</xsl:stylesheet>
