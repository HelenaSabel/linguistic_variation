xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'];
declare variable $fs := doc('/db/VTLGP/ancillary/feature-library.xml');
declare variable $ling-features := $fs//tei:fvLib[@corresp eq '#linguistic']/tei:fs/@xml:id;
declare variable $equipolent := $fs//tei:fvLib[@n eq 'equipolent readings']/tei:fs/@xml:id;
declare variable $scribalError := $fs//tei:fvLib[@corresp eq '#scribal']/tei:fs/@xml:id;
declare variable $significant := $equipolent | $scribalError | $ling-features;
declare variable $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[concat('#', @xml:id) = $songs//tei:name[@role eq 'author']/@ref];
declare variable $periods := $poets[@xml:id = $songs//tei:name/substring(@ref, 2)]/tei:floruit/@period;
<div>
    <ul
        class="radarF">
        {
            for $period in distinct-values($periods)
            order by $period
            return
                <li><input
                        id="per{$period}"
                        value="per{$period}"
                        class="per{$period}"
                        type="checkbox"
                        checked="checked"/>
                    <label
                        for="per{$period}">{'Período ' || $period}</label></li>
        }
    </ul>
    <ul
        class="radarF">
        {
            let $sortedAuthors := for $author in $poets
            order by $songs[descendant::tei:name[@role eq 'author']/@ref = concat('#', $author/@xml:id)][1]/descendant::tei:title/descendant::tei:rdg[@wit eq
            '#A']/tei:locus/number(replace(@from, '(v|r)', ''))
            return
                $author
            for $author in $sortedAuthors
            let $id := $author/@xml:id/string()
            order by $author
            return
                <li><input
                        class="{$id}"
                        id="{$id}"
                        value="{$id}"
                        type="checkbox"/>
                    <label
                        for="{$id}">{$author/tei:persName/string()}</label></li>
        }
    </ul>
</div>