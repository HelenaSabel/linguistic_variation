<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:variable name="ling-features" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'linguistic']]"/>
    <xsl:variable name="errors" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'error']]"/>
    <xsl:variable name="equip" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'equipolent']]"/>
    <xsl:variable name="material" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'material']]"/>
    <xsl:variable name="graphic" select="doc('../ancillary/feature-library.xml')//tei:fLib[@xml:id eq 'graphic']/tei:f[not(@xml:id eq 'abb')]"/>
    
    
    <!--          This creates a problem!
                    
                    <l n="20">
                        <app>
                            <rdg wit="#A" ana="#reg">fi<seg corresp="#reg">ll</seg>ar por mi</rdg>
                            <rdg wit="#B" ana="#trans #j-minin"><seg corresp="#trans">p<am>ᷣ</am>
                                <ex>or</ex> m<seg corresp="#j-minin">j</seg> filhar</seg></rdg>
                        </app>
                        <app>
                            <rdg wit="#A #B">e</rdg>
                        </app>
                        <app>
                            <rdg wit="#A" ana="#reg #reg">
                                <choice>
                                    <orig>to<seg corresp="#reg">ll</seg>er<seg corresp="#reg">ll</seg>ey</orig>
                                    <reg>to<seg corresp="#reg">ll</seg>er-<seg corresp="#reg">ll</seg>
                                        <supplied>?</supplied>-ey</reg>
                                </choice>
                            </rdg>
                            <rdg wit="#B" ana="#abb #equip">tolh<am>͛</am>
                                <ex>er</ex>ey</rdg>
                        </app>
                    </l>-->
    
    
    
    <xsl:param name="wit"/>
    <xsl:param name="line"/>
    <xsl:template match="tei:lg">
        <ol class="{@type}">
            <xsl:apply-templates select="tei:l"/>
        </ol>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:element name="li">
            <xsl:if test="current()/@type">
                <xsl:attribute name="class">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="current()[@n = $line]">
                <xsl:attribute name="id">highlight</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="tei:app/tei:rdg[contains(@wit, $wit)]"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:variable name="ana" select="tokenize(@ana, '\s+')"/>
        <xsl:choose>
            <xsl:when test="@ana">
                <xsl:if test="count($ana) eq 1 and current()/not(descendant::tei:seg)">
                    <xsl:if test="substring($ana, 2) = $errors/@xml:id and current()/not(descendant::tei:gap)">
                        <xsl:element name="span">
                            <xsl:attribute name="class">error en</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of select="$errors[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'en']/text()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:element name="span">
                            <xsl:attribute name="class">error pt</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of select="$errors[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'pt']/text()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:element name="span">
                            <xsl:attribute name="class">error gl</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of select="$errors[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'gl']/text()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $errors/@xml:id and current()/descendant::tei:gap">
                        <xsl:apply-templates/>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $material/@xml:id and current()/descendant::tei:gap">
                        <xsl:apply-templates/>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $ling-features/@xml:id">
                        <xsl:element name="span">
                            <xsl:attribute name="class">linguistic en</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of select="$ling-features[@xml:id = substring($ana, 2)]//tei:string[@xml:lang = 'en']/text()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:element name="span">
                            <xsl:attribute name="class">linguistic pt</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of select="$ling-features[@xml:id = substring($ana, 2)]//tei:string[@xml:lang = 'pt']/text()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:element name="span">
                            <xsl:attribute name="class">linguistic gl</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of select="$ling-features[@xml:id = substring($ana, 2)]//tei:string[@xml:lang = 'gl']/text()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $equip/@xml:id">
                        <xsl:choose>
                            <xsl:when test="$ana eq '#equip'">
                                <xsl:element name="span">
                                    <xsl:attribute name="class">equipolent en</xsl:attribute>
                                    <xsl:attribute name="data-exp">
                                        <xsl:value-of select="$equip[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'en']/text()"/>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                                <xsl:element name="span">
                                    <xsl:attribute name="class">equipolent pt</xsl:attribute>
                                    <xsl:attribute name="data-exp">
                                        <xsl:value-of select="$equip[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'pt']/text()"/>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                                <xsl:element name="span">
                                    <xsl:attribute name="class">equipolent gl</xsl:attribute>
                                    <xsl:attribute name="data-exp">
                                        <xsl:value-of select="$equip[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'gl']/text()"/>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $graphic/@xml:id">
                        <span class="graphic">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = 'abb'">
                        <xsl:apply-templates/>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="current()/descendant::tei:seg and count($ana) ne count(descendant::tei:seg)">
                    <xsl:choose>
                        <xsl:when test="contains(@ana, '#equip')">
                            <span class="rev en" data-exp="Divergent reading">
                                <xsl:apply-templates/>
                            </span>
                            <span class="rev pt" data-exp="Lição divergente">
                                <xsl:apply-templates/>
                            </span>
                            <span class="rev gl" data-exp="Lección diverxente">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="count($ana) eq count(descendant::tei:seg)">
                    <xsl:apply-templates/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="text()[following-sibling::node()[1][self::tei:am]] | text()[following-sibling::node()[1][self::tei:seg][child::node()[1][self::tei:am]]]">
        <xsl:value-of select="replace(., '\w$', '')"/>
    </xsl:template>
    <xsl:template match="tei:seg[contains(@corresp, ' ')]">
        <span class="graphic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:seg[not(contains(@corresp, ' '))]">
        <xsl:choose>
            <xsl:when test="substring(@corresp, 2) = $errors/@xml:id and current()/not(descendant::tei:gap)">
                <xsl:element name="span">
                    <xsl:attribute name="class">error en</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of select="$errors[@xml:id = current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'en']/text()"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">error pt</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of select="$errors[@xml:id = current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'pt']/text()"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">error gl</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of select="$errors[@xml:id = current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'gl']/text()"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = $errors/@xml:id and current()/descendant::tei:gap">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = $ling-features/@xml:id">
                <xsl:element name="span">
                    <xsl:attribute name="class">linguistic en</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of select="$ling-features[@xml:id eq current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'en']/text()"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">linguistic pt</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of select="$ling-features[@xml:id eq current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'pt']/text()"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">linguistic gl</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of select="$ling-features[@xml:id eq current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'gl']/text()"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = 'equip'">
                <xsl:element name="span">
                    <xsl:attribute name="class">equipolent en</xsl:attribute>
                    <xsl:attribute name="data-exp">Divergent reading</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">equipolent pt</xsl:attribute>
                    <xsl:attribute name="data-exp">Lição divergente</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">equipolent gl</xsl:attribute>
                    <xsl:attribute name="data-exp">Lección diverxente</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = $graphic/@xml:id">
                <span class="graphic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:am[ancestor::tei:rdg[not(contains(@ana, '#abb'))]]">
        <xsl:variable name="am" select="current()"/>
        <xsl:choose>
            <xsl:when test=". = ('̅', '̄', '̧', '̲', 'ͥ', 'ᷓ', '͛', '̡ᷓ', '̡̃')">
                <xsl:if test=".[preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="am">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="am">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::tei:seg]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1]/child::node()[last()][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="am">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <span class="expansion">
                    <xsl:if test=".[preceding-sibling::node()[1][self::text()]]">
                        <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                            <xsl:matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:if>
                    <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                        <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                            <xsl:matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:if>
                    <xsl:if test="current()[. ne '̅']">
                        <span class="ex">
                            <xsl:value-of select="current()/following-sibling::tei:ex[1]/text()"/>
                        </span>
                    </xsl:if>
                    <xsl:if test="current()[. eq '̅']">
                        <span class="ex">
                            <xsl:value-of select="current()/preceding-sibling::tei:ex[1]/text()"/>
                        </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="current()[preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:if test="current()/@rendition">
                            <xsl:value-of select="concat(@rendition, ' ')"/>
                        </xsl:if>
                        <xsl:text>am</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="current()"/>
                </xsl:element>
                <span class="ex expansion">
                    <xsl:value-of select="current()/following-sibling::tei:ex[1]/text()"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ex"/>
    <xsl:template match="tei:am[ancestor::tei:rdg[contains(@ana, '#abb')]]">
        <xsl:variable name="am" select="current()"/>
        <xsl:choose>
            <xsl:when test=". = ('̅', '̄', '̧', '̲', 'ͥ', 'ᷓ', '͛', '̡ᷓ', '̡̃')">
                <xsl:if test=".[preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="am graphic">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="am graphic">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::tei:seg]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1]/child::node()[last()][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="am graphic">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <span class="expansion">
                    <xsl:if test=".[preceding-sibling::node()[1][self::text()]]">
                        <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                            <xsl:matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:if>
                    <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                        <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                            <xsl:matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:if>
                    <xsl:if test="current()[. ne '̅']">
                        <span class="ex graphic">
                            <xsl:value-of select="current()/following-sibling::tei:ex[1]/text()"/>
                        </span>
                    </xsl:if>
                    <xsl:if test="current()[. eq '̅']">
                        <span class="ex graphic">
                            <xsl:value-of select="current()/preceding-sibling::tei:ex[1]/text()"/>
                        </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="current()[preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:if test="current()/@rendition">
                            <xsl:value-of select="concat(@rendition, ' ')"/>
                        </xsl:if>
                        <xsl:text>am graphic</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="current()"/>
                </xsl:element>
                <span class="ex expansion graphic">
                    <xsl:value-of select="current()/following-sibling::tei:ex[1]/text()"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:choice">
        <span class="reg">
            <xsl:apply-templates select="tei:reg"/>
        </span>
        <span class="orig">
            <xsl:apply-templates select="tei:orig"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:del">
        <xsl:element name="del">
            <xsl:attribute name="class">
                <xsl:value-of select="@rend"/>
                <xsl:text> hide</xsl:text>
            </xsl:attribute>
            <xsl:text>(</xsl:text>
            <xsl:choose>
                <xsl:when test="contains(@rend, 'underdot')">
                    <xsl:value-of select="                             string-join(for $i in string-to-codepoints(.)                             return                                 concat(codepoints-to-string($i), '̣'), '')"/>
                </xsl:when>
                <xsl:when test="contains(@rend, 'multiple-overstrike')">
                    <xsl:value-of select="                             string-join(for $i in string-to-codepoints(.)                             return                                 concat(codepoints-to-string($i), '̸'), '')"/>
                </xsl:when>
                <xsl:when test="tei:gap">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>gap pt</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-exp">
                            <xsl:if test="tei:gap[@reason eq 'error']">
                                <xsl:text>Erro de cópia</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'economy']">
                                <xsl:text>Omissão de conteúdos repetidos</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'unknown']">
                                <xsl:text>Omissão de origem desconhecida</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'damage']">
                                <xsl:text>Omissão provocada pelo estado de conservação do testemunho</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'illegible']">
                                <xsl:text>Trecho ilegível</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'model']">
                                <xsl:text>Provavelmente, omissão presente no modelo</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'unfinished']">
                                <xsl:text>Testemunho inacabado</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:text> </xsl:text>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>gap gl</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-exp">
                            <xsl:if test="tei:gap[@reason eq 'error']">
                                <xsl:text>Erro de copia</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'economy']">
                                <xsl:text>Omisión de contidos repetidos</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'unknown']">
                                <xsl:text>Omisión de orixe descoñecida</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'damage']">
                                <xsl:text>Omisión provocada polo estado de conservación do testemuño</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'illegible']">
                                <xsl:text>Trecho ilexíbel</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'model']">
                                <xsl:text>Probabelmente, omisión presente no modelo</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'unfinished']">
                                <xsl:text>Testemuño inacabado</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:text> </xsl:text>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>gap en</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-exp">
                            <xsl:if test="tei:gap[@reason eq 'error']">
                                <xsl:text>Scribal error</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'economy']">
                                <xsl:text>Omission of repeated contents</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'unknown']">
                                <xsl:text>Unknown reason for omission</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'damage']">
                                <xsl:text>Damaged witness</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'illegible']">
                                <xsl:text>Illegivel</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'model']">
                                <xsl:text>Likely, omission present in the model of this witness</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'unfinished']">
                                <xsl:text>Unfinished witness</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:text> </xsl:text>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:add">
        <xsl:element name="ins">
            <xsl:attribute name="class">
                <xsl:value-of select="@place"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:gap[not(parent::tei:del)]">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>gap pt</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-exp">
                <xsl:if test="@reason eq 'error'">
                    <xsl:text>Erro de cópia</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'economy'">
                    <xsl:text>Omissão de conteúdos repetidos</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'unknown'">
                    <xsl:text>Omissão de origem desconhecida</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'damage'">
                    <xsl:text>Omissão provocada pelo estado de conservação do testemunho</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'illegible'">
                    <xsl:text>Trecho ilegível</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'model'">
                    <xsl:text>Provavelmente, omissão presente no modelo</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'unfinished'">
                    <xsl:text>Testemunho inacabado</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:text>[ ]</xsl:text>
        </xsl:element>
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>gap gl</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-exp">
                <xsl:if test="@reason eq 'error'">
                    <xsl:text>Erro de copia</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'economy'">
                    <xsl:text>Omisión de contidos repetidos</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'unknown'">
                    <xsl:text>Omisión de orixe descoñecida</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'damage'">
                    <xsl:text>Omisión provocada polo estado de conservación do testemuño</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'illegible'">
                    <xsl:text>Trecho ilexíbel</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'model'">
                    <xsl:text>Probabelmente, omisión presente no modelo</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'unfinished'">
                    <xsl:text>Testemuño inacabado</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:text>[ ]</xsl:text>
        </xsl:element>
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>gap en</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-exp">
                <xsl:if test="@reason eq 'error'">
                    <xsl:text>Scribal error</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'economy'">
                    <xsl:text>Omission of repeated contents</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'unknown'">
                    <xsl:text>Unknown reason for omission</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'damage'">
                    <xsl:text>Damaged witness</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'illegible'">
                    <xsl:text>Illegivel</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'model'">
                    <xsl:text>Likely, omission present in the model of this witness</xsl:text>
                </xsl:if>
                <xsl:if test="@reason eq 'unfinished'">
                    <xsl:text>Unfinished witness</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:text>[ ]</xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:hi">
        <sup class="pt gl" data-exp="Letra de espera">
            <xsl:value-of select="."/>
        </sup>
        <sup class="en" data-exp="Guide letter">
            <xsl:value-of select="."/>
        </sup>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <span class="supplied hide">’</span>
    </xsl:template>
    <xsl:template match="tei:subst">
        <xsl:apply-templates select="*"/>
    </xsl:template>
</xsl:stylesheet>