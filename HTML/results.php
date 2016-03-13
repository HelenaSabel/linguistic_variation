<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title>Resultados</title>
        <meta charset="utf-8" lang="pt" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="css/project.css" rel="stylesheet" type="text/css" />
        <script src="javascript/menu.js" type="text/javascript">/**/</script>
        <script src="javascript/language.js" type="text/javascript">/**/</script>
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
        <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js" type="text/javascript">/**/</script>
        <script src="javascript/sidebar.js" type="text/javascript">/**/</script>
        <script src="javascript/sorttable.js" type="text/javascript">/**/</script>
        
        <!--#include virtual="ssi/favicon.html"-->
    </head>
    <body><!--#include virtual="ssi/header.html"-->
        <main>
            <h1><span class="pt">Variantes de língua</span><span class="en">Linguistic
                    variants</span></h1>
                 
                <?php
                $parameters = $_GET['phenomenon'];
                $values = implode(",", $parameters);
                require_once('config.php');
                $query = REST_PATH . "/db/VTLGP/queries/ling.xquery?phenomenon=" . $values;
                echo file_get_contents($query);
            ?> 
            
            
        <!--       <?php
                $parameters = $_POST['phenomenon'];
                $values = implode(",", $parameters);
                require_once('config.php');
                $query = REST_PATH . "/db/VTLGP/queries/ling.xquery";
                $file = file_put_contents($query, $values);
                echo file_get_contents($file);
                
                ?>
             <?php   
             require_once('config.php');
             $url = REST_PATH . "/db/VTLGP/queries/ling.xquery";
             $parameters = $_POST['phenomenon'];
             $data = implode(",", $parameters);
             $options = array(
             'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
             'http' => array(
             'method'  => 'POST',
             'content' => http_build_query($data),
                 ),
                );
            $context  = stream_context_create($options);
            $result = file_get_contents($url, false, $context);
            if ($result === FALSE) { /* Handle error */ }
            var_dump($result);

        ?>
        
        <?php
            require_once('config.php');
            $url = REST_PATH . "/db/VTLGP/queries/ling.xquery";
            $fields = array(
            '__VIEWSTATE'=>urlencode($state),
            '__EVENTVALIDATION'=>urlencode($valid),
            'btnSubmit'=>urlencode('Submit')
             );
             
             $parameters = $_POST['phenomenon'];
             $data = implode(",", $parameters);

            //open connection
            $ch = curl_init();

            //set the url, number of POST vars, POST data
            curl_setopt($ch,CURLOPT_URL,$url);
            curl_setopt($ch,CURLOPT_POST,count($fields));
            curl_setopt($ch,CURLOPT_POSTFIELDS,$data);

            //execute post
            $result = curl_exec($ch);
            print $result;
?>-->
                        
            <div id="footer"></div>
        </main>
        <!--#include virtual="ssi/footer.html"-->
    </body>
</html>
