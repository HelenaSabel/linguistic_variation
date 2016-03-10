<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <!--    Command line from linguistic_variation folder:
    java -jar ../../SaxonHE9-6-0-7J/saxon9he.jar -s:edition XSLT/am-elements.xsl -o:edition2
    -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ex[not(preceding-sibling::*[name() eq 'am'])]">
        <xsl:element name="am">
            <xsl:if
                test="matches(., '^ue$') and ./preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^e$') and ./preceding-sibling::text()[1][matches(., 'm$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^ue$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^e$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'm$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^u$') and ./preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^u$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^eu$') and ./preceding-sibling::text()[1][matches(., 'd$')]">
                <xsl:text>&#8217;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^eu$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'd$')]">
                <xsl:text>&#8217;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^ro$') and ./preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#807;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^ro$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#807;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^er$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#818;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^er$') and ./preceding-sibling::text()[1][matches(., 'p$')]">
                <xsl:text>&#818;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^ri$')">
                <xsl:text>&#x365;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^ui$')">
                <xsl:text>&#x365;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^&#771;$')">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="
                current()[not(parent::seg)]/matches(., '^e$') and current()[count(preceding-sibling::node()) eq 0]
                and current()[count(following-sibling::node()) eq 0]">
                <xsl:text>&#8266;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^ser$')">
                <xsl:text>&#7836;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^n$')">
                <xsl:text>&#772;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^ra$')">
                <xsl:text>&#x1DD3;</xsl:text>
            </xsl:if>            
            <xsl:if test="matches(., '^ar$')">
                <xsl:text>&#x1DD3;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^re$')">
                <xsl:text>&#x1DD3;</xsl:text>
            </xsl:if>  
            <xsl:if
                test="matches(., '^ro$') and ./not(matches(preceding-sibling::text()[1], 'p$')) and 
                ./not(matches(parent::seg/preceding-sibling::text()[1], 'p$'))">
                <xsl:text>ᵒ</xsl:text>
            </xsl:if>            
            <xsl:if
                test="matches(., '^er$') and ./not(matches(preceding-sibling::text()[1], 'p$')) and 
                ./not(matches(parent::seg/preceding-sibling::text()[1], 'p$'))">
                <xsl:text>&#x035B;</xsl:text>
            </xsl:if>
            <xsl:if
                test="current()[ancestor::rdg[contains(@wit, '#A')]]/matches(., '^or$')
                or current()[ancestor::rdg[contains(@wit, '#T')]]/matches(., '^or$')
                or current()[ancestor::rdg[contains(@wit, '#N')]]/matches(., '^or$')">
                <xsl:attribute name="rendition">superscript</xsl:attribute>
                <xsl:text>&#42843;</xsl:text>
            </xsl:if>
            <xsl:if
                test="current()[ancestor::rdg[contains(@wit, '#B')]]/matches(., '^or$')
                or current()[ancestor::rdg[contains(@wit, '#V')]]/matches(., '^or$')">
                <xsl:text>&#8337;</xsl:text>
            </xsl:if>
            
            <xsl:if test="matches(., '^us$')">
                <xsl:text>&#42863;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^os$')">
                <xsl:text>&#42863;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^con$')">
                <xsl:text>&#42863;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^contra$')">
                <xsl:text>&#42862;&#772;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^uan$') and ./preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#x1DD3;&#x0338;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^uan$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#x1DD3;&#x0321;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^uen$') and ./preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#771;&#x0321;</xsl:text>
            </xsl:if>
            <xsl:if
                test="matches(., '^uen$') and ./parent::seg/preceding-sibling::text()[1][matches(., 'q$')]">
                <xsl:text>&#771;&#x0321;</xsl:text>
            </xsl:if>
            <xsl:if test="matches(., '^ua$')">
                <xsl:text>&#x1DD3;</xsl:text>
            </xsl:if>
        </xsl:element>
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>
