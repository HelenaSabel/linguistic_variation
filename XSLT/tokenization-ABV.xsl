<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- Stylesheet to tokenize a parallel segmentated transcription.
        Input:
        <l n="19">
            <app>
                <rdg wit="#A">por q<ex>ue</ex> me leixades assi</rdg>
                <rdg wit="#B">p<ex>or</ex> q<ex>ue</ex> me leixades assy</rdg>
            </app>
        </l>
        
        Output:
        <l n="19">
            <app>
                <rdg wit="#A">por</rdg>
                <rdg wit="#B">p<ex>or</ex></rdg>
            </app>
            q<ex>ue</ex> me leixades <app>
                <rdg wit="#A">assi</rdg>
                <rdg wit="#B">assy</rdg>
            </app>
        </l>
        
        We transform any children of <rdg> to strings before doing the tokenization.
        Credits: the insertion of <gap/> elements in the tokenization module was a contribution
        by David Birnbaum (djbpitt@gmail.com, http://www.obdurodon.org) -->
    
    
    <!-- Main template -->
    <xsl:template match="/">
        <xsl:variable name="string">
            <xsl:apply-templates mode="string"/>
        </xsl:variable>
        <xsl:apply-templates select="$string" mode="tokens"/>
    </xsl:template>
        
    <!-- String conversion -->    
    <xsl:template match="node()|@*" mode="string">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="string"/>
        </xsl:copy>
    </xsl:template>
    <!-- Elements with children but no attributes-->
    <xsl:template match="ex|am|add|del" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <!-- Empty elements with attributes-->
    <xsl:template match="gap" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:for-each select="@*">            
            <!-- Since we used white spaces to delimit the tokens, we introduced here an 
                asterisk instead that is replaced later on-->
            <xsl:text>*</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="current()"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>/&gt;</xsl:text>
    </xsl:template>
    <!-- Elements with attributes and children-->
    <xsl:template match="hi" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="@*">
            <xsl:text>*</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="current()"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    
    <!-- Tokenization -->
    <xsl:template match="node()|@*" mode="tokens">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" mode="tokens"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="app" mode="tokens">
        <xsl:variable name="Atokens" select="tokenize(rdg[@wit eq '#A'],'\s+')"/>
        <xsl:variable name="Btokens" select="tokenize(rdg[@wit eq '#B'],'\s+')"/>
        <xsl:variable name="Vtokens" select="tokenize(rdg[@wit eq '#V'],'\s+')"/>
        <xsl:variable name="count" select="max((count($Atokens),count($Btokens)))"/>
        <xsl:for-each select="1 to $count">
            <xsl:choose>
                <xsl:when test="$Atokens[current()] eq $Btokens[current()] and $Atokens[current()] eq $Vtokens[current()]">
                    <!-- Use of insert-before() to correct white spaces
                         The asterisk inserted in the string mode to demark the attributes
                         is converted here using replace()
                         The attribute @disable-output-escaping replaces the entities to angle brackets-->
                    <xsl:value-of
                        select="insert-before(replace($Atokens[current()], '\*', ' '), 2, '')"
                        disable-output-escaping="yes"/>
                </xsl:when>
                <xsl:when test="$Btokens[current()] eq $Vtokens[current()] and $Btokens[current()] ne $Atokens[current()]">
                    <app>
                        <rdg wit="#A"><xsl:value-of select="replace($Atokens[current()], '\*', ' ')"
                            disable-output-escaping="yes"/></rdg>
                        <rdg wit="#B #V"><xsl:value-of select="$Btokens[current()]"
                            disable-output-escaping="yes"/></rdg>
                    </app>
                </xsl:when>
                <xsl:otherwise>
                    <app>
                        <rdg wit="#A">
                            <xsl:choose>
                                <xsl:when test="$Atokens[current()]">
                                    <xsl:value-of select="replace($Atokens[current()], '\*', ' ')"
                                        disable-output-escaping="yes"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gap/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdg>
                        <rdg wit="#B">
                            <xsl:choose>
                                <xsl:when test="$Btokens[current()]">
                                    <xsl:value-of select="$Btokens[current()]"
                                        disable-output-escaping="yes"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gap/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdg>
                        <rdg wit="#V">
                            <xsl:choose>
                                <xsl:when test="$Vtokens[current()]">
                                    <xsl:value-of select="$Vtokens[current()]"
                                        disable-output-escaping="yes"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gap/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </rdg>
                    </app>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
