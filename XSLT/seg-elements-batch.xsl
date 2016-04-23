<?xml version="1.0" encoding="UTF-8"?>

<!--java -jar ../../SaxonHE9-6-0-7J/saxon9he.jar -s:edition/corrigidas XSLT/seg-elements-batch.xsl -o:edition-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="am[not(parent::seg)][ancestor::rdg[contains(@ana, '#abb')]]">
        <seg corresp="#abb"><xsl:copy-of select="current()"/><xsl:sequence select="following-sibling::ex[1]"/></seg>
    </xsl:template>
    <xsl:template match="ex[not(parent::seg)][ancestor::rdg[contains(@ana, '#abb')]]"/>
    <xsl:template match="hi[ancestor::rdg[contains(@ana, '#material')]]">
        <seg corresp="#material"><xsl:copy-of select="current()"/></seg>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'y')][not(parent::seg)][ancestor::rdg[contains(@ana, '#y-dip')]]">
        <xsl:analyze-string select="current()" regex=".*?y">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'y', '')"/>
                <seg corresp="#y-dip">y</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'j')][not(parent::seg)][ancestor::rdg[contains(@ana, '#j-minin')]]">
        <xsl:analyze-string select="current()" regex=".*?j">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'j', '')"/>
                <seg corresp="#j-minin">j</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'y')][not(parent::seg)][ancestor::rdg[contains(@ana, '#y-minin')]]">
        <xsl:analyze-string select="current()" regex=".*?y">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'y', '')"/>
                <seg corresp="#y-minin">y</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'y')][not(parent::seg)][ancestor::rdg[contains(@ana, '#y-vow')]]">
        <xsl:analyze-string select="current()" regex=".*?y">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'y', '')"/>
                <seg corresp="#y-vow">y</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'y')][not(parent::seg)][ancestor::rdg[contains(@ana, '#uy')]]">
        <xsl:analyze-string select="current()" regex=".*?y">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'y', '')"/>
                <seg corresp="#uy">y</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'j')][not(parent::seg)][ancestor::rdg[contains(@ana, '#uj')]]">
        <xsl:analyze-string select="current()" regex=".*?j">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'j', '')"/>
                <seg corresp="#uj">j</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'h')][not(parent::seg)][ancestor::rdg[contains(@ana, '#h-minin')]]">
        <xsl:analyze-string select="current()" regex=".*?h">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'h', '')"/>
                <seg corresp="#h-minin">h</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'h')][not(parent::seg)][ancestor::rdg[contains(@ana, '#h-et')]]">
        <xsl:analyze-string select="current()" regex=".*?h">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'h', '')"/>
                <seg corresp="#h-et">h</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'h')][not(parent::seg)][ancestor::rdg[contains(@ana, '#h-monos')]]">
        <xsl:analyze-string select="current()" regex=".*?h">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'h', '')"/>
                <seg corresp="#h-monos">h</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'h')][not(parent::seg)][ancestor::rdg[contains(@ana, '#h-anti')]]">
        <xsl:analyze-string select="current()" regex=".*?h">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'h', '')"/>
                <seg corresp="#h-anti">h</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'll')][not(parent::seg)][ancestor::rdg[contains(@ana, '#reg')]]">
        <xsl:analyze-string select="current()" regex=".*?ll">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'll', '')"/>
                <seg corresp="#reg">ll</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'nn')][not(parent::seg)][ancestor::rdg[contains(@ana, '#reg')]]">
        <xsl:analyze-string select="current()" regex=".*?nn">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'nn', '')"/>
                <seg corresp="#reg">nn</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'ç')][not(parent::seg)][ancestor::rdg[contains(@ana, '#çe')]]">
        <xsl:analyze-string select="current()" regex=".*?ç">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'ç', '')"/>
                <seg corresp="#çe">ç</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <!--<xsl:template
        match="text()[matches(., 'c')][not(parent::seg)][ancestor::rdg[contains(@ana, '#c-pal')]]">
        <xsl:analyze-string select="current()" regex=".*?c">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'c', '')"/>
                <seg corresp="#c-pal">c</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>-->
    <xsl:template
        match="text()[matches(., 'v')][not(parent::seg)][ancestor::rdg[contains(@ana, '#v')]]">
        <xsl:analyze-string select="current()" regex=".*?v">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'v', '')"/>
                <seg corresp="#v">v</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'lhi')][not(parent::seg)][ancestor::rdg[contains(@ana, '#li')]]">
        <xsl:analyze-string select="current()" regex=".*lhi">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'lhi', '')"/>
                <seg corresp="#li">lhi</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'm')][not(parent::seg)][ancestor::rdg[contains(@ana, '#m-end')]]">
        <xsl:analyze-string select="current()" regex=".*m$">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'm', '')"/>
                <seg corresp="#m-end">m</seg>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'ss')][not(parent::seg)][ancestor::rdg[contains(@ana, '#ss-inic')]]">
        <xsl:analyze-string select="current()" regex=".*ss">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'ss', '')"/>
                <seg corresp="#ss-inic">ss</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'rr')][not(parent::seg)][ancestor::rdg[contains(@ana, '#rr-inic')]]">
        <xsl:analyze-string select="current()" regex=".*rr">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'rr', '')"/>
                <seg corresp="#rr-inic">rr</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'ff')][not(parent::seg)][ancestor::rdg[contains(@ana, '#ff')]]">
        <xsl:analyze-string select="current()" regex=".*ff">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'ff', '')"/>
                <seg corresp="#ff">ff</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'us')][not(parent::seg)][ancestor::rdg[contains(@ana, '#back-vow')]]">
        <xsl:analyze-string select="current()" regex=".*us">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'us', '')"/>
                <seg corresp="#back-vow">u</seg>s </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., '\.')][not(parent::seg)][ancestor::rdg[contains(@ana, '#punct')]]">
        <xsl:analyze-string select="current()" regex=".*\.">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., '\.', '')"/>
                <seg corresp="#punct">.</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'ui')][not(parent::seg)][ancestor::rdg[contains(@ana, '#dip')]]">
        <xsl:analyze-string select="current()" regex=".*ui">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'ui', '')"/>
                <seg corresp="#dip">ui</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'gu')][not(parent::seg)][ancestor::rdg[contains(@ana, '#gu')]]">
        <xsl:analyze-string select="current()" regex=".*gu">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'gu', '')"/> g<seg corresp="#gu">u</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template
        match="text()[matches(., 'n')][not(parent::seg)][ancestor::rdg[contains(@ana, '#np')]]">
        <xsl:analyze-string select="current()" regex=".*n">
            <xsl:matching-substring>
                <xsl:value-of select="replace(., 'n', '')"/>
                <seg corresp="#np">n</seg>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>
