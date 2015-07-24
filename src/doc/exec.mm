<map version="freeplane 1.3.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="Exec" ID="ID_1723255651" CREATED="1283093380553" MODIFIED="1436029674270"><hook NAME="MapStyle">

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node">
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right">
<stylenode LOCALIZED_TEXT="default" MAX_WIDTH="600" COLOR="#000000" STYLE="as_parent">
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.note"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important">
<icon BUILTIN="yes"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="7"/>
<node TEXT="setup" POSITION="right" ID="ID_1447540324" CREATED="1436029243648" MODIFIED="1436029253765">
<edge COLOR="#ff0000"/>
<node TEXT="load config" ID="ID_54225093" CREATED="1436170628693" MODIFIED="1436447804429">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="access" ID="ID_1672661859" CREATED="1436029289330" MODIFIED="1436029301561">
<node TEXT="local" ID="ID_491292806" CREATED="1436029302256" MODIFIED="1436472474203">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="ssh" ID="ID_1578584699" CREATED="1436029305215" MODIFIED="1436029315554"/>
</node>
<node TEXT="environment" ID="ID_625431312" CREATED="1436029320406" MODIFIED="1436770624771">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="balancing" ID="ID_1648144848" CREATED="1436029361209" MODIFIED="1436029382462">
<node TEXT="priority" ID="ID_1462649450" CREATED="1436029395107" MODIFIED="1436770644163">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="interaction" ID="ID_1406532989" CREATED="1436038058558" MODIFIED="1436038073697"/>
</node>
<node TEXT="run" POSITION="right" ID="ID_933097848" CREATED="1436037833705" MODIFIED="1436770615361">
<edge COLOR="#007c7c"/>
<node TEXT="local" ID="ID_1618989543" CREATED="1436339602274" MODIFIED="1436339605551">
<node TEXT="simple exec" ID="ID_1862933480" CREATED="1436170880080" MODIFIED="1436473695367">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="auto retry on EMFILE" ID="ID_999728760" CREATED="1436037925974" MODIFIED="1436472491400">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="nice values" ID="ID_1469287384" CREATED="1436556891914" MODIFIED="1436562109494">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="allow interactive control" ID="ID_572832876" CREATED="1436038079784" MODIFIED="1436038090664"/>
<node TEXT="detached" ID="ID_543362113" CREATED="1436524513491" MODIFIED="1436524517813">
<node TEXT="use detached option" ID="ID_756320188" CREATED="1436524517822" MODIFIED="1436524526281"/>
<node TEXT="pipe into file" ID="ID_1396385539" CREATED="1436524598196" MODIFIED="1436524601831"/>
<node TEXT="give another terminal" ID="ID_1136422264" CREATED="1436524526933" MODIFIED="1436524535888"/>
</node>
<node TEXT="pipe between executions" ID="ID_485269003" CREATED="1436170871616" MODIFIED="1436170878037">
<node TEXT="also local and remote" ID="ID_1490527234" CREATED="1436524682058" MODIFIED="1436524689485"/>
<node TEXT="not line based output stream" ID="ID_447289503" CREATED="1436975309683" MODIFIED="1436975333940"/>
<node TEXT="use setup.output -&gt; setup.input" ID="ID_747778314" CREATED="1436975287207" MODIFIED="1436975308265"/>
</node>
</node>
<node TEXT="remote" ID="ID_1665509690" CREATED="1436339606058" MODIFIED="1436339608319">
<node TEXT="same as local" ID="ID_1126751493" CREATED="1436339644266" MODIFIED="1436339647695"/>
<node TEXT="allow ssh" ID="ID_1859376564" CREATED="1436037855404" MODIFIED="1436037860422"/>
<node TEXT="external library" ID="ID_1312576238" CREATED="1436339840711" MODIFIED="1436339847460">
<node TEXT="ssh" ID="ID_646194072" CREATED="1436340747518" MODIFIED="1436340747710" LINK="../../../node-ssh/src/doc/Ssh.mm">
<edge STYLE="bezier" COLOR="#007c7c" WIDTH="thin"/>
</node>
</node>
<node TEXT="detached" ID="ID_615565894" CREATED="1436470147914" MODIFIED="1436524581887">
<node TEXT="using nohup" ID="ID_1971865139" CREATED="1436524583586" MODIFIED="1436524587799"/>
<node TEXT="pipe into file" ID="ID_1319905930" CREATED="1436470409375" MODIFIED="1436470456205"/>
</node>
</node>
</node>
<node TEXT="queue" POSITION="right" ID="ID_434436076" CREATED="1436029451152" MODIFIED="1437228605312">
<icon BUILTIN="button_ok"/>
<edge COLOR="#ff00ff"/>
<node TEXT="add" ID="ID_414921492" CREATED="1436977671413" MODIFIED="1437228518549">
<icon BUILTIN="button_ok"/>
<node TEXT="when" ID="ID_1334297107" CREATED="1436977983201" MODIFIED="1436980654191">
<icon BUILTIN="button_ok"/>
<node TEXT="if there is a queue for host" ID="ID_628284889" CREATED="1436977988941" MODIFIED="1436978122626"/>
<node TEXT="if load too high" ID="ID_476286157" CREATED="1436977998100" MODIFIED="1436978009460"/>
</node>
<node TEXT="create host entry" ID="ID_1654927860" CREATED="1436977756998" MODIFIED="1436980658262">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="create priority entry" ID="ID_822037601" CREATED="1436977767192" MODIFIED="1436980659342">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="push" ID="ID_763691517" CREATED="1436977778747" MODIFIED="1436980664226">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="enhance queue count" ID="ID_848275088" CREATED="1436977795299" MODIFIED="1436980666515">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="start worker if not running" ID="ID_400986175" CREATED="1436977944758" MODIFIED="1436992052390">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="worker" ID="ID_580447659" CREATED="1436029459610" MODIFIED="1437228599285">
<icon BUILTIN="button_ok"/>
<node TEXT="async hosts" ID="ID_1714626389" CREATED="1436978410824" MODIFIED="1436992057490">
<icon BUILTIN="button_ok"/>
<node TEXT="loop over priorities (reverse)" ID="ID_317159663" CREATED="1436978463727" MODIFIED="1437035792540">
<icon BUILTIN="button_ok"/>
<node TEXT="loop while not empty" ID="ID_632670261" CREATED="1436978707424" MODIFIED="1437035855509">
<icon BUILTIN="button_ok"/>
<node TEXT="check like on run" ID="ID_166699268" CREATED="1436978392506" MODIFIED="1436978629718"/>
<node TEXT="break if check failed" ID="ID_809999674" CREATED="1436978648108" MODIFIED="1436978743298"/>
<node TEXT="shift first exec" ID="ID_577971669" CREATED="1436978666969" MODIFIED="1436978939444"/>
<node TEXT="reduce counter" ID="ID_558520732" CREATED="1436978941896" MODIFIED="1436978950466"/>
<node TEXT="call exec" ID="ID_240404189" CREATED="1436978951050" MODIFIED="1436978960931"/>
</node>
<node TEXT="remove priority if empty" ID="ID_1566873329" CREATED="1436978508995" MODIFIED="1437035936790">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="remove host if no priorities" ID="ID_909961616" CREATED="1436978471704" MODIFIED="1437035998090">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="rerun worker" ID="ID_14238671" CREATED="1436978798878" MODIFIED="1437036255793">
<icon BUILTIN="button_ok"/>
<node TEXT="if not empty" ID="ID_1258767355" CREATED="1436978828720" MODIFIED="1436978841725"/>
<node TEXT="set timeout" ID="ID_1348573386" CREATED="1436978845866" MODIFIED="1436978850075"/>
</node>
</node>
<node TEXT="start limit" ID="ID_726520480" CREATED="1436029400011" MODIFIED="1437228601627">
<icon BUILTIN="button_ok"/>
<node TEXT="load in %cpu cores per sec" ID="ID_1528280920" CREATED="1436171645004" MODIFIED="1437121009932">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="config default" ID="ID_1415192331" CREATED="1437120638722" MODIFIED="1437120645825">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="max = defined * cores * vital.interval in sec" ID="ID_486317246" CREATED="1437116935000" MODIFIED="1437122375087">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="values per command" ID="ID_1338093572" CREATED="1437116984064" MODIFIED="1437125758149">
<icon BUILTIN="button_ok"/>
<node TEXT="single core max 1" ID="ID_1623626814" CREATED="1437117008383" MODIFIED="1437117017799"/>
<node TEXT="multi core support may be higher" ID="ID_53054216" CREATED="1437117018351" MODIFIED="1437117037599"/>
<node TEXT="calculate functions" ID="ID_1114022090" CREATED="1437121017852" MODIFIED="1437121024265"/>
<node TEXT="detect on run" ID="ID_1937358133" CREATED="1437121025235" MODIFIED="1437121073463"/>
</node>
<node TEXT="check" ID="ID_742877152" CREATED="1437122413047" MODIFIED="1437122414947">
<node TEXT="counter in vital data" ID="ID_325633212" CREATED="1437117042599" MODIFIED="1437122403423">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="calc command load" ID="ID_1972254435" CREATED="1437122448110" MODIFIED="1437122843400">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="error on too much" ID="ID_838861774" CREATED="1437122428719" MODIFIED="1437123229098">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="queue on reached max" ID="ID_1326109698" CREATED="1437117167645" MODIFIED="1437123231906">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="add new load" ID="ID_1860518209" CREATED="1437123045381" MODIFIED="1437123331569">
<icon BUILTIN="button_ok"/>
</node>
</node>
</node>
</node>
<node TEXT="exec" POSITION="right" ID="ID_1887028037" CREATED="1436029257625" MODIFIED="1436029262269">
<edge COLOR="#0000ff"/>
<node TEXT="run" ID="ID_860378377" CREATED="1436029485305" MODIFIED="1436884959986">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="set os priority" ID="ID_1278030147" CREATED="1436030321578" MODIFIED="1436884958442">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="capture stderr" ID="ID_1208848154" CREATED="1436029490338" MODIFIED="1436884961770">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="capture stdout" ID="ID_1734732274" CREATED="1436029498226" MODIFIED="1436884965986">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="get return code" ID="ID_1438270903" CREATED="1436029504360" MODIFIED="1436884968306">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="sudo support adding password interactively" ID="ID_529886181" CREATED="1437566272962" MODIFIED="1437566294784"/>
</node>
<node TEXT="analysis" POSITION="right" ID="ID_470690532" CREATED="1436029263143" MODIFIED="1437228622921">
<icon BUILTIN="button_ok"/>
<edge COLOR="#00ff00"/>
<node TEXT="general" ID="ID_1291874564" CREATED="1436029527757" MODIFIED="1436877738942">
<icon BUILTIN="button_ok"/>
<node TEXT="is success" ID="ID_39456210" CREATED="1436029538460" MODIFIED="1436029544248"/>
<node TEXT="no error output" ID="ID_965441403" CREATED="1436029544985" MODIFIED="1436029555773"/>
</node>
<node TEXT="special by command" ID="ID_43491547" CREATED="1436029557374" MODIFIED="1436029564139"/>
<node TEXT="optional parameters" ID="ID_1628914852" CREATED="1436451050125" MODIFIED="1436877748710">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="retry can be set or disabled per check routine" ID="ID_1533527074" CREATED="1436447416994" MODIFIED="1436941306760">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="lots of checks" ID="ID_1516639466" CREATED="1436037967443" MODIFIED="1436975218900">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="default check" ID="ID_1113021584" CREATED="1436450992164" MODIFIED="1436451005089">
<node TEXT="per command" ID="ID_428075005" CREATED="1436451005660" MODIFIED="1436451008497"/>
<node TEXT="exit code" ID="ID_1472574996" CREATED="1436451008973" MODIFIED="1436877759637">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="check&amp;queue" ID="ID_1334936873" CREATED="1436770416711" MODIFIED="1437228618565">
<icon BUILTIN="button_ok"/>
<node TEXT="check load and cpu" ID="ID_1966836609" CREATED="1436037942551" MODIFIED="1436975226759">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="use queue instead balancing" ID="ID_278973690" CREATED="1436037861046" MODIFIED="1436037888800"/>
</node>
</node>
<node TEXT="config" POSITION="left" ID="ID_1384921236" CREATED="1436029853475" MODIFIED="1436345494523">
<edge COLOR="#0000ff"/>
<node TEXT="exec %" ID="ID_721616872" CREATED="1436170664147" MODIFIED="1436170668175">
<node TEXT="retry" ID="ID_1623892696" CREATED="1436029994933" MODIFIED="1436171305590">
<node TEXT="vital" ID="ID_1030905992" CREATED="1436961380798" MODIFIED="1436961386531">
<node TEXT="interval" ID="ID_233084178" CREATED="1436961446573" MODIFIED="1436961449260"/>
<node TEXT="startload" ID="ID_13888257" CREATED="1437116820546" MODIFIED="1437116823991"/>
</node>
<node TEXT="queue" ID="ID_1210036437" CREATED="1436251539335" MODIFIED="1436251542536">
<node TEXT="intervall" ID="ID_1611147327" CREATED="1436251543095" MODIFIED="1436991477659"/>
</node>
<node TEXT="ulimit" ID="ID_242060467" CREATED="1436472556687" MODIFIED="1436472563291">
<node TEXT="interval" ID="ID_996020148" CREATED="1436171301169" MODIFIED="1436451921860"/>
</node>
<node TEXT="error" ID="ID_1840204305" CREATED="1436472553000" MODIFIED="1436472555945">
<node TEXT="times" ID="ID_1338544975" CREATED="1436171298297" MODIFIED="1436451918957"/>
<node TEXT="interval" ID="ID_1454777909" CREATED="1436171301169" MODIFIED="1436451921860"/>
</node>
</node>
<node TEXT="priority" ID="ID_1221620414" CREATED="1436039017792" MODIFIED="1436039022968">
<node TEXT="default" ID="ID_1924122896" CREATED="1436251555895" MODIFIED="1436255503796">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_1925705453" STARTINCLINATION="40;0;" ENDINCLINATION="40;0;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="level %" ID="ID_1925705453" CREATED="1436251563655" MODIFIED="1436251927598">
<node TEXT="maxCpu" ID="ID_1725512569" CREATED="1436171180723" MODIFIED="1436251933872"/>
<node TEXT="maxLoad @" ID="ID_1827479136" CREATED="1436171189483" MODIFIED="1436966309586"/>
<node TEXT="minFreemem" ID="ID_781779953" CREATED="1436965518115" MODIFIED="1436966054486"/>
<node TEXT="nice" ID="ID_161046493" CREATED="1436473728175" MODIFIED="1436473742337"/>
</node>
</node>
<node TEXT="remote %" ID="ID_536916200" CREATED="1436170440086" MODIFIED="1437228167036">
<node TEXT="server %" ID="ID_1955346723" CREATED="1436170453158" MODIFIED="1437569533831">
<node TEXT="host" ID="ID_586016262" CREATED="1436170459686" MODIFIED="1436170530658"/>
<node TEXT="port" ID="ID_408757702" CREATED="1436170469646" MODIFIED="1436170472018"/>
<node TEXT="username" ID="ID_1906546577" CREATED="1436170472742" MODIFIED="1436170523242"/>
<node TEXT="password" ID="ID_1590493339" CREATED="1436170544237" MODIFIED="1436170546801"/>
<node TEXT="privateKey" ID="ID_942859012" CREATED="1436170510621" MODIFIED="1436170520330"/>
<node TEXT="passphrase" ID="ID_1236598883" CREATED="1437671611132" MODIFIED="1437671615856"/>
<node TEXT="localHostname" ID="ID_380391757" CREATED="1437671620536" MODIFIED="1437671625318"/>
<node TEXT="localUsername" ID="ID_1610310982" CREATED="1437671625950" MODIFIED="1437671630848"/>
<node TEXT="readyTimeout" ID="ID_1262969958" CREATED="1437671638730" MODIFIED="1437671645738"/>
<node TEXT="minSpare" ID="ID_130161137" CREATED="1436348151549" MODIFIED="1436348244496"/>
<node TEXT="maxSpare" ID="ID_1192105431" CREATED="1436348237843" MODIFIED="1436348240834"/>
<node TEXT="maxSessions" ID="ID_202154109" CREATED="1436348168469" MODIFIED="1436348177649"/>
<node TEXT="startLoad" ID="ID_1474179530" CREATED="1437761049793" MODIFIED="1437761053960"/>
<node TEXT="debug" ID="ID_342348490" CREATED="1437673050645" MODIFIED="1437673053087"/>
</node>
<node TEXT="group %" ID="ID_1941333275" CREATED="1436339416717" MODIFIED="1437652812214">
<node TEXT="host" ID="ID_1542715155" CREATED="1436339474572" MODIFIED="1436340263941">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_1955346723" STARTINCLINATION="166;0;" ENDINCLINATION="166;0;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="weight" ID="ID_1932883655" CREATED="1436345722257" MODIFIED="1436345724695"/>
</node>
</node>
</node>
</node>
<node TEXT="variables" POSITION="left" ID="ID_1076575551" CREATED="1436170988318" MODIFIED="1436339710926">
<edge COLOR="#7c7c00"/>
<node TEXT="checks %" ID="ID_1983520150" CREATED="1436450787656" MODIFIED="1436967631295">
<node TEXT="noExitCode" ID="ID_1651837623" CREATED="1436185930466" MODIFIED="1436770490238">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="exitCode" ID="ID_1598169635" CREATED="1436450504180" MODIFIED="1436859159429">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="noStderr" ID="ID_1890703764" CREATED="1436185939681" MODIFIED="1436859298582">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="noStdout" ID="ID_1433754110" CREATED="1436859414492" MODIFIED="1436859422369">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="matchStdout" ID="ID_1245652364" CREATED="1436450529220" MODIFIED="1436876158798">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="matchStderr" ID="ID_389019434" CREATED="1436876174638" MODIFIED="1436876312219">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="notMatchStderr" ID="ID_868936594" CREATED="1436450730176" MODIFIED="1436877404387">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="vital %" ID="ID_1809729628" CREATED="1436940502908" MODIFIED="1436940517817">
<node TEXT="&lt;host&gt;" ID="ID_459603420" CREATED="1436940518980" MODIFIED="1436940524636">
<node TEXT="date" ID="ID_55665000" CREATED="1436940645898" MODIFIED="1436961829256">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="freemem" ID="ID_1947247314" CREATED="1436940524638" MODIFIED="1436962663684">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="load @" ID="ID_1500175968" CREATED="1436940530067" MODIFIED="1436962664604">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="cpu" ID="ID_489870090" CREATED="1436940540716" MODIFIED="1436962667220">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="error %" ID="ID_508077301" CREATED="1436965716958" MODIFIED="1437038586267">
<icon BUILTIN="button_ok"/>
<node TEXT="&lt;priority&gt;" ID="ID_901047782" CREATED="1437038576614" MODIFIED="1437038581059"/>
</node>
<node TEXT="startload" ID="ID_1728610117" CREATED="1437116728044" MODIFIED="1437161954949">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="startmax" ID="ID_337776231" CREATED="1437122204363" MODIFIED="1437161953422">
<icon BUILTIN="button_ok"/>
</node>
</node>
</node>
<node TEXT="load %" ID="ID_893355082" CREATED="1437120831799" MODIFIED="1437125736135">
<icon BUILTIN="button_ok"/>
<node TEXT="&lt;command&gt;" ID="ID_459151995" CREATED="1437120835566" MODIFIED="1437120839971">
<node TEXT="calc(args)" ID="ID_1593433383" CREATED="1437120860990" MODIFIED="1437120991505"/>
</node>
</node>
<node TEXT="queue @" ID="ID_381019589" CREATED="1436171001630" MODIFIED="1437125739014">
<icon BUILTIN="button_ok"/>
<node TEXT="&lt;host&gt; %" ID="ID_1377679401" CREATED="1436977199369" MODIFIED="1436977208471">
<node TEXT="&lt;priority&gt; @" ID="ID_1263479692" CREATED="1436171065677" MODIFIED="1436969934003">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_1925705453" STARTINCLINATION="330;0;" ENDINCLINATION="330;0;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<node TEXT="&lt;exec&gt;, &lt;cb&gt;" ID="ID_220713509" CREATED="1436171077037" MODIFIED="1437164547767">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_1723255651" STARTINCLINATION="574;163;" ENDINCLINATION="534;-14;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
</node>
</node>
</node>
<node TEXT="queueCounter" ID="ID_1369585402" CREATED="1436979036291" MODIFIED="1437125741510">
<icon BUILTIN="button_ok"/>
<node TEXT="total" ID="ID_404449436" CREATED="1436979047534" MODIFIED="1436979093945"/>
<node TEXT="host" ID="ID_1156783240" CREATED="1436979871406" MODIFIED="1436979873814">
<node TEXT="&lt;host&gt;" ID="ID_661468181" CREATED="1436979095603" MODIFIED="1436979099914"/>
</node>
<node TEXT="priority" ID="ID_902449507" CREATED="1436979874336" MODIFIED="1436979877795">
<node TEXT="&lt;priority&gt;" ID="ID_338119722" CREATED="1436979100907" MODIFIED="1436979888611"/>
</node>
</node>
<node TEXT="ssh module" ID="ID_1972153441" CREATED="1437652149928" MODIFIED="1437652195346">
<node TEXT="pool %" ID="ID_367321132" CREATED="1437228384813" MODIFIED="1437652907594">
<node TEXT="&lt;host&gt;" ID="ID_1561511090" CREATED="1437653271880" MODIFIED="1437653280590">
<node TEXT="spare @" ID="ID_593351566" CREATED="1437653166722" MODIFIED="1437653237821">
<node TEXT="session" ID="ID_1153875426" CREATED="1437228415271" MODIFIED="1437228418840"/>
</node>
<node TEXT="numActive" ID="ID_1396711201" CREATED="1437666799665" MODIFIED="1437666805385"/>
</node>
</node>
</node>
</node>
<node TEXT="functions" POSITION="left" ID="ID_911313217" CREATED="1436171726075" MODIFIED="1436171729215">
<edge COLOR="#ff0000"/>
<node TEXT="init" ID="ID_1605560095" CREATED="1436359118010" MODIFIED="1436446509384">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="worker" ID="ID_1936353585" CREATED="1437121141835" MODIFIED="1437121148617">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="vitalCheck host, prio, cb" ID="ID_383118005" CREATED="1436185099285" MODIFIED="1437121169601">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="run %, cb" ID="ID_393789216" CREATED="1436185800364" MODIFIED="1436969962127">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="new %" ID="ID_675503164" CREATED="1436029736081" MODIFIED="1436979287261">
<icon BUILTIN="button_ok"/>
<node TEXT="cmd" ID="ID_1313070801" CREATED="1436029739501" MODIFIED="1436029744811"/>
</node>
<node TEXT="check args" ID="ID_1875417745" CREATED="1436171732123" MODIFIED="1436979278670">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="attributes" POSITION="left" ID="ID_1066006853" CREATED="1436029608253" MODIFIED="1436029634427">
<edge COLOR="#7c0000"/>
<node TEXT="id" ID="ID_1772870427" CREATED="1436458703539" MODIFIED="1436458919160">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="name" ID="ID_1957745899" CREATED="1436459077273" MODIFIED="1436459084067">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="conf" ID="ID_157078514" CREATED="1436536940639" MODIFIED="1436536950273">
<icon BUILTIN="button_ok"/>
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_721616872" STARTINCLINATION="438;0;" ENDINCLINATION="438;0;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="setup" ID="ID_686373530" CREATED="1436029786090" MODIFIED="1436029789541">
<node TEXT="remote $" ID="ID_171151533" CREATED="1436169600844" MODIFIED="1436473554061">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="cmd $" ID="ID_686345533" CREATED="1436029942420" MODIFIED="1436473555075">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="args @" ID="ID_675501437" CREATED="1436030400187" MODIFIED="1436536954895">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="cwd $" ID="ID_773224343" CREATED="1436030418853" MODIFIED="1436536956424">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="env %" ID="ID_1202570489" CREATED="1436030437636" MODIFIED="1436536957343">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="uid $" ID="ID_1405472690" CREATED="1436030451817" MODIFIED="1436556873225">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="gid $" ID="ID_1950222415" CREATED="1436030456532" MODIFIED="1436556874540">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="priority $" ID="ID_115313343" CREATED="1436030477687" MODIFIED="1436556864141">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="check %" ID="ID_121957069" CREATED="1436448467146" MODIFIED="1436884389058">
<icon BUILTIN="button_ok"/>
<node TEXT="&lt;name&gt;" ID="ID_1201336243" CREATED="1436029945958" MODIFIED="1436967659702">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_1983520150" STARTINCLINATION="625;0;" ENDINCLINATION="625;0;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<node TEXT="args..." ID="ID_853320997" CREATED="1436451145803" MODIFIED="1436882802731">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="retry" ID="ID_887857873" CREATED="1436473627611" MODIFIED="1436883799275">
<icon BUILTIN="button_ok"/>
</node>
</node>
</node>
<node TEXT="retry %" ID="ID_470478861" CREATED="1436030496630" MODIFIED="1436883801907">
<icon BUILTIN="button_ok"/>
<node TEXT="times" ID="ID_122509269" CREATED="1436447507361" MODIFIED="1436451937452"/>
<node TEXT="interval" ID="ID_1449651575" CREATED="1436448393172" MODIFIED="1436451940612"/>
</node>
<node TEXT="input" ID="ID_649952384" CREATED="1436170902711" MODIFIED="1436170905124">
<node TEXT="exec" ID="ID_1585099935" CREATED="1436170928672" MODIFIED="1436170932163"/>
<node TEXT="file" ID="ID_679070778" CREATED="1436170933199" MODIFIED="1436170935411"/>
<node TEXT="string" ID="ID_555349476" CREATED="1436170939383" MODIFIED="1436170941859"/>
<node TEXT="function" ID="ID_469926482" CREATED="1436171426320" MODIFIED="1436171429124"/>
</node>
<node TEXT="output" ID="ID_1775359726" CREATED="1436975192113" MODIFIED="1436975195451"/>
<node TEXT="error" ID="ID_1207763484" CREATED="1437119187463" MODIFIED="1437119190012"/>
<node TEXT="fd3" ID="ID_1702693346" CREATED="1437119191223" MODIFIED="1437119234211">
<icon BUILTIN="help"/>
</node>
</node>
<node TEXT="proc" ID="ID_95985754" CREATED="1436463231633" MODIFIED="1436464627611">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="process" ID="ID_817628295" CREATED="1436030653080" MODIFIED="1436169579725">
<node TEXT="host" ID="ID_486027485" CREATED="1436340839608" MODIFIED="1436463758408">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="pid" ID="ID_208938701" CREATED="1436030545604" MODIFIED="1436463644813">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="start" ID="ID_1221120733" CREATED="1436030558023" MODIFIED="1436463759673">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="end" ID="ID_129310038" CREATED="1436030563087" MODIFIED="1436556212053">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="error" ID="ID_811053906" CREATED="1436030587365" MODIFIED="1436465694603">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="result %" ID="ID_1368487173" CREATED="1436029795105" MODIFIED="1436772366185">
<node TEXT="lines @" ID="ID_167952074" CREATED="1436772007799" MODIFIED="1436772361313">
<icon BUILTIN="button_ok"/>
<node TEXT="&lt;stream&gt;" ID="ID_728540734" CREATED="1436029881189" MODIFIED="1436465041825">
<node TEXT="0" OBJECT="java.lang.Long|0" ID="ID_1723032872" CREATED="1436464855219" MODIFIED="1436464857780">
<node TEXT="stdin" ID="ID_299918216" CREATED="1436464980546" MODIFIED="1436465158592"/>
</node>
<node TEXT="1" OBJECT="java.lang.Long|1" ID="ID_96736261" CREATED="1436464830013" MODIFIED="1436464848707">
<node TEXT="stdout" ID="ID_1747523765" CREATED="1436464985768" MODIFIED="1436464992874"/>
</node>
<node TEXT="2" OBJECT="java.lang.Long|2" ID="ID_1744769317" CREATED="1436464849470" MODIFIED="1436464850725">
<node TEXT="stderr" ID="ID_595492357" CREATED="1436464994287" MODIFIED="1436464997415"/>
</node>
</node>
</node>
<node TEXT="stderr" ID="ID_1402109980" CREATED="1436772023447" MODIFIED="1436772373865">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="stdout" ID="ID_1317702667" CREATED="1436772034423" MODIFIED="1436772375953">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="code" ID="ID_1310025452" CREATED="1436029883907" MODIFIED="1436465910777">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="error $" ID="ID_4384582" CREATED="1436772013855" MODIFIED="1436884372163">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="tries @" ID="ID_1076866559" CREATED="1436883941793" MODIFIED="1436884363035">
<icon BUILTIN="button_ok"/>
<node TEXT="process" ID="ID_978185399" CREATED="1436883965417" MODIFIED="1436883970414"/>
<node TEXT="result" ID="ID_1389860164" CREATED="1436883971129" MODIFIED="1436883974589"/>
</node>
</node>
<node TEXT="methods" POSITION="left" ID="ID_790807528" CREATED="1436029634949" MODIFIED="1436029639669">
<edge COLOR="#00007c"/>
<node TEXT="run" ID="ID_180461545" CREATED="1436185823707" MODIFIED="1436185825647">
<node TEXT="local" ID="ID_564359161" CREATED="1436169568732" MODIFIED="1436466269318">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="ssh" ID="ID_903563684" CREATED="1436164725599" MODIFIED="1436164729006"/>
</node>
<node TEXT="vital" ID="ID_913707597" CREATED="1436969989142" MODIFIED="1436969992003">
<node TEXT="local" ID="ID_1315454937" CREATED="1436969992766" MODIFIED="1436969999374">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="ssh" ID="ID_810616583" CREATED="1436969995126" MODIFIED="1436969996187"/>
</node>
<node TEXT="addQueue" ID="ID_712363113" CREATED="1437121230593" MODIFIED="1437121239321">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="checkResult" ID="ID_1106553411" CREATED="1437121234361" MODIFIED="1437121238784">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="stderr" ID="ID_1054101510" CREATED="1436466252557" MODIFIED="1436467290227">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="stdout" ID="ID_1974853685" CREATED="1436466247402" MODIFIED="1436467289310">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="signal" ID="ID_865539441" CREATED="1436185840851" MODIFIED="1436447589108"/>
<node TEXT="rerun" ID="ID_635881055" CREATED="1436447600280" MODIFIED="1436447602908"/>
</node>
<node TEXT="events" POSITION="left" ID="ID_1992863433" CREATED="1436465637978" MODIFIED="1436465641826">
<edge COLOR="#00ffff"/>
<node TEXT="stdout" ID="ID_1568321938" CREATED="1436465642793" MODIFIED="1436465655817">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="stderr" ID="ID_352681635" CREATED="1436465647400" MODIFIED="1436465656708">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="done" ID="ID_1115585838" CREATED="1436466140170" MODIFIED="1436466145186">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node TEXT="ssh" POSITION="right" ID="ID_1507317336" CREATED="1437228456424" MODIFIED="1437228459583">
<edge COLOR="#7c7c00"/>
<node TEXT="idea" ID="ID_298992304" CREATED="1436339879166" MODIFIED="1437228478872">
<node TEXT="multiple sessions to same host" ID="ID_15089891" CREATED="1436340969390" MODIFIED="1436340981171"/>
<node TEXT="keep sessions open" ID="ID_1852941333" CREATED="1436339908414" MODIFIED="1436339915310">
<node TEXT="minSessions" ID="ID_1857024959" CREATED="1436339915313" MODIFIED="1436339919034"/>
<node TEXT="maxSessions" ID="ID_1516146035" CREATED="1436339919502" MODIFIED="1436339924443"/>
</node>
<node TEXT="host list" ID="ID_926047134" CREATED="1436339999117" MODIFIED="1436340988227"/>
<node TEXT="use pooling" ID="ID_1384488022" CREATED="1436339648082" MODIFIED="1436339657270">
<node TEXT="find open session" ID="ID_1946302979" CREATED="1436345360430" MODIFIED="1436345380210"/>
<node TEXT="use balance to create new ones" ID="ID_670220986" CREATED="1436345384685" MODIFIED="1436345393746"/>
</node>
<node TEXT="balance methods" ID="ID_731422802" CREATED="1436345346494" MODIFIED="1436345350298">
<node TEXT="randomized" ID="ID_1488377962" CREATED="1436340317144" MODIFIED="1436340320357">
<node TEXT="possible" ID="ID_1227871592" CREATED="1436345403277" MODIFIED="1436345431881"/>
</node>
<node TEXT="round robin" ID="ID_1273078587" CREATED="1436339731560" MODIFIED="1436345409861">
<node TEXT="possible" ID="ID_387182035" CREATED="1436345409863" MODIFIED="1436345428570"/>
</node>
<node TEXT="least session num" ID="ID_304972690" CREATED="1436339772576" MODIFIED="1436345436781">
<node TEXT="possible" ID="ID_1359608847" CREATED="1436345436783" MODIFIED="1436345441233"/>
<node TEXT="use lowest sessions / weight" ID="ID_252018804" CREATED="1436345732984" MODIFIED="1436345797076"/>
</node>
<node TEXT="current cpu" ID="ID_1716978312" CREATED="1436340023380" MODIFIED="1436340028849"/>
<node TEXT="current load" ID="ID_654183636" CREATED="1436340029956" MODIFIED="1436340032873"/>
<node TEXT="weight" ID="ID_1747186966" CREATED="1437252035739" MODIFIED="1437252039308"/>
</node>
</node>
<node TEXT="start" ID="ID_477986187" CREATED="1436340802025" MODIFIED="1437228478878">
<node TEXT="host" ID="ID_1897091015" CREATED="1436347712227" MODIFIED="1436347738591">
<node TEXT="get vital data" ID="ID_1861413859" CREATED="1437252182412" MODIFIED="1437252188392"/>
<node TEXT="find free one" ID="ID_322522340" CREATED="1436347852061" MODIFIED="1436347887045"/>
<node TEXT="wait if max reached" ID="ID_345887140" CREATED="1436347905016" MODIFIED="1436347914461"/>
<node TEXT="create new if no free" ID="ID_1055766126" CREATED="1436347887728" MODIFIED="1436347903381"/>
</node>
<node TEXT="pool" ID="ID_1685680905" CREATED="1436347738843" MODIFIED="1436347740767">
<node TEXT="use balance host list" ID="ID_481692746" CREATED="1437252096253" MODIFIED="1437252107491"/>
<node TEXT="find first free session" ID="ID_656790951" CREATED="1437252108371" MODIFIED="1437252133012"/>
<node TEXT="find first host not ob&#x1d8;erloaded" ID="ID_1254665702" CREATED="1437252134502" MODIFIED="1437252159666"/>
</node>
<node TEXT="recheck load" ID="ID_198342900" CREATED="1436348536487" MODIFIED="1436348639146"/>
</node>
<node TEXT="end" ID="ID_501416286" CREATED="1436348382193" MODIFIED="1437228478881">
<node TEXT="set Status to done" ID="ID_144257713" CREATED="1436348392849" MODIFIED="1436348399877"/>
</node>
<node TEXT="done" ID="ID_35429084" CREATED="1436348013039" MODIFIED="1437228478920">
<node TEXT="spare possible" ID="ID_1665017932" CREATED="1436348064486" MODIFIED="1436348434413">
<node TEXT="current free &lt; maxSpare" ID="ID_400517047" CREATED="1436348435208" MODIFIED="1436348473789"/>
<node TEXT="cleanup data" ID="ID_246854541" CREATED="1436348474960" MODIFIED="1436348526515"/>
<node TEXT="recheck load" ID="ID_1308356917" CREATED="1436348536487" MODIFIED="1436348639146"/>
</node>
<node TEXT="to few spare" ID="ID_1477989118" CREATED="1436348488799" MODIFIED="1436348503204">
<node TEXT="current free &lt; minSpare" ID="ID_1932942168" CREATED="1436348506487" MODIFIED="1436348515852"/>
<node TEXT="create new session" ID="ID_246221469" CREATED="1436348790067" MODIFIED="1436348794887"/>
</node>
</node>
</node>
</node>
</map>
