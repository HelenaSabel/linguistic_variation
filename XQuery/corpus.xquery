xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace saxon = "http://saxon.sf.net/";
declare option saxon:output "method=xml";
declare option saxon:output "doctype-system=about:legacy-compat";
declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "indent=yes";
let $authors := doc('../ancillary-files/corpus-autores.xml')//tei:person[string(@xml:id) = collection('../edition/corrigidas')//tei:name[@role eq 'author']/substring(@ref, 2)]
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
                src="javascript/show.js"
                type="text/javascript">/**/</script>
            <script
                src="javascript/language.js"
                type="text/javascript">/**/</script>
            <!--#include virtual="ssi/favicon.html"-->
        </head>
        <body>
            <!--#include virtual="ssi/header.html"-->
            <main>
                <h1>Corpus</h1>
                <h2
                    class="pt">Por autor</h2>
                <h2
                    class="en">By author</h2>
                <form>
                    {
                        for $author in $authors
                        let $songs := collection('../edition/corrigidas')//tei:name[@role eq 'author'][substring(@ref, 2) = $author/string(@xml:id)]/ancestor::tei:div
                        return
                            <fieldset>
                                <legend>{$author/tei:persName/string()}</legend>
                                <div>
                                    <input
                                        type="checkbox"
                                        name="author"
                                        value="{$author/@xml:id}"/>
                                    <span
                                        class="pt">Todas</span>
                                    <span
                                        class="en">All</span>
                                    <input
                                        type="checkbox"
                                        name="author"
                                        value="show"
                                        class="show"/>
                                    <span
                                        class="pt">Seleccionar</span>
                                    <span
                                        class="en">Select</span>
                                    <ul
                                        class="hide">
                                        {
                                            for $song in $songs
                                            return
                                                <li><input
                                                        type="checkbox"
                                                        name="song"
                                                        value="{$song/substring(@corresp, 2)}"/>
                                                    {string-join($song//tei:title//tei:idno, ', ')}</li>
                                        }</ul>
                                </div>
                            </fieldset>
                    }
                    <input
                        class="button"
                        type="submit"
                        value="Pesquisar"/>
                </form>
            </main>
        </body>
    </html>