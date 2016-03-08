xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace saxon = "http://saxon.sf.net/";
declare option saxon:output "method=xml";
declare option saxon:output "doctype-system=about:legacy-compat";
declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "indent=yes";
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare function local:locus($from as node()?, $to as node()?)
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
(:declare variable $selected:= request:get-parameter("song", ("A191"));:)
let $songs := doc('../edition/corrigidas/sandim1.xml')//tei:div[@type eq 'poem']
return
    <html
        xmlns="http://www.w3.org/1999/xhtml"
        lang="en"
        xml:lang="en">
        <head>
            <title>Edição sinóptica</title>
            <meta
                charset="utf-8"
                lang="pt"/>
            <meta
                name="viewport"
                content="width=device-width, initial-scale=1"/>
            <link
                href="css/project.css"
                rel="stylesheet"
                type="text/css"/>
            <script
                src="javascript/menu.js"
                type="text/javascript">/**/</script>
                <script
                src="javascript/deselect.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/show.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/language.js"
                type="text/javascript">/**/</script>
            <script
                src="http://code.jquery.com/jquery-latest.min.js"
                type="text/javascript">/**/</script>
            <script
                src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/sidebar.js"
                type="text/javascript">/**/</script>
            <!--#include virtual="ssi/favicon.html"-->
        </head>
        <body>
            <!--#include virtual="ssi/header.html"-->
            <main>
                <h1
                    class="pt center">Edição sinóptica</h1>
                <h1
                    class="en center">Synoptic edition</h1>
                <div
                    class="multiple">
                    <section>
                        {
                            for $song in $songs
                            let $author := doc('../ancillary-files/corpus-autores.xml')//tei:person[string(@xml:id) = $song//tei:name[@role eq 'author']/substring(@ref, 2)]
                            return
                                <div
                                    id="{$song/substring(@corresp, 2)}"
                                    class="poem">
                                    <div
                                        class="metadata pt">
                                        <h2>Cantiga: {string-join($song//tei:title//tei:idno, ', ')}</h2>
                                        <h2>Autor: {$author/tei:persName/string()}</h2>
                                        <h2>Período: {$author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()} (período {$author/tei:floruit/@period/string()})</h2>
                                    </div>
                                    <div
                                        class="metadata en">
                                        <h2>Song: {string-join($song//tei:title//tei:idno, ', ')}</h2>
                                        <h2>Author: {$author/tei:persName/string()}</h2>
                                        <h2>Period: {$author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()} (period {$author/tei:floruit/@period/string()})</h2>
                                    </div>
                                    <div
                                        class="body">
                                        {
                                            
                                            for $witness in $song/tei:head//tei:rdg
                                            return
                                                <div
                                                    class="witness">
                                                    <h3><span
                                                            class="pt">Testemunho</span><span
                                                            class="en">Witness</span>: {$witness/substring(@wit, 2)}</h3>
                                                    <h4>Text<span
                                                            class="pt">o</span>: {$witness/tei:idno/string()}</h4>
                                                    <h4><span
                                                            class="pt">Localização</span><span
                                                            class="en">Location</span>: {local:locus($witness/tei:locus/@from, $witness/tei:locus/@to)}</h4>
                                                    <h4><span
                                                            class="pt">Copista</span><span
                                                            class="en">Copyist</span>: {$witness/substring(@hand, 2)}</h4>
                                                    {
                                                        for $cobra in $song//tei:lg
                                                        return
                                                            <ol
                                                                start="{$cobra/tei:l[1]/@n/string()}">
                                                                {
                                                                    for $line in $cobra/tei:l
                                                                    return
                                                                        <li>{$line/tei:app/tei:rdg[contains(@wit, $witness/@wit)]/text()}</li>
                                                                }
                                                            </ol>
                                                    }</div>
                                        
                                        }
                                    </div>
                                </div>
                        }
                    </section>
                    <aside
                        id="move"><h3
                            class="pt">Cantigas</h3>
                        <h3
                            class="en">Songs</h3>
                        <ul>{
                                for $song in $songs
                                return
                                    <li><a
                                            href="{$song/@corresp}">{string-join($song//tei:title//tei:idno, ', ')}</a></li>
                            }
                        
                        </ul>
                    </aside>
                </div>
                <div
                    id="footer"/>
            </main>
            
            <!--#include virtual="ssi/footer.html"-->
        </body>
    </html>