<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="ling-features"
        select="doc('../ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#linguistic']/tei:fs"/>
    <xsl:variable name="errors"
        select="doc('../ancillary/feature-library.xml')//tei:fvLib[@corresp eq '#scribal']/tei:fs"/>
    <xsl:variable name="equip"
        select="doc('../ancillary/feature-library.xml')//tei:fvLib[@n eq 'equipolent readings']/tei:fs"/>
    <xsl:variable name="graphic"
        select="doc('../ancillary/feature-library.xml')//tei:fLib[@xml:id eq 'graphic']/tei:f"/>
    <xsl:param name="wit" as="xs:string"/>
    <xsl:template match="tei:lg">
        <ol start="{./tei:l[1]/@n}">
            <xsl:apply-templates select="tei:l"/>
        </ol>
    </xsl:template>
    <xsl:template match="tei:l">
        <li><xsl:apply-templates select="tei:app/tei:rdg[contains(@wit, $wit)]"/></li>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:variable name="ana" select="tokenize(@ana, '\s+')"/>
        <xsl:choose>
            <xsl:when test="@ana">
                <xsl:if test="count($ana) eq 1 and current()/not(tei:seg)">
                    <xsl:if test="substring($ana, 2) = $errors/@xml:id and current()/not(tei:gap)">
                        <xsl:element name="span">
                            <xsl:attribute name="class">error en</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of
                                    select="$errors[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'en']/text()"
                                />
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:element name="span">
                            <xsl:attribute name="class">error pt</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of
                                    select="$errors[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'pt']/text()"
                                />
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $errors/@xml:id and current()/tei:gap">
                        <xsl:apply-templates/>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $ling-features/@xml:id">
                        <xsl:element name="span">
                            <xsl:attribute name="class">linguistic en</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of
                                    select="$ling-features[@xml:id = substring($ana, 2)]//tei:string[@xml:lang = 'en']/text()"
                                />
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:element name="span">
                            <xsl:attribute name="class">linguistic pt</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of
                                    select="$ling-features[@xml:id = substring($ana, 2)]//tei:string[@xml:lang = 'pt']/text()"
                                />
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
                                        <xsl:value-of
                                            select="$equip[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'en']/text()"
                                        />
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                                <xsl:element name="span">
                                    <xsl:attribute name="class">equipolent pt</xsl:attribute>
                                    <xsl:attribute name="data-exp">
                                        <xsl:value-of
                                            select="$equip[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'pt']/text()"
                                        />
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
                </xsl:if>
                <xsl:if test="current()/tei:seg and count($ana) ne count(tei:seg)">
                    <xsl:choose>
                        <xsl:when test="contains(@ana, '#equip')">
                            <span class="rev en" data-exp="Equipolent reading">
                                <xsl:apply-templates/>
                            </span>
                            <span class="rev pt" data-exp="Lição equipolente">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="count($ana) eq count(tei:seg)">
                    <xsl:apply-templates/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template
        match="text()[following-sibling::node()[1][self::tei:am]] | text()[following-sibling::node()[1][self::tei:seg[@corresp eq '#abb']]]">
        <xsl:value-of select="replace(., '\w$', '')"/>
    </xsl:template>
    <xsl:template match="tei:seg">
        <xsl:if test="substring(@corresp, 2) = $errors/@xml:id and current()/not(tei:gap)">
            <xsl:element name="span">
                <xsl:attribute name="class">error en</xsl:attribute>
                <xsl:attribute name="data-exp">
                    <xsl:value-of
                        select="$errors[@xml:id = substring(@corresp, 2)]//tei:string[@xml:lang eq 'en']/text()"
                    />
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:element name="span">
                <xsl:attribute name="class">error pt</xsl:attribute>
                <xsl:attribute name="data-exp">
                    <xsl:value-of
                        select="$errors[@xml:id = substring(@corresp, 2)]//tei:string[@xml:lang eq 'pt']/text()"
                    />
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="substring(@corresp, 2) = $errors/@xml:id and current()/tei:gap">
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="substring(@corresp, 2) = $ling-features/@xml:id">
            <xsl:element name="span">
                <xsl:attribute name="class">linguistic en</xsl:attribute>
                <xsl:attribute name="data-exp">
                    <xsl:value-of
                        select="$ling-features[@xml:id eq current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'en']/text()"
                    />
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:element name="span">
                <xsl:attribute name="class">linguistic pt</xsl:attribute>
                <xsl:attribute name="data-exp">
                    <xsl:value-of
                        select="$ling-features[@xml:id eq current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'pt']/text()"
                    />
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="substring(@corresp, 2) = 'equip'">
            <xsl:element name="span">
                <xsl:attribute name="class">equipolent en</xsl:attribute>
                <xsl:attribute name="data-exp">Equipolent reading</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:element name="span">
                <xsl:attribute name="class">equipolent pt</xsl:attribute>
                <xsl:attribute name="data-exp">Lição equipolente</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="substring(@corresp, 2) = $graphic/@xml:id">
            <span class="graphic">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:am"><xsl:variable name="am" select="current()"/><xsl:choose><xsl:when test=". = ('̄', '̧', '̲', 'ͥ', 'ᷓ', '͛', 'ᷓ&#x0321;', '̡̃')"><xsl:if test=".[preceding-sibling::node()[1][self::text()]]"><xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$"><xsl:matching-substring><span class="am"><xsl:value-of select="concat(., $am)"/></span></xsl:matching-substring></xsl:analyze-string></xsl:if><xsl:if test="current()[parent::tei:seg[@corresp eq '#abb']/preceding-sibling::node()[1][self::text()]]"><xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$"><xsl:matching-substring><span class="am"><xsl:value-of select="concat(., $am)"/></span></xsl:matching-substring></xsl:analyze-string></xsl:if><xsl:if test="current()[parent::tei:seg[@corresp eq '#abb']/preceding-sibling::node()[1][self::tei:seg]]"><xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1]/child::node()[last()][self::text()]" regex="\w$"><xsl:matching-substring><span class="am"><xsl:value-of select="concat(., $am)"/></span></xsl:matching-substring></xsl:analyze-string></xsl:if><span class="expansion"><xsl:if test="current()[preceding-sibling::node()[1][self::text()]]"><xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$"><xsl:matching-substring><xsl:value-of select="."/></xsl:matching-substring></xsl:analyze-string></xsl:if><xsl:if test="current()[parent::tei:seg[@corresp eq '#abb']][preceding-sibling::node()[1][self::text()]]"><xsl:analyze-string select="./parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$"><xsl:matching-substring><xsl:value-of select="."/></xsl:matching-substring></xsl:analyze-string></xsl:if><span class="ex"><xsl:value-of select="current()/following-sibling::tei:ex[1]"/></span></span></xsl:when><xsl:otherwise><xsl:if test="current()[preceding-sibling::node()[1][self::text()]]"><xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]"
                        regex="\w$"><xsl:matching-substring><xsl:value-of select="."/></xsl:matching-substring></xsl:analyze-string></xsl:if><xsl:if test="current()[parent::tei:seg[@corresp eq '#abb']/preceding-sibling::node()[1][self::text()]]"><xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$"><xsl:matching-substring><xsl:value-of select="."/></xsl:matching-substring></xsl:analyze-string></xsl:if><xsl:element name="span"><xsl:attribute name="class"><xsl:if test="current()/@rendition"><xsl:value-of select="concat(@rendition, ' ')"/></xsl:if><xsl:text>am</xsl:text></xsl:attribute><xsl:value-of select="current()"/></xsl:element><span class="ex expansion"><xsl:value-of select="current()/following-sibling::tei:ex[1]"/></span></xsl:otherwise></xsl:choose></xsl:template><xsl:template match="tei:ex"/>
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
            <xsl:apply-templates/>
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
    <xsl:template match="tei:gap">
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
        <span class="pt" data-exp="Letra de espera">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>]</xsl:text>
        </span>
        <span class="en" data-exp="Guide letter">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <span class="supplied">’</span>
    </xsl:template>
</xsl:stylesheet>
