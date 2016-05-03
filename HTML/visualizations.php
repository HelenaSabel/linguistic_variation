<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Apresentação</title>
    <meta charset="utf-8" lang="pt"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="css/project.css" rel="stylesheet" type="text/css"/>
    <script src="javascript/language.js" type="text/javascript">/**/</script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
    <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
            type="text/javascript">/**/</script>
    <script src="javascript/header.js" type="text/javascript">/**/</script>
    <script src="javascript/menu.js" type="text/javascript">/**/</script>
    <script src="javascript/hide-show.js" type="text/javascript">/**/</script>

    <!--#include virtual="ssi/favicon.html"-->
</head>
<body><!--#include virtual="ssi/header.html"-->
<main>
    <h1><span class="pt">Visualizações</span><span class="en">Visualizations</span></h1>
    <h2><span class="pt">Proporção de leituras comuns (escala fixa)</span><span
            class="en">Overlapping of common text (fixed)</span>
    </h2>
    <div class="en">
        <ul>
            <li>Graphic variants included as “common text”</li>
            <li>Explanation of the scaling process</li>
        </ul>
    </div>
    <div class="pt">
        <ul>
            <li>Variantes gráficas incluídas como “texto comum”</li>
            <li>Explicação da escala</li>
        </ul>
    </div>

    <?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/overlap-scaled.xquery";
    echo file_get_contents($xql);
    ?>
    <h2><span class="pt">Proporção de leituras comuns (escala proporcional)</span><span
            class="en">Overlapping of common text (scaled)</span>
    </h2>
    <div class="en">
        <ul>
            <li>Graphic variants included as “common text”</li>
            <li>Explanation of the scaling process</li>
        </ul>
    </div>
    <div class="pt">
        <ul>
            <li>Variantes gráficas incluídas como “texto comum”</li>
            <li>Explicação da escala</li>
        </ul>
    </div>
    <?php
    require_once('config.php');
    $xql = REST_PATH . "/db/VTLGP/queries/overlap-non-scaled.xquery";
    echo file_get_contents($xql);
    ?>
    <h2><span class="pt">Variantes significativas</span><span class="en">Substantive variants</span> (I)</h2>
    <svg xmlns="http://www.w3.org/2000/svg" width="610" height="620">
        <g transform="translate(80,450)">
            <polyline fill="none" stroke="#32281b" stroke-width="1" points="0,0 248,0 258,15 262,-15 272,0 540,0"/>
            <line x1="0" x2="0" y1="0" y2="-422" stroke="#32281b" stroke-width="1"/>
            <text x="-50" y="-241" text-anchor="middle" fill="#32281b" style="writing-mode:tb" transform="rotate(180 -50 -241)">Percentagem variantes significativas</text>
            <text x="290" text-anchor="middle" y="70" fill="#32281b">Folio Ms. A</text>
            <line x1="-3" x2="3" y1="-60" y2="-60" stroke="#32281b" stroke-width="1"/>
            <line x1="-3" x2="3" y1="-120" y2="-120" stroke="#32281b" stroke-width="1"/>
            <line x1="-3" x2="3" y1="-180" y2="-180" stroke="#32281b" stroke-width="1"/>
            <line x1="-3" x2="3" y1="-240" y2="-240" stroke="#32281b" stroke-width="1"/>
            <line x1="-3" x2="3" y1="-300" y2="-300" stroke="#32281b" stroke-width="1"/>
            <line x1="-3" x2="3" y1="-360" y2="-360" stroke="#32281b" stroke-width="1"/>
            <line x1="-3" x2="3" y1="-420" y2="-420" stroke="#32281b" stroke-width="1"/>
            <text text-anchor="end" font-size="11" fill="#32281b" x="-9" y="-55">10</text>
            <text text-anchor="end" font-size="11" fill="#32281b" x="-9" y="-175">30</text>
            <text text-anchor="end" font-size="11" fill="#32281b" x="-9" y="-300">50</text>
            <text text-anchor="end" font-size="11" fill="#32281b" x="-9" y="-415">70</text>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="40" x2="40"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="80" x2="80"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="120" x2="120"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="160" x2="160"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="200" x2="200"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="240" x2="240"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="280" x2="280"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="320" x2="320"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="360" x2="360"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="400" x2="400"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="440" x2="440"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="480" x2="480"/>
            <line stroke="#32281b" stroke-width="1" y1="-3" y2="3" x1="520" x2="520"/>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="40">1</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="80">5</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="120">10</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="160">15</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="200">20</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="240">25</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="280">55</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="320">60</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="360">65</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="400">70</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="440">75</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="480">80</text>
            <text text-anchor="middle" fill="#32281b" font-size="11" y="20" x="520">85</text>
            <rect height="22" width="22" x="0" y="105" fill="#11894A" stroke-width=".5" stroke="#32281b"/>
            <text fill="#32281b" font-size="11" x="25" y="120">Língua</text>
            <rect height="22" width="22" x="150" y="105" fill="#FFC938" stroke-width=".5" stroke="#32281b"/>
            <text fill="#32281b" font-size="11" x="175" y="120">Erros</text>
            <rect height="22" width="22" x="300" y="105" fill="#2b3966" stroke-width=".5" stroke="#32281b"/>
            <text fill="#32281b" font-size="11" x="325" y="120">Equipolentes</text>
            <rect height="22" width="22" x="450" y="105" fill="#CF4205" stroke-width=".5" stroke="#32281b"/>
            <text fill="#32281b" font-size="11" x="475" y="120">Outras*</text>
        </g>
        <g transform="translate(80,450)">
            <circle r="3" cx="40" cy="-217.05882352941177" fill="#FFC938"/>
            <circle r="3" cx="40" cy="-195.2941176470588" fill="#11894A"/>
            <circle r="3" cx="40" cy="-84.70588235294117" fill="#2B3966"/>
            <circle r="3" cx="40" cy="-122.94117647058825" fill="#CF4205"/>
            <circle r="3" cx="80" cy="-195.96059113300493" fill="#FFC938"/>
            <circle r="3" cx="80" cy="-221.67487684729065" fill="#11894A"/>
            <circle r="3" cx="80" cy="-113.79310344827586" fill="#2B3966"/>
            <circle r="3" cx="80" cy="-80.6896551724138" fill="#CF4205"/>
            <circle r="3" cx="120" cy="-204.81054365733112" fill="#FFC938"/>
            <circle r="3" cx="120" cy="-230.51070840197693" fill="#11894A"/>
            <circle r="3" cx="120" cy="-112.28995057660626" fill="#2B3966"/>
            <circle r="3" cx="120" cy="-60.88962108731465" fill="#CF4205"/>
            <circle r="3" cx="160" cy="-200.57546429505624" fill="#FFC938"/>
            <circle r="3" cx="160" cy="-235.10332199843054" fill="#11894A"/>
            <circle r="3" cx="160" cy="-116.92388176824484" fill="#2B3966"/>
            <circle r="3" cx="160" cy="-55.08762751765629" fill="#CF4205"/>
            <circle r="3" cx="200" cy="-198.63043013053712" fill="#FFC938"/>
            <circle r="3" cx="200" cy="-232.7840787502675" fill="#11894A"/>
            <circle r="3" cx="200" cy="-104.5153006633854" fill="#2B3966"/>
            <circle r="3" cx="200" cy="-70.36165204365506" fill="#CF4205"/>
            <circle r="3" cx="240" cy="-192.32699892434565" fill="#FFC938"/>
            <circle r="3" cx="240" cy="-243.31301541771245" fill="#11894A"/>
            <circle r="3" cx="240" cy="-105.95195410541413" fill="#2B3966"/>
            <circle r="3" cx="240" cy="-65.72248117604875" fill="#CF4205"/>
            <circle r="3" cx="280" cy="-191.13233287858117" fill="#FFC938"/>
            <circle r="3" cx="280" cy="-173.53342428376536" fill="#11894A"/>
            <circle r="3" cx="280" cy="-118.28103683492496" fill="#2B3966"/>
            <circle r="3" cx="280" cy="-156.7530695770805" fill="#CF4205"/>
            <circle r="3" cx="320" cy="-197.3684210526316" fill="#FFC938"/>
            <circle r="3" cx="320" cy="-171.9679633867277" fill="#11894A"/>
            <circle r="3" cx="320" cy="-108.12356979405034" fill="#2B3966"/>
            <circle r="3" cx="320" cy="-155.83524027459953" fill="#CF4205"/>
            <circle r="3" cx="360" cy="-228.65923933922397" fill="#FFC938"/>
            <circle r="3" cx="360" cy="-162.73530541682675" fill="#11894A"/>
            <circle r="3" cx="360" cy="-91.97080291970804" fill="#2B3966"/>
            <circle r="3" cx="360" cy="-142.91202458701497" fill="#CF4205"/>
            <circle r="3" cx="400" cy="-229.64738103389251" fill="#FFC938"/>
            <circle r="3" cx="400" cy="-167.61383087983566" fill="#11894A"/>
            <circle r="3" cx="400" cy="-86.27182471756248" fill="#2B3966"/>
            <circle r="3" cx="400" cy="-148.0999657651489" fill="#CF4205"/>
            <circle r="3" cx="440" cy="-228.76318312559923" fill="#FFC938"/>
            <circle r="3" cx="440" cy="-161.84084372003835" fill="#11894A"/>
            <circle r="3" cx="440" cy="-85.52253116011505" fill="#2B3966"/>
            <circle r="3" cx="440" cy="-153.40364333652926" fill="#CF4205"/>
            <circle r="3" cx="480" cy="-253.61042620641072" fill="#FFC938"/>
            <circle r="3" cx="480" cy="-144.13525889397675" fill="#11894A"/>
            <circle r="3" cx="480" cy="-74.81507573089115" fill="#2B3966"/>
            <circle r="3" cx="480" cy="-146.67136315604085" fill="#CF4205"/>
            <circle r="3" cx="520" cy="-227.44152399324813" fill="#FFC938"/>
            <circle r="3" cx="520" cy="-152.0617313720762" fill="#11894A"/>
            <circle r="3" cx="520" cy="-86.375693272245" fill="#2B3966"/>
            <circle r="3" cx="520" cy="-153.36387750180853" fill="#CF4205"/>
            <polyline fill="none" stroke="#FFC938" stroke-width="3" points="40,-217.05882352941177 80,-195.96059113300493 120,-204.81054365733112 160,-200.57546429505624 200,-198.63043013053712 240,-192.32699892434565 280,-191.13233287858117 320,-197.3684210526316 360,-228.65923933922397 400,-229.64738103389251 440,-228.76318312559923 480,-253.61042620641072 520,-227.44152399324813"/>
            <polyline fill="none" stroke="#11894A" stroke-width="3" points="40,-195.2941176470588 80,-221.67487684729065 120,-230.51070840197693 160,-235.10332199843054 200,-232.7840787502675 240,-243.31301541771245 280,-173.53342428376536 320,-171.9679633867277 360,-162.73530541682675 400,-167.61383087983566 440,-161.84084372003835 480,-144.13525889397675 520,-152.0617313720762"/>
            <polyline fill="none" stroke="#2B3966" stroke-width="3" points="40,-84.70588235294117 80,-113.79310344827586 120,-112.28995057660626 160,-116.92388176824484 200,-104.5153006633854 240,-105.95195410541413 280,-118.28103683492496 320,-108.12356979405034 360,-91.97080291970804 400,-86.27182471756248 440,-85.52253116011505 480,-74.81507573089115 520,-86.375693272245"/>
            <polyline fill="none" stroke="#CF4205" stroke-width="3" points="40,-122.94117647058825 80,-80.6896551724138 120,-60.88962108731465 160,-55.08762751765629 200,-70.36165204365506 240,-65.72248117604875 280,-156.7530695770805 320,-155.83524027459953 360,-142.91202458701497 400,-148.0999657651489 440,-153.40364333652926 480,-146.67136315604085 520,-153.36387750180853"/>
        </g>
    </svg>
    <h2><span class="pt">Variantes significativas</span><span class="en">Substantive variants</span> (II)</h2>
    <div class="radar">
        <svg xmlns="http://www.w3.org/2000/svg" width="820" height="720">
            <g transform="translate(440,350)">
                <line x1="-320" y1="0" x2="320" y2="0" stroke="#32281b" stroke-width="1"/>
                <line x1="0" y1="-320" x2="0" y2="320" stroke="#32281b" stroke-width="1"/>
                <polyline points="0,320 -320,0 0,-320 320,0 0,320" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,280 -280,0 0,-280 280,0 0,280" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,40 -40,0 0,-40 40,0 0,40" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,80 -80,0 0,-80 80,0 0,80" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,120 -120,0 0,-120 120,0 0,120" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,160 -160,0 0,-160 160,0 0,160" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,200 -200,0 0,-200 200,0 0,200" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <polyline points="0,240 -240,0 0,-240 240,0 0,240" stroke-dasharray="2,2" stroke="#32281b" stroke-width="1" fill="none"/>
                <text font-size="11" fill="#32281b" x="5" y="-5" text-anchor="start">0</text>
                <text font-size="11" fill="#32281b" x="5" y="45" text-anchor="start">10</text>
                <text font-size="11" fill="#32281b" x="5" y="-80" text-anchor="start">20</text>
                <text font-size="11" fill="#32281b" x="5" y="-160" text-anchor="start">40</text>
                <text font-size="11" fill="#32281b" x="5" y="-240" text-anchor="start">60</text>
                <text font-size="11" fill="#32281b" x="5" y="-320" text-anchor="start">80</text>
                <text font-size="11" fill="#32281b" x="5" y="125" text-anchor="start">30</text>
                <text font-size="11" fill="#32281b" x="5" y="205" text-anchor="start">50</text>
                <text font-size="11" fill="#32281b" x="5" y="285" text-anchor="start">70</text>
                <text font-size="11" fill="#32281b" x="-45" y="-5" text-anchor="middle">10</text>
                <text font-size="11" fill="#32281b" x="-125" y="-5" text-anchor="middle">30</text>
                <text font-size="11" fill="#32281b" x="-205" y="-5" text-anchor="middle">50</text>
                <text font-size="11" fill="#32281b" x="-285" y="-5" text-anchor="middle">70</text>
                <text font-size="11" fill="#32281b" x="80" y="-5" text-anchor="start">20</text>
                <text font-size="11" fill="#32281b" x="160" y="-5" text-anchor="start">40</text>
                <text font-size="11" fill="#32281b" x="240" y="-5" text-anchor="start">60</text>
                <text font-size="11" fill="#32281b" x="320" y="-5" text-anchor="start">80</text>
                <text x="25" y="-307">Variantes de língua</text>
                <text x="-300" y="-30" text-anchor="end">Erros de cópia</text>
                <text y="17" x="323">Outras</text>
                <text x="-32" text-anchor="end" y="310">Equipolentes</text>
            </g>
            <g transform="translate(440,350)" class="per2">
                <polyline stroke="#2B3966" fill="none" stroke-width="2" points="0,-178.2435129740519 -118.16367265469061,0 0,81.437125748503 22.155688622754496,0 0,-178.2435129740519"/>
                <polyline stroke="none" fill="#2B3966" opacity=".4" points="0,-178.2435129740519 -118.16367265469061,0 0,81.437125748503 22.155688622754496,0 0,-178.2435129740519"/>
                <circle fill="#2B3966" r="3.5" cy="-178.2435129740519" cx="0"/>
                <circle fill="#2B3966" r="3.5" cy="81.437125748503" cx="0"/>
                <circle fill="#2B3966" r="3.5" cx="-118.16367265469061" cy="0"/>
                <circle fill="#2B3966" r="3.5" cx="22.155688622754496" cy="0"/>
            </g>
            <g transform="translate(440,350)" class="per3">
                <polyline stroke="#BD6D03" fill="none" stroke-width="2" points="0,-130.7067089130734 -138.917206226753,0 0,64.1410662625706 66.23501859760296,0 0,-130.7067089130734"/>
                <polyline stroke="none" fill="#BD6D03" opacity=".4" points="0,-130.7067089130734 -138.917206226753,0 0,64.1410662625706 66.23501859760296,0 0,-130.7067089130734"/>
                <circle fill="#BD6D03" r="3.5" cy="-130.7067089130734" cx="0"/>
                <circle fill="#BD6D03" r="3.5" cy="64.1410662625706" cx="0"/>
                <circle fill="#BD6D03" r="3.5" cx="-138.917206226753" cy="0"/>
                <circle fill="#BD6D03" r="3.5" cx="66.23501859760296" cy="0"/>
            </g>
            <g id="esc1" transform="translate(440,350)" class="VaFdezSen">
                <polyline stroke="#B3A8CC" fill="none" stroke-width="2" points="0,-209.2879256965944 -130.6501547987616,0 0,48.297213622291025 11.764705882352956,0 0,-209.2879256965944"/>
                <polyline stroke="none" fill="#B3A8CC" opacity=".4" points="0,-209.2879256965944 -130.6501547987616,0 0,48.297213622291025 11.764705882352956,0 0,-209.2879256965944"/>
                <circle fill="#B3A8CC" r="3.5" cy="-209.2879256965944" cx="0"/>
                <circle fill="#B3A8CC" r="3.5" cy="48.297213622291025" cx="0"/>
                <circle fill="#B3A8CC" r="3.5" cx="-130.6501547987616" cy="0"/>
                <circle fill="#B3A8CC" r="3.5" cx="11.764705882352956" cy="0"/>
            </g>
            <g id="esc2" transform="translate(440,350)" class="JSrzSom">
                <polyline stroke="#CF4205" fill="none" stroke-width="2" points="0,-171.36563876651982 -100,0 0,108.37004405286343 20.264317180616757,0 0,-171.36563876651982"/>
                <polyline stroke="none" fill="#CF4205" opacity=".4" points="0,-171.36563876651982 -100,0 0,108.37004405286343 20.264317180616757,0 0,-171.36563876651982"/>
                <circle fill="#CF4205" r="3.5" cy="-171.36563876651982" cx="0"/>
                <circle fill="#CF4205" r="3.5" cy="108.37004405286343" cx="0"/>
                <circle fill="#CF4205" r="3.5" cx="-100" cy="0"/>
                <circle fill="#CF4205" r="3.5" cx="20.264317180616757" cy="0"/>
            </g>
            <g id="esc3" transform="translate(440,350)" class="PaySrzTav">
                <polyline stroke="#6C659D" fill="none" stroke-width="2" points="0,-94.36619718309859 -183.09859154929578,0 0,115.49295774647888 7.042253521126753,0 0,-94.36619718309859"/>
                <polyline stroke="none" fill="#6C659D" opacity=".4" points="0,-94.36619718309859 -183.09859154929578,0 0,115.49295774647888 7.042253521126753,0 0,-94.36619718309859"/>
                <circle fill="#6C659D" r="3.5" cy="-94.36619718309859" cx="0"/>
                <circle fill="#6C659D" r="3.5" cy="115.49295774647888" cx="0"/>
                <circle fill="#6C659D" r="3.5" cx="-183.09859154929578" cy="0"/>
                <circle fill="#6C659D" r="3.5" cx="7.042253521126753" cy="0"/>
            </g>
            <g id="esc4" transform="translate(440,350)" class="MartSrz">
                <polyline stroke="#009CA2" fill="none" stroke-width="2" points="0,-168.77076411960132 -137.54152823920265,0 0,76.74418604651163 16.9435215946844,0 0,-168.77076411960132"/>
                <polyline stroke="none" fill="#009CA2" opacity=".4" points="0,-168.77076411960132 -137.54152823920265,0 0,76.74418604651163 16.9435215946844,0 0,-168.77076411960132"/>
                <circle fill="#009CA2" r="3.5" cy="-168.77076411960132" cx="0"/>
                <circle fill="#009CA2" r="3.5" cy="76.74418604651163" cx="0"/>
                <circle fill="#009CA2" r="3.5" cx="-137.54152823920265" cy="0"/>
                <circle fill="#009CA2" r="3.5" cx="16.9435215946844" cy="0"/>
            </g>
            <g id="esc5" transform="translate(440,350)" class="AyCarp">
                <polyline stroke="#BC9650" fill="none" stroke-width="2" points="0,-238.55421686746988 -57.83132530120482,0 0,4.819277108433735 98.79518072289162,0 0,-238.55421686746988"/>
                <polyline stroke="none" fill="#BC9650" opacity=".4" points="0,-238.55421686746988 -57.83132530120482,0 0,4.819277108433735 98.79518072289162,0 0,-238.55421686746988"/>
                <circle fill="#BC9650" r="3.5" cy="-238.55421686746988" cx="0"/>
                <circle fill="#BC9650" r="3.5" cy="4.819277108433735" cx="0"/>
                <circle fill="#BC9650" r="3.5" cx="-57.83132530120482" cy="0"/>
                <circle fill="#BC9650" r="3.5" cx="98.79518072289162" cy="0"/>
            </g>
            <g id="esc6" transform="translate(440,350)" class="NuFdzTor">
                <polyline stroke="#233310" fill="none" stroke-width="2" points="0,-126.3157894736842 -143.2748538011696,0 0,39.1812865497076 91.22807017543862,0 0,-126.3157894736842"/>
                <polyline stroke="none" fill="#233310" opacity=".4" points="0,-126.3157894736842 -143.2748538011696,0 0,39.1812865497076 91.22807017543862,0 0,-126.3157894736842"/>
                <circle fill="#233310" r="3.5" cy="-126.3157894736842" cx="0"/>
                <circle fill="#233310" r="3.5" cy="39.1812865497076" cx="0"/>
                <circle fill="#233310" r="3.5" cx="-143.2748538011696" cy="0"/>
                <circle fill="#233310" r="3.5" cx="91.22807017543862" cy="0"/>
            </g>
            <g id="esc7" transform="translate(440,350)" class="PGarBu">
                <polyline stroke="#FFC938" fill="none" stroke-width="2" points="0,-198.45303867403314 -106.51933701657458,0 0,75.58011049723757 19.44751381215471,0 0,-198.45303867403314"/>
                <polyline stroke="none" fill="#FFC938" opacity=".4" points="0,-198.45303867403314 -106.51933701657458,0 0,75.58011049723757 19.44751381215471,0 0,-198.45303867403314"/>
                <circle fill="#FFC938" r="3.5" cy="-198.45303867403314" cx="0"/>
                <circle fill="#FFC938" r="3.5" cy="75.58011049723757" cx="0"/>
                <circle fill="#FFC938" r="3.5" cx="-106.51933701657458" cy="0"/>
                <circle fill="#FFC938" r="3.5" cx="19.44751381215471" cy="0"/>
            </g>
            <g id="esc8" transform="translate(440,350)" class="JLpzUlh">
                <polyline stroke="#5C647F" fill="none" stroke-width="2" points="0,-133.9421613394216 -99.23896499238965,0 0,106.54490106544901 60.27397260273975,0 0,-133.9421613394216"/>
                <polyline stroke="none" fill="#5C647F" opacity=".4" points="0,-133.9421613394216 -99.23896499238965,0 0,106.54490106544901 60.27397260273975,0 0,-133.9421613394216"/>
                <circle fill="#5C647F" r="3.5" cy="-133.9421613394216" cx="0"/>
                <circle fill="#5C647F" r="3.5" cy="106.54490106544901" cx="0"/>
                <circle fill="#5C647F" r="3.5" cx="-99.23896499238965" cy="0"/>
                <circle fill="#5C647F" r="3.5" cx="60.27397260273975" cy="0"/>
            </g>
            <g id="esc9" transform="translate(440,350)" class="PGmzBarr">
                <polyline stroke="#22461E" fill="none" stroke-width="2" points="0,-75.47169811320755 -184.9056603773585,0 0,50.943396226415096 88.67924528301886,0 0,-75.47169811320755"/>
                <polyline stroke="none" fill="#22461E" opacity=".4" points="0,-75.47169811320755 -184.9056603773585,0 0,50.943396226415096 88.67924528301886,0 0,-75.47169811320755"/>
                <circle fill="#22461E" r="3.5" cy="-75.47169811320755" cx="0"/>
                <circle fill="#22461E" r="3.5" cy="50.943396226415096" cx="0"/>
                <circle fill="#22461E" r="3.5" cx="-184.9056603773585" cy="0"/>
                <circle fill="#22461E" r="3.5" cx="88.67924528301886" cy="0"/>
            </g>
            <g id="esc10" transform="translate(440,350)" class="AfLpzBay">
                <polyline stroke="#EDDF81" fill="none" stroke-width="2" points="0,-183.6734693877551 -73.46938775510205,0 0,20.408163265306122 122.44897959183672,0 0,-183.6734693877551"/>
                <polyline stroke="none" fill="#EDDF81" opacity=".4" points="0,-183.6734693877551 -73.46938775510205,0 0,20.408163265306122 122.44897959183672,0 0,-183.6734693877551"/>
                <circle fill="#EDDF81" r="3.5" cy="-183.6734693877551" cx="0"/>
                <circle fill="#EDDF81" r="3.5" cy="20.408163265306122" cx="0"/>
                <circle fill="#EDDF81" r="3.5" cx="-73.46938775510205" cy="0"/>
                <circle fill="#EDDF81" r="3.5" cx="122.44897959183672" cy="0"/>
            </g>
            <g id="esc11" transform="translate(440,350)" class="JGarGlh">
                <polyline stroke="#6A643A" fill="none" stroke-width="2" points="0,-74.75149105367794 -257.6540755467197,0 0,23.856858846918488 43.73757455268388,0 0,-74.75149105367794"/>
                <polyline stroke="none" fill="#6A643A" opacity=".4" points="0,-74.75149105367794 -257.6540755467197,0 0,23.856858846918488 43.73757455268388,0 0,-74.75149105367794"/>
                <circle fill="#6A643A" r="3.5" cy="-74.75149105367794" cx="0"/>
                <circle fill="#6A643A" r="3.5" cy="23.856858846918488" cx="0"/>
                <circle fill="#6A643A" r="3.5" cx="-257.6540755467197" cy="0"/>
                <circle fill="#6A643A" r="3.5" cx="43.73757455268388" cy="0"/>
            </g>
            <g id="esc12" transform="translate(440,350)" class="EstFai">
                <polyline stroke="#B0E9ED" fill="none" stroke-width="2" points="0,-176.1904761904762 -52.38095238095238,0 0,0 171.4285714285714,0 0,-176.1904761904762"/>
                <polyline stroke="none" fill="#B0E9ED" opacity=".4" points="0,-176.1904761904762 -52.38095238095238,0 0,0 171.4285714285714,0 0,-176.1904761904762"/>
                <circle fill="#B0E9ED" r="3.5" cy="-176.1904761904762" cx="0"/>
                <circle fill="#B0E9ED" r="3.5" cy="0" cx="0"/>
                <circle fill="#B0E9ED" r="3.5" cx="-52.38095238095238" cy="0"/>
                <circle fill="#B0E9ED" r="3.5" cx="171.4285714285714" cy="0"/>
            </g>
            <g id="esc13" transform="translate(440,350)" class="JVqzTal">
                <polyline stroke="#B788A4" fill="none" stroke-width="2" points="0,-147.55555555555554 -133.33333333333334,0 0,23.11111111111111 95.99999999999997,0 0,-147.55555555555554"/>
                <polyline stroke="none" fill="#B788A4" opacity=".4" points="0,-147.55555555555554 -133.33333333333334,0 0,23.11111111111111 95.99999999999997,0 0,-147.55555555555554"/>
                <circle fill="#B788A4" r="3.5" cy="-147.55555555555554" cx="0"/>
                <circle fill="#B788A4" r="3.5" cy="23.11111111111111" cx="0"/>
                <circle fill="#B788A4" r="3.5" cx="-133.33333333333334" cy="0"/>
                <circle fill="#B788A4" r="3.5" cx="95.99999999999997" cy="0"/>
            </g>
            <g id="esc14" transform="translate(440,350)" class="PayGmzCha">
                <polyline stroke="#889BB7" fill="none" stroke-width="2" points="0,-111.91135734072022 -147.3684210526316,0 0,68.69806094182826 72.02216066481994,0 0,-111.91135734072022"/>
                <polyline stroke="none" fill="#889BB7" opacity=".4" points="0,-111.91135734072022 -147.3684210526316,0 0,68.69806094182826 72.02216066481994,0 0,-111.91135734072022"/>
                <circle fill="#889BB7" r="3.5" cy="-111.91135734072022" cx="0"/>
                <circle fill="#889BB7" r="3.5" cy="68.69806094182826" cx="0"/>
                <circle fill="#889BB7" r="3.5" cx="-147.3684210526316" cy="0"/>
                <circle fill="#889BB7" r="3.5" cx="72.02216066481994" cy="0"/>
            </g>
            <g id="esc15" transform="translate(440,350)" class="FerVelho">
                <polyline stroke="#73843A" fill="none" stroke-width="2" points="0,-90.59656218402426 -150.0505561172902,0 0,54.19615773508595 105.15672396359957,0 0,-90.59656218402426"/>
                <polyline stroke="none" fill="#73843A" opacity=".4" points="0,-90.59656218402426 -150.0505561172902,0 0,54.19615773508595 105.15672396359957,0 0,-90.59656218402426"/>
                <circle fill="#73843A" r="3.5" cy="-90.59656218402426" cx="0"/>
                <circle fill="#73843A" r="3.5" cy="54.19615773508595" cx="0"/>
                <circle fill="#73843A" r="3.5" cx="-150.0505561172902" cy="0"/>
                <circle fill="#73843A" r="3.5" cx="105.15672396359957" cy="0"/>
            </g>
            <g id="esc16" transform="translate(440,350)" class="PEaSol">
                <polyline stroke="#3d4144" fill="none" stroke-width="2" points="0,-74.66666666666667 -122.66666666666667,0 0,21.333333333333332 181.33333333333331,0 0,-74.66666666666667"/>
                <polyline stroke="none" fill="#3d4144" opacity=".4" points="0,-74.66666666666667 -122.66666666666667,0 0,21.333333333333332 181.33333333333331,0 0,-74.66666666666667"/>
                <circle fill="#3d4144" r="3.5" cy="-74.66666666666667" cx="0"/>
                <circle fill="#3d4144" r="3.5" cy="21.333333333333332" cx="0"/>
                <circle fill="#3d4144" r="3.5" cx="-122.66666666666667" cy="0"/>
                <circle fill="#3d4144" r="3.5" cx="181.33333333333331" cy="0"/>
            </g>
            <g id="esc17" transform="translate(440,350)" class="FerPad">
                <polyline stroke="#6A685A" fill="none" stroke-width="2" points="0,-60.273972602739725 -201.36986301369862,0 0,108.21917808219177 30.13698630136988,0 0,-60.273972602739725"/>
                <polyline stroke="none" fill="#6A685A" opacity=".4" points="0,-60.273972602739725 -201.36986301369862,0 0,108.21917808219177 30.13698630136988,0 0,-60.273972602739725"/>
                <circle fill="#6A685A" r="3.5" cy="-60.273972602739725" cx="0"/>
                <circle fill="#6A685A" r="3.5" cy="108.21917808219177" cx="0"/>
                <circle fill="#6A685A" r="3.5" cx="-201.36986301369862" cy="0"/>
                <circle fill="#6A685A" r="3.5" cx="30.13698630136988" cy="0"/>
            </g>
            <g id="esc18" transform="translate(440,350)" class="PPon">
                <polyline stroke="#2B6273" fill="none" stroke-width="2" points="0,-142.46575342465752 -118.98238747553816,0 0,72.01565557729941 66.53620352250488,0 0,-142.46575342465752"/>
                <polyline stroke="none" fill="#2B6273" opacity=".4" points="0,-142.46575342465752 -118.98238747553816,0 0,72.01565557729941 66.53620352250488,0 0,-142.46575342465752"/>
                <circle fill="#2B6273" r="3.5" cy="-142.46575342465752" cx="0"/>
                <circle fill="#2B6273" r="3.5" cy="72.01565557729941" cx="0"/>
                <circle fill="#2B6273" r="3.5" cx="-118.98238747553816" cy="0"/>
                <circle fill="#2B6273" r="3.5" cx="66.53620352250488" cy="0"/>
            </g>
            <g id="esc19" transform="translate(440,350)" class="VaRdzCal">
                <polyline stroke="#73473C" fill="none" stroke-width="2" points="0,-100.21786492374727 -92.37472766884531,0 0,64.4880174291939 142.9193899782135,0 0,-100.21786492374727"/>
                <polyline stroke="none" fill="#73473C" opacity=".4" points="0,-100.21786492374727 -92.37472766884531,0 0,64.4880174291939 142.9193899782135,0 0,-100.21786492374727"/>
                <circle fill="#73473C" r="3.5" cy="-100.21786492374727" cx="0"/>
                <circle fill="#73473C" r="3.5" cy="64.4880174291939" cx="0"/>
                <circle fill="#73473C" r="3.5" cx="-92.37472766884531" cy="0"/>
                <circle fill="#73473C" r="3.5" cx="142.9193899782135" cy="0"/>
            </g>
        </svg>
        <div>
            <ul class="radarF">
                <li>
                    <input id="per2" value="per2" class="per2" type="checkbox" checked="checked"/>
                    <label for="per2">Período 2</label>
                </li>
                <li>
                    <input id="per3" value="per3" class="per3" type="checkbox" checked="checked"/>
                    <label for="per3">Período 3</label>
                </li>
            </ul>
            <ul class="radarF">
                <li>
                    <input class="AfLpzBay" id="AfLpzBay" value="AfLpzBay" type="checkbox"/>
                    <label for="AfLpzBay">Afonso Lopez de Baian</label>
                </li>
                <li>
                    <input class="AyCarp" id="AyCarp" value="AyCarp" type="checkbox"/>
                    <label for="AyCarp">Airas Carpancho</label>
                </li>
                <li>
                    <input class="EstFai" id="EstFai" value="EstFai" type="checkbox"/>
                    <label for="EstFai">Estevan Faian</label>
                </li>
                <li>
                    <input class="FerPad" id="FerPad" value="FerPad" type="checkbox"/>
                    <label for="FerPad">Fernan Padron</label>
                </li>
                <li>
                    <input class="FerVelho" id="FerVelho" value="FerVelho" type="checkbox"/>
                    <label for="FerVelho">Fernan Velho</label>
                </li>
                <li>
                    <input class="JGarGlh" id="JGarGlh" value="JGarGlh" type="checkbox"/>
                    <label for="JGarGlh">Johan Garcia de Guilhade</label>
                </li>
                <li>
                    <input class="JLpzUlh" id="JLpzUlh" value="JLpzUlh" type="checkbox"/>
                    <label for="JLpzUlh">Johan Lopez de Ulhoa</label>
                </li>
                <li>
                    <input class="JSrzSom" id="JSrzSom" value="JSrzSom" type="checkbox"/>
                    <label for="JSrzSom">Johan Soarez Somesso</label>
                </li>
                <li>
                    <input class="JVqzTal" id="JVqzTal" value="JVqzTal" type="checkbox"/>
                    <label for="JVqzTal">Johan Vasquiz de Talaveira</label>
                </li>
                <li>
                    <input class="MartSrz" id="MartSrz" value="MartSrz" type="checkbox"/>
                    <label for="MartSrz">Martin Soarez</label>
                </li>
                <li>
                    <input class="NuFdzTor" id="NuFdzTor" value="NuFdzTor" type="checkbox"/>
                    <label for="NuFdzTor">Nuno Fernandez Torneol</label>
                </li>
                <li>
                    <input class="PayGmzCha" id="PayGmzCha" value="PayGmzCha" type="checkbox"/>
                    <label for="PayGmzCha">Pai Gomez Charinho</label>
                </li>
                <li>
                    <input class="PaySrzTav" id="PaySrzTav" value="PaySrzTav" type="checkbox"/>
                    <label for="PaySrzTav">Pai Soarez de Taveirós</label>
                </li>
                <li>
                    <input class="PEaSol" id="PEaSol" value="PEaSol" type="checkbox"/>
                    <label for="PEaSol">Pedr’ Eanes Solaz</label>
                </li>
                <li>
                    <input class="PGarBu" id="PGarBu" value="PGarBu" type="checkbox"/>
                    <label for="PGarBu">Pero Garcia de Burgalês</label>
                </li>
                <li>
                    <input class="PGmzBarr" id="PGmzBarr" value="PGmzBarr" type="checkbox"/>
                    <label for="PGmzBarr">Pero Gomez Barroso</label>
                </li>
                <li>
                    <input class="PPon" id="PPon" value="PPon" type="checkbox"/>
                    <label for="PPon">Pero da Ponte</label>
                </li>
                <li>
                    <input class="VaFdezSen" id="VaFdezSen" value="VaFdezSen" type="checkbox"/>
                    <label for="VaFdezSen">Vasco Fernandez Praga de Sandin</label>
                </li>
                <li>
                    <input class="VaRdzCal" id="VaRdzCal" value="VaRdzCal" type="checkbox"/>
                    <label for="VaRdzCal">Vasco Rodriguez de Calvelo</label>
                </li>
            </ul>
        </div>
    </div>
</main>
<!--#include virtual="ssi/footer.html"-->
</body>
</html>