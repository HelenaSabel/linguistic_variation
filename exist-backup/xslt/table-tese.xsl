<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:variable name="ling-features" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'linguistic']]"/>
    <xsl:variable name="errors" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'error']]"/>
    <xsl:variable name="equip" select="doc('../ancillary/feature-library.xml')//tei:fs[tei:f[@name eq 'taxonomy']/tei:fs[@type eq 'equipolent']]"/>
    <xsl:variable name="graphic" select="doc('../ancillary/feature-library.xml')//tei:fLib[@xml:id eq 'graphic']/tei:f[not(@xml:id eq 'abb')]"/>
    <xsl:param name="wit"/>
    <xsl:template match="tei:l">
        <td>
            <xsl:value-of select="substring($wit, 2)"/>
        </td>
        <xsl:apply-templates select="tei:app/tei:rdg[contains(@wit, $wit)]"/>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:if test="../preceding-sibling::node()[1][self::tei:app]/not(tei:rdg[contains(@wit, $wit)])">
            <td/>
        </xsl:if>
        <td>
            <xsl:variable name="ana" select="tokenize(@ana, '\s+')"/>
            <xsl:choose>
                <xsl:when test="@ana">
                    <xsl:if test="count($ana) eq 1 and current()/not(descendant::tei:seg)">
                        <xsl:if test="substring($ana, 2) = $errors/@xml:id and current()/not(descendant::tei:gap)">
                            <xsl:element name="span">
                                <xsl:attribute name="class">error</xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="substring($ana, 2) = $errors/@xml:id and current()/descendant::tei:gap">
                            <xsl:apply-templates/>
                        </xsl:if>
                        <xsl:if test="substring($ana, 2) = $ling-features/@xml:id">
                            <xsl:element name="span">
                                <xsl:attribute name="class">linguistic</xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="substring($ana, 2) = $equip/@xml:id">
                            <xsl:choose>
                                <xsl:when test="$ana eq '#equip'">
                                    <xsl:element name="span">
                                        <xsl:attribute name="class">equipolent</xsl:attribute>
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
                                <span class="rev">
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
        </td>
    </xsl:template>
    <xsl:template match="text()[following-sibling::node()[1][self::tei:am]] | text()[following-sibling::node()[1][self::tei:seg][child::node()[1][self::tei:am]]]">
        <xsl:value-of select="replace(., '\w$', '')"/>
    </xsl:template>
    <xsl:template match="tei:seg">
        <xsl:choose>
            <xsl:when test="substring(@corresp, 2) = $errors/@xml:id and current()/not(descendant::tei:gap)">
                <xsl:element name="span">
                    <xsl:attribute name="class">error</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = $errors/@xml:id and current()/descendant::tei:gap">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = $ling-features/@xml:id">
                <xsl:element name="span">
                    <xsl:attribute name="class">linguistic</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="substring(@corresp, 2) = 'equip'">
                <xsl:element name="span">
                    <xsl:attribute name="class">equipolent</xsl:attribute>
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
    <xsl:template match="tei:am[ancestor::tei:rdg[contains(@ana, '#abb')]]">
        <xsl:variable name="am" select="current()"/>
        <xsl:choose>
            <xsl:when test=". = ('̅', '̄', '̧', '̲', 'ͥ', 'ᷓ', '͛', '̡ᷓ', '̡̃')">
                <xsl:if test=".[preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="./preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="graphic">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="graphic">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::tei:seg]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1]/child::node()[last()][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <span class="graphic">
                                <xsl:value-of select="concat(., $am)"/>
                            </span>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
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
                        <xsl:text>graphic</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="current()"/>
                </xsl:element>
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
                            <xsl:choose>
                                <xsl:when test="$am/ancestor::tei:rdg[contains(@ana, '#abb')]">
                                    <xsl:element name="span">
                                        <xsl:attribute name="class">graphic</xsl:attribute>
                                        <xsl:value-of select="concat(., $am)"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat(., $am)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::text()]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <xsl:choose>
                                <xsl:when test="$am/ancestor::tei:rdg[contains(@ana, '#abb')]">
                                    <xsl:element name="span">
                                        <xsl:attribute name="class">graphic</xsl:attribute>
                                        <xsl:value-of select="concat(., $am)"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat(., $am)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                <xsl:if test="current()[not(preceding-sibling::node()[1][self::text()])][parent::tei:seg/preceding-sibling::node()[1][self::tei:seg]]">
                    <xsl:analyze-string select="current()/parent::*/preceding-sibling::node()[1]/child::node()[last()][self::text()]" regex="\w$">
                        <xsl:matching-substring>
                            <xsl:choose>
                                <xsl:when test="$am/ancestor::tei:rdg[contains(@ana, '#abb')]">
                                    <xsl:element name="span">
                                        <xsl:attribute name="class">graphic</xsl:attribute>
                                        <xsl:value-of select="concat(., $am)"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat(., $am)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
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
                    </xsl:attribute>
                    <xsl:value-of select="current()"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ex"/>
    <xsl:template match="tei:choice">
        <xsl:apply-templates select="tei:orig"/>
    </xsl:template>
    <xsl:template match="tei:del">
        <xsl:element name="del">
            <xsl:attribute name="class">
                <xsl:value-of select="@rend"/>
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
                            <xsl:text>gap</xsl:text>
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
                <xsl:text>gap</xsl:text>
            </xsl:attribute>
            <xsl:text>⟦ ⟧</xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:hi">
        ⟨<xsl:value-of select="."/>⟩
    </xsl:template>
    <xsl:template match="tei:supplied"/>
    <xsl:template match="tei:subst">
        <xsl:apply-templates select="*"/>
    </xsl:template>
</xsl:stylesheet>