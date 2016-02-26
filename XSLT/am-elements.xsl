<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ex[not(preceding-sibling::am)]">
        <xsl:element name="am">
            <xsl:if test="current()/matches(., '^ue$') and current()/preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^ue$') and current()/parent::seg/preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^eu$') and current()/preceding-sibling::text()[1][matches(., 'd$')]">
                <xsl:text>&#8217;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^eu$') and current()/parent::seg/preceding-sibling::text()[1][matches(., 'd$')]">
                <xsl:text>&#8217;</xsl:text>
            </xsl:if>            
            <xsl:if test="current()/matches(., '^ro$') and current()/preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#807;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^ro$') and current()/parent::seg/preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#807;</xsl:text>
            </xsl:if> <xsl:if test="current()/matches(., 'er') and current()/preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#818;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^er$') and current()/parent::seg/preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#818;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^er$') and preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#818;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^ri$')">
                <xsl:text>&#8305;</xsl:text>
            </xsl:if>            
            <xsl:if test="current()/matches(., '^ui$')">
                <xsl:text>&#8305;</xsl:text>
            </xsl:if>            
            <xsl:if test="current()/matches(., '^&#771;$')">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if test="current()[not(parent::seg)]/matches(., '^e$') and current()[count(preceding-sibling::node()) eq 0] 
                and current()[count(following-sibling::node()) eq 0]">
                <xsl:text>&#8266;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^ser$')">
                <xsl:text>&#7836;</xsl:text>
            </xsl:if>        
            <xsl:if test="current()/matches(., '^n')">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>            
            <xsl:if test="current()/matches(., '^ra')">
                <xsl:attribute name="rend">superscript</xsl:attribute>
                <xsl:text>&#969;</xsl:text>
            </xsl:if>
            <xsl:if test="current()/matches(., '^ro')">
                <xsl:text>&#8338;</xsl:text>
            </xsl:if>            
            <xsl:if test="current()/matches(., '^us')">
                <xsl:text>&#42863;</xsl:text>
            </xsl:if>         
            <xsl:if test="current()/matches(., '^os')">
                <xsl:text>&#42863;</xsl:text>
            </xsl:if>   
            <xsl:if test="current()/matches(., '^con')">
                <xsl:text>&#42863;</xsl:text>
            </xsl:if>             
            <xsl:if test="current()/matches(., '^contra')">
                <xsl:text>&#42862;&#772;</xsl:text>
            </xsl:if>  
        </xsl:element>        
        <xsl:copy-of select="."/>   
    </xsl:template>
</xsl:stylesheet>