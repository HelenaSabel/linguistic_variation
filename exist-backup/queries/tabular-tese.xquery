xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(: Local function written by David J. Birnbaum (djbpitt@gmail.com) :)
declare namespace djb = "www.obdurodon.org";
declare option exist:serialize "method=xhtml media-type=application/xhtml+html indent=no";
declare function djb:locus($from as node()?, $to as node()?)
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
<html>
    <head>
        <title>Something</title>
        <meta charset="UTF-8"/>
    </head>
        <body>{
let $cantigas:= collection('/db/VTLGP/edition')//tei:div[@type eq 'poem'][tei:head/tei:name[@ref eq '#VaFdezSen']]
for $song in $cantigas 
let $author := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[string(@xml:id) = $song//tei:name[@role eq 'author']/substring(@ref, 2)]
return

                        (<div>
                            <h3>Cantiga{':&#32;' || string-join($song//tei:title//tei:idno, ', ')}</h3>
                            <p>Autor{':&#32;' || $author/tei:persName/string()}</p>
                            <p>Período{':&#32;' || $author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()} (período{'&#32;' || $author/tei:floruit/@period/string()})</p>
                        </div>,
                        <div class="tabular">
                            {
                                for $line in $song//tei:l
                                return
                                    (<p>{$line/@n/string()}.</p>,
                                    <table>{
                                            for $witness in $song/tei:head/descendant::tei:rdg
                                            let $parameter:= 
                                                    <parameters>
                                                        <param name="wit" value="{$witness/@wit}"/>
                                                    </parameters>
                                        return 
                                        <tr>{transform:transform($line[ancestor::tei:div/tei:head/descendant::tei:rdg/@wit = $witness/@wit], doc('/db/VTLGP/xslt/table-tese.xsl'), $parameter)}</tr>
                                        
                                    }</table>)
                            
                            }</div>)
                        }</body></html>
        