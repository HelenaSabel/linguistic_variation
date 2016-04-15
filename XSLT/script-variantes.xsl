<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:variable name="ana">
            <xsl:apply-templates mode="ana"/>
        </xsl:variable>
        <xsl:apply-templates select="$ana" mode="correction"/>
    </xsl:template>
    <xsl:template match="node()|@*" mode="ana">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="ana"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()" mode="ana">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="app[not(parent::title)][count(rdg) eq 2]" mode="ana">
        <xsl:element name="app">
            <xsl:element name="rdg">
                <xsl:attribute name="wit">
                    <xsl:value-of select="current()/rdg[1]/@wit"/>
                </xsl:attribute>
                <xsl:attribute name="ana">
                    <xsl:if test="rdg[1]/count(ex) gt rdg[2]/count(ex)">
                        <xsl:text>#abb</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1][descendant::hi/@rend='guide']">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1][del|add]">
                        <xsl:text>#rev</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], 'g(e|i)') and not(contains(rdg[2],'g'))">
                        <xsl:text>#g-cons</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], 'ç(e|i)') and not(contains(rdg[2],'ç'))">
                        <xsl:text>#çe</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'ff') and not(contains(rdg[2],'ff'))">
                        <xsl:text>#ff</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'us') and contains(rdg[2],'os')">
                        <xsl:text>#back-vow</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], 'n') and contains(rdg[2],'nh')">
                        <xsl:text>#reg</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'll') and contains(rdg[2],'lh')">
                        <xsl:text>#reg</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], '(e|a|o)i') and matches(rdg[2], '(e|a|o)y')">
                        <xsl:text>#y-dip</xsl:text>
                    </xsl:if>                      
                    <xsl:if test="contains(rdg[1], 'ui') and matches(rdg[2], 'o(y|i|j)')">
                        <xsl:text>#dip</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1]/gap[@reason='error']">
                        <xsl:text>#error</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1]/gap[@reason=('economy', 'damage')]">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>                    
                    <xsl:if test="rdg[2]/descendant::supplied and rdg[1]/not(descendant::supplied)">
                        <xsl:text>#syn</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], 'v') and not(contains(rdg[2],'v'))">
                        <xsl:text>#v</xsl:text>
                    </xsl:if>                     
                    <xsl:if test="matches(rdg[1], '[A-Z]') and not(matches(rdg[2], '[A-Z]'))">
                        <xsl:text>#capital</xsl:text>
                    </xsl:if> 
                    <xsl:if test="matches(rdg[1], 'm$') and not(matches(rdg[2], 'm$'))">
                        <xsl:text>#m-end</xsl:text>
                    </xsl:if> 
                    <xsl:if test="contains(rdg[1], '.')">
                        <xsl:text>#punct</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <xsl:sequence select="current()/rdg[1]/node()"/>
            </xsl:element>
            <xsl:if test="rdg[2]">
            <xsl:element name="rdg">
                <xsl:attribute name="wit">
                    <xsl:value-of select="current()/rdg[2]/@wit"/>
                </xsl:attribute>
                <xsl:attribute name="ana">
                    <xsl:if test="rdg[2]/count(ex) gt rdg[1]/count(ex)">
                        <xsl:text>#abb</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[2][add|del]">
                        <xsl:text>#rev</xsl:text>
                    </xsl:if>    
                    <xsl:if test="contains(rdg[2], 'ff') and not(contains(rdg[1],'ff'))">
                        <xsl:text>#ff</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1]/descendant::supplied and rdg[2]/not(descendant::supplied)">
                        <xsl:text>#syn</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], 'm(i|j)') and contains(rdg[2], 'mh')">
                        <xsl:text>#h-minin</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'mui') and contains(rdg[2], 'muj')">
                        <xsl:text>#uj</xsl:text>
                    </xsl:if>                    
                    <xsl:if test="contains(rdg[1], 'ui') and contains(rdg[2], 'uy')">
                        <xsl:text>#uy</xsl:text>
                    </xsl:if>     
                    <xsl:if test="contains(rdg[2], 'hu')">
                        <xsl:text>#h-monos</xsl:text>
                    </xsl:if>                    
                    <xsl:if test="matches(rdg[2], '[^l]hi')">
                        <xsl:text>#h-monos</xsl:text>
                    </xsl:if>
                    <xsl:if test="matches(rdg[1], '(m|n)i') and matches(rdg[2], '(m|n)j')">
                        <xsl:text>#j-minin</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'me') and matches(rdg[2], 'm(j|i)')">
                        <xsl:text>#dat</xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(rdg[1], 'lle') and matches(rdg[2], 'lh(i|j)')">
                        <xsl:text>#li</xsl:text>
                    </xsl:if>                    
                    <xsl:if test="matches(rdg[2], 'ç(e|i)') and not(contains(rdg[1],'ç'))">
                        <xsl:text>#çe</xsl:text>
                    </xsl:if> 
                    <xsl:if test="matches(rdg[2], 'v') and not(contains(rdg[1],'v'))">
                        <xsl:text>#v</xsl:text>
                    </xsl:if> 
                    <xsl:if test="matches(rdg[2], '^ho')">
                        <xsl:text>#h-et</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[2]/gap[@reason='error']">
                        <xsl:text>#error</xsl:text>
                    </xsl:if>
                    <xsl:if test="rdg[1]/gap[@reason=('economy', 'damage')]">
                        <xsl:text>#material</xsl:text>
                    </xsl:if>                     
                    <xsl:if test="matches(rdg[1], '(e|a|o)i') and matches(rdg[2], '(e|a|o)y')">
                        <xsl:text>#y-dip</xsl:text>
                    </xsl:if>                      
                    <xsl:if test="matches(rdg[2], '[A-Z]') and not(matches(rdg[1], '[A-Z]'))">
                        <xsl:text>#capital</xsl:text>
                    </xsl:if>                     
                    <xsl:if test="matches(rdg[2], 'm$') and not(matches(rdg[1], 'm$'))">
                        <xsl:text>#m-end</xsl:text>
                    </xsl:if> 
                </xsl:attribute>
                <xsl:sequence select="current()/rdg[2]/node()"/>
            </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="node()|@*" mode="correction">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="correction"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()" mode="correction">
        <xsl:comment select="."/>
    </xsl:template>
    <xsl:template match="rdg/@*" mode="correction">
        <xsl:attribute name="wit">
            <xsl:value-of select="../@wit"/>
        </xsl:attribute>
        <xsl:if test="../@ana ne ''">
        <xsl:attribute name="ana">
            <xsl:choose>
                <xsl:when test="matches(../@ana,'\w#')">
                    <xsl:value-of select="replace(../@ana,'(\w)#', '$1 #')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../@ana"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
