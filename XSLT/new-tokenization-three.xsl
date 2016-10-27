<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- Stylesheet to tokenize a parallel segmentated transcription.
        
        Input:
            
            <l n="6">
                <app>
                    <rdg wit="#A">tanto uiuer per nulla ren</rdg>
                    <rdg wit="#B">tanto muer per nulha re<ex>n</ex></rdg>
                    <rdg wit="#V">tanto ouuer per nulla te<ex>n</ex></rdg>
                </app>
            </l>
        
        Output:
            <l n="6">
                tanto
                <app>
                    <rdg wit="#A">uiuer</rdg>
                    <rdg wit="#B">muer</rdg>
                    <rdg wit="#V">ouuer</rdg>
                </app>
                per 
                <app>
                    <rdg wit="#A #V">nulla</rdg>
                    <rdg wit="#B">nulha</rdg>
                </app>
                <app>
                    <rdg wit="#A">ren</rdg>
                    <rdg wit="#B">re<ex>n</ex></rdg>
                    <rdg wit="#V">te<ex>n</ex></rdg>
                </app>
            </l>
        
        We transform any children of <rdg> to strings before doing the tokenization.
     -->
    
    
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
    <xsl:template match="comment()" mode="string">
        <xsl:comment select="."/>
    </xsl:template>
    <!-- Elements with children but no attributes-->
    <xsl:template match="supplied|ex[not(supplied)]|am|add[not(@*)]|del[not(@*)]|unclear" mode="string">
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
        <xsl:choose>
            <xsl:when test="current()[@reason]">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>    
        <xsl:for-each select="@*">            
            <!-- Since we used white spaces to delimit the tokens, we introduced here an 
                asterisk instead that is replaced later on-->
            <xsl:text>_</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="current()"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>/&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>/&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Elements with attributes and children-->
    <xsl:template match="hi|del[@*]|add[@*]" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="@*">
            <xsl:text>_</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="current()"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:choose>
            <xsl:when test="contains(., ' ')">
                <xsl:value-of select="replace(., ' ', '_')"/>
            </xsl:when>
            <xsl:otherwise>                
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="choice" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="ex/supplied" mode="string">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="reg | orig">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="text()[parent::orig | parent::reg | parent::del | parent::add | parent::ex]">
        <xsl:value-of select="replace(., ' ', '_')"/>
    </xsl:template>
    <xsl:template match="orig/ex | orig/am | reg/ex | reg/am | del/ex | del/am | add/ex | add/am | reg/supplied">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="orig/hi|reg/hi">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="@*">
            <xsl:text>_</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="current()"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates/>
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
    
    <xsl:template match="comment()" mode="tokens">
        <xsl:comment select="."/>
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
                    <xsl:element name="app">
                        <xsl:element name="rdg">
                            <xsl:attribute name="wit">#A #B #V</xsl:attribute>
                    <xsl:value-of
                        select="insert-before(replace($Atokens[current()], '_', ' '), 2, '')"
                        disable-output-escaping="yes"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$Btokens[current()] eq $Vtokens[current()] and $Btokens[current()] ne $Atokens[current()]">
                    <app>
                        <rdg wit="#A"><xsl:value-of select="replace($Atokens[current()], '_', ' ')"
                            disable-output-escaping="yes"/></rdg>
                        <rdg wit="#B #V"><xsl:value-of select="replace($Btokens[current()], '_', ' ')"
                            disable-output-escaping="yes"/></rdg>
                    </app>
                </xsl:when>
                <xsl:when test="$Btokens[current()] eq $Atokens[current()] and $Btokens[current()] ne $Vtokens[current()]">
                    <app>
                        <rdg wit="#A #B"><xsl:value-of select="replace($Atokens[current()], '_', ' ')"
                            disable-output-escaping="yes"/></rdg>
                        <rdg wit="#V"><xsl:value-of select="replace($Vtokens[current()], '_', ' ')"
                            disable-output-escaping="yes"/></rdg>
                    </app>
                </xsl:when>
                <xsl:when test="$Atokens[current()] eq $Vtokens[current()] and $Btokens[current()] ne $Vtokens[current()]">
                    <app>
                        <rdg wit="#A #V"><xsl:value-of select="replace($Atokens[current()], '_', ' ')"
                            disable-output-escaping="yes"/></rdg>
                        <rdg wit="#B"><xsl:value-of select="replace($Btokens[current()], '_', ' ')"
                            disable-output-escaping="yes"/></rdg>
                    </app>
                </xsl:when>
                <xsl:otherwise>
                    <app>
                        <rdg wit="#A">
                            <xsl:choose>
                                <xsl:when test="$Atokens[current()]">
                                    <xsl:value-of select="replace($Atokens[current()], '_', ' ')"
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
                                    <xsl:value-of select="replace($Btokens[current()], '_', ' ')"
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
                                    <xsl:value-of select="replace($Vtokens[current()],'_', ' ')"
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
