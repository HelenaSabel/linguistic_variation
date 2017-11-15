<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:variable name="ling-features"
        select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'linguistic']]"/>
    <xsl:variable name="errors"
        select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'error']]"/>
    <xsl:variable name="equip"
        select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'equipolent']]"/>
    <xsl:variable name="material"
        select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'material']]"/>
    <xsl:variable name="graphic"
        select="doc('../ancillary/feature-library.xml')//tei:fLib[@xml:id eq 'graphic']/tei:f[not(@xml:id eq 'abb')]"/>
    <xsl:variable name="apos">'</xsl:variable>
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
                    <xsl:if
                        test="substring($ana, 2) = $errors/@xml:id and current()/not(descendant::tei:gap)">
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
                        <xsl:element name="span">
                            <xsl:attribute name="class">error gl</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of
                                    select="$errors[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'gl']/text()"
                                />
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:if>
                    <xsl:if
                        test="substring($ana, 2) = $errors/@xml:id and current()/descendant::tei:gap">
                        <xsl:apply-templates/>
                    </xsl:if>
                    <xsl:if test="substring($ana, 2) = $material/@xml:id">
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
                        <xsl:element name="span">
                            <xsl:attribute name="class">linguistic gl</xsl:attribute>
                            <xsl:attribute name="data-exp">
                                <xsl:value-of
                                    select="$ling-features[@xml:id = substring($ana, 2)]//tei:string[@xml:lang = 'gl']/text()"
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
                                <xsl:element name="span">
                                    <xsl:attribute name="class">equipolent gl</xsl:attribute>
                                    <xsl:attribute name="data-exp">
                                        <xsl:value-of
                                            select="$equip[@xml:id = substring($ana, 2)]//tei:string[@xml:lang eq 'gl']/text()"
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
                    <xsl:if test="substring($ana, 2) = 'abb'">
                        <xsl:apply-templates/>
                    </xsl:if>
                </xsl:if>
                <xsl:if
                    test="current()/descendant::tei:seg and count($ana) ne count(descendant::tei:seg)">
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
    <xsl:template match="tei:seg[contains(@corresp, ' ')]">
        <span class="graphic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:seg[not(contains(@corresp, ' '))]">
        <xsl:choose>
            <xsl:when
                test="substring(@corresp, 2) = $errors/@xml:id and current()/not(descendant::tei:gap)">
                <xsl:element name="span">
                    <xsl:attribute name="class">error en</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of
                            select="$errors[@xml:id = current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'en']/text()"
                        />
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">error pt</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of
                            select="$errors[@xml:id = current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'pt']/text()"
                        />
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="span">
                    <xsl:attribute name="class">error gl</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of
                            select="$errors[@xml:id = current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'gl']/text()"
                        />
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when
                test="substring(@corresp, 2) = $errors/@xml:id and current()/descendant::tei:gap">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = $ling-features/@xml:id">
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
                <xsl:element name="span">
                    <xsl:attribute name="class">linguistic gl</xsl:attribute>
                    <xsl:attribute name="data-exp">
                        <xsl:value-of
                            select="$ling-features[@xml:id eq current()/substring(@corresp, 2)]//tei:string[@xml:lang eq 'gl']/text()"
                        />
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
    <xsl:template match="tei:ex">
        <xsl:choose>
            <xsl:when test="ancestor::tei:rdg[contains(@ana, '#abb')]">
                <span class="ex graphic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="ex">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:am">
        <xsl:choose>
            <xsl:when test="ancestor::tei:rdg[contains(@ana, '#abb')]">
                <span class="graphic">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
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
        <span class="am">
            <xsl:apply-templates select="tei:abbr"/>
        </span>
        <span class="expansion">
            <xsl:apply-templates select="tei:expan"/>
        </span>        
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="tei:del">
        <xsl:element name="del">
            <xsl:attribute name="class">
                <xsl:value-of select="@rend"/>
                <xsl:text> hide</xsl:text>
            </xsl:attribute>
            <xsl:text>(</xsl:text>
            <xsl:choose>
                <xsl:when test="contains(@rend, 'underdot') and contains(@rend, 'overstrike')">
                    <xsl:value-of
                        select="
                            string-join(for $i in string-to-codepoints(.)
                            return
                                concat(codepoints-to-string($i), '̶̣'), '')"
                    />
                </xsl:when>
                <xsl:when test="contains(@rend, 'underdot')">
                    <xsl:value-of
                        select="
                            string-join(for $i in string-to-codepoints(.)
                            return
                                concat(codepoints-to-string($i), '̣'), '')"
                    />
                </xsl:when>
                <xsl:when test="contains(@rend, 'overstrike')">
                    <xsl:value-of
                        select="
                            string-join(for $i in string-to-codepoints(.)
                            return
                                concat(codepoints-to-string($i), '̶'), '')"
                    />
                </xsl:when>
                <xsl:when test="contains(@rend, 'multiple-overstrike')">
                    <xsl:value-of
                        select="
                            string-join(for $i in string-to-codepoints(.)
                            return
                                concat(codepoints-to-string($i), '̶̸'), '')"
                    />
                </xsl:when>
                <xsl:when test="tei:gap">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>pt</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-exp">
                            <xsl:if test="tei:gap[@reason eq 'damage']">
                                <xsl:text>Omissão provocada pelo estado de conservação do testemunho</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'illegible']">
                                <xsl:text>Trecho ilegível</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="tei:gap/@quantity and tei:gap/@unit eq 'chars'">
                                <xsl:for-each select="1 to tei:gap/@quantity">
                                    <xsl:text>*</xsl:text>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>gl</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-exp">
                            <xsl:if test="tei:gap[@reason eq 'damage']">
                                <xsl:text>Omisión provocada polo estado de conservación do testemuño</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'illegible']">
                                <xsl:text>Trecho ilexíbel</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="tei:gap/@quantity and tei:gap/@unit eq 'chars'">
                                <xsl:for-each select="1 to tei:gap/@quantity">
                                    <xsl:text>*</xsl:text>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>en</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-exp">
                            <xsl:if test="tei:gap[@reason eq 'damage']">
                                <xsl:text>Damaged witness</xsl:text>
                            </xsl:if>
                            <xsl:if test="tei:gap[@reason eq 'illegible']">
                                <xsl:text>Illegible</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="tei:gap/@quantity and tei:gap/@unit eq 'chars'">
                                <xsl:for-each select="1 to tei:gap/@quantity">
                                    <xsl:text>*</xsl:text>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
        </xsl:element>
    </xsl:template>
    <!--    <xsl:template match="tei:milestone[@type eq 'begin']">
        <ins class="{@rend}">
            <xsl:apply-templates
                select="current()/following::node()[ancestor::tei:rdg[contains(@wit, current()/ancestor::tei:rdg/@wit)]] 
                except (current()/following::tei:milestone[@type eq 'end'][1]/following::node())"
            />
        </ins>
    </xsl:template>-->
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
            <xsl:choose>
                <xsl:when test="@reason eq 'error'">
                    <xsl:text>∅</xsl:text>
                </xsl:when>
                <xsl:when test="@reason eq 'damage' or @reason eq 'illegible'">
                    <xsl:text>⁅</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@quantity and @unit eq 'chars'">
                            <xsl:for-each select="1 to @quantity">
                                <xsl:text>*</xsl:text>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>⁆</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>[ ]</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
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
            <xsl:choose>
                <xsl:when test="@reason eq 'error'">
                    <xsl:text>∅</xsl:text>
                </xsl:when>
                <xsl:when test="@reason eq 'damage' or @reason eq 'illegible'">
                    <xsl:text>⁅</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@quantity and @unit eq 'chars'">
                            <xsl:for-each select="1 to @quantity">
                                <xsl:text>*</xsl:text>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>⁆</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>[ ]</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
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
            <xsl:choose>
                <xsl:when test="@reason eq 'error'">
                    <xsl:text>∅</xsl:text>
                </xsl:when>
                <xsl:when test="@reason eq 'damage' or @reason eq 'illegible'">
                    <xsl:text>⁅</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@quantity and @unit eq 'chars'">
                            <xsl:for-each select="1 to @quantity">
                                <xsl:text>*</xsl:text>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>⁆</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>[ ]</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:note"/>
    <xsl:template match="tei:hi">
        <span class="pt gl" data-exp="Letra de espera">
            <xsl:value-of select="."/>
        </span>
        <span class="en" data-exp="Guide letter">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <span class="supplied hide">’</span>
    </xsl:template>
    <xsl:template match="tei:subst">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
</xsl:stylesheet>
