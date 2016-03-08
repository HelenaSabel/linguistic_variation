xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $searchphrase := request:get-parameter("searchphrase", 'amor');
(: Local function written by David J. Birnbaum (www.obdurodon.org) :)
declare function local:locus($from as node(), $to as node())
{(if ($from eq $to)
then $from/string()
else
    if (substring($from,1,string-length($from) - 1) eq substring($to,1,string-length($to) - 1))
            then concat($from,'-v')
            else concat($from,'-',$to))};
declare variable $songs := collection('/db/tese/drafts/songs/songs')//tei:div[@type='poem'];
declare variable $poets := doc('/db/tese/drafts/songs/ancillary/corpus_autores.xml')//tei:person;
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Pesquisa de formas</title>
       <link href="form.css" rel="stylesheet" type="text/css"/>
       <script type="text/javascript" src="sorttable.js">/**/</script>
        <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js" type="text/javascript">/**/</script>
        <script src="sidebar.js" type="text/javascript">/**/</script>
    </head>
    <body>
        <div class="body">
            <div class="banner"><img src="banner-ms.jpg" alt="banner" />
            </div>
                <h2>Resultados da pesquisa</h2>
                <p>Objeto da pesquisa: "{$searchphrase}"</p>
                <table class="sortable">
                    <thead>
                <tr class="head">
                    <th>Verso</th>
                    <th>Ms. </th>
                    <th>Localização </th>
                    <th>Copista </th>
                    <th>Autor </th>
                    <th>Período </th>
                    <th>Cantiga </th>
                    <th>N° v. </th>
                </tr>
            </thead>
            <tbody>
                    {
                        for $line in $songs//tei:l[ft:query(.,$searchphrase)]
                        let $author := $poets[@xml:id = $line/ancestor::tei:div[1]//tei:name/substring(@ref,2)]
                        return
                        <tr>
                            <td><em>{transform:transform($line,'xmldb:exist:///db/tese/drafts/xslt/line.xsl', ())}</em></td>
                            <td>{(if ($line//tei:rdg[contains(.,$searchphrase)]) 
                            then substring($line/parent::tei:div/tei:head//tei:rdg
                            [@wit = $line//tei:rdg[contains(.,$searchphrase)]/@wit]/@wit, 2) 
                            else (if ($line[not(.//tei:rdg[contains(.,$searchphrase)])])
                            then
                                <ul>
                                <li>{$line/parent::tei:div/tei:head//tei:rdg[1]/@wit/substring(.,2)}</li>
                                <li>{$line/parent::tei:div/tei:head//tei:rdg[2]/@wit/substring(.,2)}</li>    
                                </ul>
                                else ()))}</td>
                                <td>{(if ($line//tei:rdg[contains(.,$searchphrase)]) 
                            then $line/parent::tei:div/tei:head//tei:rdg
                            [@wit = $line//tei:rdg[contains(.,$searchphrase)]/@wit]/tei:locus/local:locus(@from,@to) 
                            else (if ($line[not(.//tei:rdg[contains(.,$searchphrase)])])
                            then
                                <ul>
                                <li>{$line/parent::tei:div/tei:head//tei:rdg[1]/tei:locus/local:locus(@from,@to)}</li>
                                <li>{$line/parent::tei:div/tei:head//tei:rdg[2]/tei:locus/local:locus(@from,@to)}</li>    
                                </ul>
                                else ()))}</td>
                            <td>{(if ($line//tei:rdg[contains(.,$searchphrase)]) 
                            then substring($line/parent::tei:div/tei:head//tei:rdg
                            [@wit = $line//tei:rdg[contains(.,$searchphrase)]/@wit]/@hand, 2) 
                            else (if ($line[not(.//tei:rdg[contains(.,$searchphrase)])])
                            then
                                <ul>
                                <li>{$line/parent::tei:div/tei:head//tei:rdg[1]/@hand/substring(.,2)}</li>
                                <li>{$line/parent::tei:div/tei:head//tei:rdg[2]/@hand/substring(.,2)}</li>    
                                </ul>
                                else ()))}</td>
                            <td>{$author/tei:persName/string()}</td>
                            <td>{$author/tei:floruit/@period||'°'}</td>
                            <td>{$line/parent::tei:div/substring(@corresp, 2)}</td>
                            <td>{$line/@n/string()}</td>
                        </tr>
                    }
                    </tbody>
                    </table>
            </div>
            </body>
            </html>

