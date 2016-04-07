xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare namespace djb = "www.obdurodon.org";
declare function djb:locus($from as node(), $to as node())
{
    (if ($from eq $to)
    then
        $from/string()
    else
        if (substring($from, 1, string-length($from) - 1) eq substring($to, 1, string-length($to) - 1))
        then
            concat($from, '-v')
        else
            concat($from, '-', $to))
};

let $songs := collection('/db/VTLGP/edition')//tei:div[@type eq 'poem']
let $readings := $songs//tei:rdg[@cert eq 'low']
let $features := doc('/db/VTLGP/ancillary/feature-library.xml')//tei:fvLib/tei:fs
let $poets := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person
let $otherReadings := $songs//tei:rdg[contains(@ana, '#nh')] | $songs//tei:rdg[contains(@ana, '#ll')]
return
    (<table
        class="sortable">
        <thead>
            <tr
                class="head">
                <th>Forma </th>
                <th>Fenómeno </th>
                <th>Testemunho </th>
                <th>Localização </th>
                <th>Copista </th>
                <th>Autor </th>
                <th>Período </th>
                <th>Cantiga </th>
                <th>V. </th>
            </tr>
        </thead>
        <tbody>
            {
                for $fen in $readings
                let $rdg :=
                <parameters>
                    <param
                        name="rdg"
                        value="{$fen}"/>
                </parameters>
                let $author := $poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]
                return
                    <tr>
                        <td
                            class="intro"><a
                                href="http://gl-pt.obdurodon.org/edition.php?&amp;song[]={$fen/ancestor::tei:div[1]/substring(@corresp, 2)}&amp;line={$fen/ancestor::tei:l/@n/string()}"
                                target="_blank">{transform:transform($fen/.., 'xmldb:exist:///db/VTLGP/xslt/dub.xsl', ($rdg))}</a></td>
                        <td>{transform:transform($features[@xml:id = $fen/substring(@ana, 2)]//tei:string[@xml:lang eq 'pt']/text(), 'xmldb:exist:///db/VTLGP/xslt/string.xsl', ())}</td>
                        <td>{
                                (if ($fen/contains(@wit, ' ')) then
                                    <ul>{
                                            for $wit in tokenize($fen/@wit, '\s+')
                                            order by $wit
                                            return
                                                <li>{substring($wit, 2)}</li>
                                        }</ul>
                                else
                                    $fen/substring(@wit, 2)
                                )
                            }</td>
                        <td>{
                                (if (contains($fen/@wit, ' ')) then
                                    <ul>{
                                            
                                            for $wit in tokenize($fen/@wit, '\s+')
                                            order by $wit
                                            return
                                                <li>{djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/tei:locus/@to)
                                                    }</li>
                                        }</ul>
                                else
                                    djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@to))
                            }</td>
                        <td>{
                                (if (contains($fen/@wit, ' ')) then
                                    <ul>{
                                            
                                            for $wit in tokenize($fen/@wit, '\s+')
                                            order by $wit
                                            return
                                                <li>{$fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/substring(@hand, 2)}</li>
                                        }</ul>
                                else
                                    $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2))
                            }</td>
                        <td>{$author/tei:persName/string()}</td>
                        <td>{$author/tei:floruit/@from || '-' || $author/tei:floruit/@to || ' (' || $author/tei:floruit/@period || ')'}</td>
                        <td>{$fen/ancestor::tei:div[1]/string-join(descendant::tei:title//tei:idno, ', ')}</td>
                        <td>{$fen/ancestor::tei:l/@n/string()}</td>
                    </tr>
            }
        </tbody>
    </table>,
    <h2>Variantes gráficas com possíveis implicações linguísiticas</h2>,
    <table
        class="sortable">
        <thead>
            <tr
                class="head">
                <th>Forma </th>
                <th>Testemunho </th>
                <th>Localização </th>
                <th>Copista </th>
                <th>Autor </th>
                <th>Período </th>
                <th>Cantiga </th>
                <th>V. </th>
            </tr>
        </thead>
        <tbody>
            {
                for $fen in $otherReadings
                let $rdg :=
                <parameters>
                    <param
                        name="rdg"
                        value="{$fen}"/>
                </parameters>
                let $author := $poets[@xml:id = $fen/ancestor::tei:div[1]//tei:name/substring(@ref, 2)]
                return
                    <tr>
                        <td
                            class="intro"><a
                                href="http://gl-pt.obdurodon.org/edition.php?&amp;song[]={$fen/ancestor::tei:div[1]/substring(@corresp, 2)}&amp;line={$fen/ancestor::tei:l/@n/string()}"
                                target="_blank">{transform:transform($fen/.., 'xmldb:exist:///db/VTLGP/xslt/dub.xsl', ($rdg))}</a></td>
                        <td>{
                                (if ($fen/contains(@wit, ' ')) then
                                    <ul>{
                                            for $wit in tokenize($fen/@wit, '\s+')
                                            order by $wit
                                            return
                                                <li>{substring($wit, 2)}</li>
                                        }</ul>
                                else
                                    $fen/substring(@wit, 2)
                                )
                            }</td>
                        <td>{
                                (if (contains($fen/@wit, ' ')) then
                                    <ul>{
                                            
                                            for $wit in tokenize($fen/@wit, '\s+')
                                            order by $wit
                                            return
                                                <li>{djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/tei:locus/@to)
                                                    }</li>
                                        }</ul>
                                else
                                    djb:locus($fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@from, $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/tei:locus/@to))
                            }</td>
                        <td>{
                                (if (contains($fen/@wit, ' ')) then
                                    <ul>{
                                            
                                            for $wit in tokenize($fen/@wit, '\s+')
                                            order by $wit
                                            return
                                                <li>{$fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $wit]/substring(@hand, 2)}</li>
                                        }</ul>
                                else
                                    $fen/ancestor::tei:div[1]/tei:head//tei:rdg[@wit = $fen/@wit]/substring(@hand, 2))
                            }</td>
                        <td>{$author/tei:persName/string()}</td>
                        <td>{$author/tei:floruit/@from || '-' || $author/tei:floruit/@to || ' (' || $author/tei:floruit/@period || ')'}</td>
                        <td>{$fen/ancestor::tei:div[1]/string-join(descendant::tei:title//tei:idno, ', ')}</td>
                        <td>{$fen/ancestor::tei:l/@n/string()}</td>
                    </tr>
            }
        </tbody>
    </table>)