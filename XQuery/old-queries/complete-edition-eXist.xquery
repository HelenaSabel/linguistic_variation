xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";

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
let $songs := doc('/db/VTLGP/edition/sandim1.xml')//tei:div[@type eq 'poem']
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
            <script
                src="javascript/tooltip.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/form.js"
                type="text/javascript">/**/</script>
            <!--#include virtual="ssi/favicon.html"-->
        </head>
        <body><!--#include virtual="ssi/header.html"-->
            <main>
                <h1
                    class="center"><span
                        class="pt">Edição sinóptica</span><span
                        class="en">Synoptic
                        edition</span></h1>
                <h2><span
                        class="en">Edition criteria</span><span
                        class="pt">Critérios de
                        edição</span></h2>
                <div
                    class="flex"><p><svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="22"
                            height="22">
                            <rect
                                width="20"
                                height="20"
                                x="1"
                                y="1"
                                rx="4"
                                ry="4"
                                fill="#2B3966"
                                stroke-width="1"
                                stroke="black"></rect>
                        </svg>
                        <span
                            class="pt linguistic">Variantes de língua</span><span
                            class="en linguistic">Linguistic variants</span></p>
                    <p><svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="22"
                            height="22">
                            <rect
                                width="20"
                                height="20"
                                x="1"
                                y="1"
                                rx="4"
                                ry="4"
                                fill="#D14205"
                                stroke-width="1"
                                stroke="black"></rect>
                        </svg>
                        <span
                            class="pt error">Erros de cópia</span><span
                            class="en error">Scribal
                            errors</span></p>
                    <p><span
                            class="en graphic">Graphic variants</span><span
                            class="pt graphic"
                        >Variantes gráficas</span></p>
                    <p><span
                            class="en equipolent">Equipolent readings</span><span
                            class="pt equipolent"
                        >Lições equipolentes</span></p></div>
                <p><span
                        class="en">Click on the colored or underlined form for additional information</span><span
                        class="pt"
                    >Clica na forma colorida ou sublinhada para ler informação adicional</span>.</p>
                <h3
                    class="en">Other criteria</h3><h3
                    class="pt">Outros critérios</h3>
                <form
                    class="criteria">
                    <fieldset>
                        <input
                            type="radio"
                            name="abbreviation"
                            value="expan"
                            checked="checked"/><span
                            class="en">Expanded abbreviations</span><span
                            class="pt">Desenvolvimento de
                            abreviaturas</span>
                        <input
                            type="radio"
                            name="abbreviation"
                            value="abb"/><span
                            class="en"
                        >Abbreviation markers</span><span
                            class="pt">Signos de abreviação</span></fieldset>
                    <fieldset>
                        <input
                            type="radio"
                            name="hyphen"
                            value="reg"
                            checked="checked"/><span
                            class="en">Hyphenated clitics and allomoph articles</span><span
                            class="pt"
                        >Clíticos e segunda forma do artigo com hífen</span>
                        <input
                            type="radio"
                            name="hyphen"
                            value="orig"/><span
                            class="en">Original
                            disposition of clitics and allomophs</span><span
                            class="pt">Conservação da
                            disposição original de clíticos e artigos alomorfos</span></fieldset>
                    <fieldset><input
                            type="checkbox"
                            name="apostrophe"
                            value="apostrophe"
                            checked="checked"
                        /><span
                            class="en">Apostrophes to detect elisions</span><span
                            class="pt"
                        >Apóstrofes nas elisões vocálicas</span>
                        <input
                            type="checkbox"
                            name="add"
                            value="add"/><span
                            class="pt">Identificar
                            visualmente as adições</span><span
                            class="en">Identification of
                            additions</span>
                        <input
                            type="checkbox"
                            name="del"
                            value="del"/><span
                            class="pt">Ver
                            cancelações</span>
                        <span
                            class="en">View deletations</span></fieldset>
                </form>
                <div
                    class="multiple">
                    <section>
                        {
                            for $song in $songs
                            let $author := doc('/db/VTLGP/ancillary/corpus-autores.xml')//tei:person[string(@xml:id) = $song//tei:name[@role eq 'author']/substring(@ref, 2)]
                            return
                                <div
                                    id="{$song/substring(@corresp, 2)}"
                                    class="poem">
                                    <div
                                        class="metadata">
                                        <h2><span
                                                class="pt">Cantiga</span><span
                                                class="en">Song:</span>
                                            {string-join($song//tei:title//tei:idno, ', ')}</h2>
                                        <h2><span
                                                class="pt">Autor</span><span
                                                class="en">Author:</span>
                                            {$author/tei:persName/string()}</h2>
                                        <h2><span
                                                class="pt">Período</span><span
                                                class="en">Period:</span>
                                            {$author/tei:floruit/@from/string()}-{$author/tei:floruit/@to/string()}
                                            (<span
                                                class="pt">período</span><span
                                                class="en">period</span>
                                            {$author/tei:floruit/@period/string()})</h2>
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
                                                                        
                                                                        <li>{
                                                                                transform:transform($line/tei:app/tei:rdg[contains(@wit, $witness/@wit)],
                                                                                doc('/db/VTLGP/xslt/reading.xsl'), ())
                                                                            }</li>
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