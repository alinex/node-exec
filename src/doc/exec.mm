<map version="freeplane 1.3.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="Exec" FOLDED="false" ID="ID_1723255651" CREATED="1283093380553" MODIFIED="1436029674270"><hook NAME="MapStyle">

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
<hook NAME="AutomaticEdgeColor" COUNTER="5"/>
<node TEXT="ideas" POSITION="right" ID="ID_933097848" CREATED="1436037833705" MODIFIED="1436037847047">
<edge COLOR="#007c7c"/>
<node TEXT="local" ID="ID_1618989543" CREATED="1436339602274" MODIFIED="1436339605551">
<node TEXT="simple exec" ID="ID_1862933480" CREATED="1436170880080" MODIFIED="1436473695367">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="auto retry on EMFILE" ID="ID_999728760" CREATED="1436037925974" MODIFIED="1436472491400">
<icon BUILTIN="button_ok"/>
<node TEXT="unshift to queue" ID="ID_1779977745" CREATED="1436171122797" MODIFIED="1436171128000"/>
</node>
<node TEXT="use queue instead balancing" ID="ID_278973690" CREATED="1436037861046" MODIFIED="1436037888800"/>
<node TEXT="check load and cpu" ID="ID_1966836609" CREATED="1436037942551" MODIFIED="1436037951700"/>
<node TEXT="lots of checks" ID="ID_1516639466" CREATED="1436037967443" MODIFIED="1436037985070"/>
<node TEXT="allow interactive control" ID="ID_572832876" CREATED="1436038079784" MODIFIED="1436038090664"/>
<node TEXT="detached" ID="ID_543362113" CREATED="1436524513491" MODIFIED="1436524517813">
<node TEXT="use detached option" ID="ID_756320188" CREATED="1436524517822" MODIFIED="1436524526281"/>
<node TEXT="pipe into file" ID="ID_1396385539" CREATED="1436524598196" MODIFIED="1436524601831"/>
<node TEXT="give another terminal" ID="ID_1136422264" CREATED="1436524526933" MODIFIED="1436524535888"/>
</node>
<node TEXT="pipe between executions" ID="ID_485269003" CREATED="1436170871616" MODIFIED="1436170878037">
<node TEXT="also local and remote" ID="ID_1490527234" CREATED="1436524682058" MODIFIED="1436524689485"/>
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
<node TEXT="environment" ID="ID_625431312" CREATED="1436029320406" MODIFIED="1436029325960"/>
<node TEXT="balancing" ID="ID_1648144848" CREATED="1436029361209" MODIFIED="1436029382462">
<node TEXT="priority" ID="ID_1462649450" CREATED="1436029395107" MODIFIED="1436029399413"/>
<node TEXT="weight" ID="ID_726520480" CREATED="1436029400011" MODIFIED="1436029402987">
<node TEXT="? maybe no because of CPU monitoring" ID="ID_1528280920" CREATED="1436171645004" MODIFIED="1436171661936"/>
</node>
</node>
<node TEXT="interaction" ID="ID_1406532989" CREATED="1436038058558" MODIFIED="1436038073697"/>
</node>
<node TEXT="load" POSITION="right" ID="ID_434436076" CREATED="1436029451152" MODIFIED="1436030046765">
<edge COLOR="#ff00ff"/>
<node TEXT="queue" ID="ID_580447659" CREATED="1436029459610" MODIFIED="1436030052837">
<node TEXT="wait" ID="ID_1635207142" CREATED="1436030232840" MODIFIED="1436030236936">
<node TEXT="run if queues empty else add" ID="ID_391689135" CREATED="1436184923864" MODIFIED="1436184960852"/>
<node TEXT="recheck after time if load too high" ID="ID_453948171" CREATED="1436184873017" MODIFIED="1436184891293"/>
<node TEXT="stop work() if empty" ID="ID_79959843" CREATED="1436184892105" MODIFIED="1436185042827"/>
</node>
<node TEXT="priority n-0" ID="ID_836330965" CREATED="1436030252633" MODIFIED="1436255475457"/>
</node>
<node TEXT="sleep" ID="ID_1011063329" CREATED="1436030238937" MODIFIED="1436030242598">
<node TEXT="node ,load" ID="ID_270531011" CREATED="1436038350318" MODIFIED="1436038357659"/>
<node TEXT="cpu load (from /proc/stat)" ID="ID_855082880" CREATED="1436030274816" MODIFIED="1436185663915"/>
<node TEXT="system load (from spawn)" ID="ID_1571548608" CREATED="1436029472127" MODIFIED="1436185526108"/>
</node>
<node TEXT="start limit ???" ID="ID_775059132" CREATED="1436030268611" MODIFIED="1436185698929"/>
</node>
<node TEXT="exec" POSITION="right" ID="ID_1887028037" CREATED="1436029257625" MODIFIED="1436029262269">
<edge COLOR="#0000ff"/>
<node TEXT="run" ID="ID_860378377" CREATED="1436029485305" MODIFIED="1436029489407"/>
<node TEXT="set os priority" ID="ID_1278030147" CREATED="1436030321578" MODIFIED="1436030341930"/>
<node TEXT="capture stderr" ID="ID_1208848154" CREATED="1436029490338" MODIFIED="1436029497306"/>
<node TEXT="capture stdout" ID="ID_1734732274" CREATED="1436029498226" MODIFIED="1436029503465"/>
<node TEXT="get return code" ID="ID_1438270903" CREATED="1436029504360" MODIFIED="1436029512517"/>
</node>
<node TEXT="analysis" POSITION="right" ID="ID_470690532" CREATED="1436029263143" MODIFIED="1436029269585">
<edge COLOR="#00ff00"/>
<node TEXT="general" ID="ID_1291874564" CREATED="1436029527757" MODIFIED="1436029538453">
<node TEXT="is success" ID="ID_39456210" CREATED="1436029538460" MODIFIED="1436029544248"/>
<node TEXT="no error output" ID="ID_965441403" CREATED="1436029544985" MODIFIED="1436029555773"/>
</node>
<node TEXT="special by command" ID="ID_43491547" CREATED="1436029557374" MODIFIED="1436029564139"/>
<node TEXT="optional parameters" ID="ID_1628914852" CREATED="1436451050125" MODIFIED="1436451057552"/>
<node TEXT="retry can be set or disabled per check routine" ID="ID_1533527074" CREATED="1436447416994" MODIFIED="1436447463070"/>
<node TEXT="default check" ID="ID_1113021584" CREATED="1436450992164" MODIFIED="1436451005089">
<node TEXT="per command" ID="ID_428075005" CREATED="1436451005660" MODIFIED="1436451008497"/>
<node TEXT="exit code" ID="ID_1472574996" CREATED="1436451008973" MODIFIED="1436451013161"/>
</node>
</node>
<node TEXT="config" POSITION="left" ID="ID_1384921236" CREATED="1436029853475" MODIFIED="1436345494523">
<edge COLOR="#0000ff"/>
<node TEXT="exec %" ID="ID_721616872" CREATED="1436170664147" MODIFIED="1436170668175">
<node TEXT="retry" ID="ID_1623892696" CREATED="1436029994933" MODIFIED="1436171305590">
<node TEXT="error" ID="ID_1840204305" CREATED="1436472553000" MODIFIED="1436472555945">
<node TEXT="times" ID="ID_1338544975" CREATED="1436171298297" MODIFIED="1436451918957"/>
<node TEXT="interval" ID="ID_1454777909" CREATED="1436171301169" MODIFIED="1436451921860"/>
</node>
<node TEXT="ulimit" ID="ID_242060467" CREATED="1436472556687" MODIFIED="1436472563291">
<node TEXT="interval" ID="ID_996020148" CREATED="1436171301169" MODIFIED="1436451921860"/>
</node>
</node>
<node TEXT="priority" ID="ID_1221620414" CREATED="1436039017792" MODIFIED="1436039022968">
<node TEXT="default" ID="ID_1924122896" CREATED="1436251555895" MODIFIED="1436255503796">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="80" FONT_SIZE="12" FONT_FAMILY="SansSerif" DESTINATION="ID_1925705453" STARTINCLINATION="40;0;" ENDINCLINATION="40;0;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="level %" ID="ID_1925705453" CREATED="1436251563655" MODIFIED="1436251927598">
<node TEXT="maxCpu" ID="ID_1725512569" CREATED="1436171180723" MODIFIED="1436251933872"/>
<node TEXT="maxLoad" ID="ID_1827479136" CREATED="1436171189483" MODIFIED="1436171219144"/>
<node TEXT="nice" ID="ID_161046493" CREATED="1436473728175" MODIFIED="1436473742337"/>
</node>
</node>
<node TEXT="queue" ID="ID_1210036437" CREATED="1436251539335" MODIFIED="1436251542536">
<node TEXT="recheck" ID="ID_1611147327" CREATED="1436251543095" MODIFIED="1436251545468"/>
</node>
</node>
</node>
<node TEXT="variables" POSITION="left" ID="ID_1076575551" CREATED="1436170988318" MODIFIED="1436339710926">
<edge COLOR="#7c7c00"/>
<node TEXT="queue @" ID="ID_381019589" CREATED="1436171001630" MODIFIED="1436171064865">
<node TEXT="&lt;priority&gt; @" ID="ID_1263479692" CREATED="1436171065677" MODIFIED="1436171075633">
<node TEXT="&lt;exec&gt;" ID="ID_220713509" CREATED="1436171077037" MODIFIED="1436171082794"/>
</node>
</node>
<node TEXT="worker" ID="ID_334182792" CREATED="1436185062326" MODIFIED="1436185069466"/>
<node TEXT="checks" ID="ID_1983520150" CREATED="1436450787656" MODIFIED="1436450839721">
<node TEXT="general %" ID="ID_67520548" CREATED="1436450706489" MODIFIED="1436450827207">
<node TEXT="noErrorCode" ID="ID_1651837623" CREATED="1436185930466" MODIFIED="1436450495796"/>
<node TEXT="noErrorOutput" ID="ID_1890703764" CREATED="1436185939681" MODIFIED="1436185946534"/>
<node TEXT="allowedExitCodes" ID="ID_1598169635" CREATED="1436450504180" MODIFIED="1436450510779"/>
<node TEXT="outputPattern" ID="ID_1245652364" CREATED="1436450529220" MODIFIED="1436450533793"/>
<node TEXT="errorPattern" ID="ID_868936594" CREATED="1436450730176" MODIFIED="1436450733549"/>
</node>
<node TEXT="command %" ID="ID_296663013" CREATED="1436450806903" MODIFIED="1436450822430"/>
</node>
</node>
<node TEXT="functions" POSITION="left" ID="ID_911313217" CREATED="1436171726075" MODIFIED="1436171729215">
<edge COLOR="#ff0000"/>
<node TEXT="init" ID="ID_1605560095" CREATED="1436359118010" MODIFIED="1436446509384">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="check name, params" ID="ID_1875417745" CREATED="1436171732123" MODIFIED="1436450675119"/>
<node TEXT="queue prio, exec" ID="ID_383118005" CREATED="1436185099285" MODIFIED="1436185750208"/>
<node TEXT="new %" ID="ID_675503164" CREATED="1436029736081" MODIFIED="1436029761312">
<node TEXT="cmd" ID="ID_1313070801" CREATED="1436029739501" MODIFIED="1436029744811"/>
</node>
<node TEXT="run exec, cb" ID="ID_507045945" CREATED="1436185752380" MODIFIED="1436185809952"/>
<node TEXT="run %, cb" ID="ID_393789216" CREATED="1436185800364" MODIFIED="1436185806920"/>
</node>
<node TEXT="attributes" POSITION="left" ID="ID_1066006853" CREATED="1436029608253" MODIFIED="1436029634427">
<edge COLOR="#7c0000"/>
<node TEXT="id" ID="ID_1772870427" CREATED="1436458703539" MODIFIED="1436458919160">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="name" ID="ID_1957745899" CREATED="1436459077273" MODIFIED="1436459084067">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="setup" ID="ID_686373530" CREATED="1436029786090" MODIFIED="1436029789541">
<node TEXT="remote $" ID="ID_171151533" CREATED="1436169600844" MODIFIED="1436473554061">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="cmd $" ID="ID_686345533" CREATED="1436029942420" MODIFIED="1436473555075">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="args @" ID="ID_675501437" CREATED="1436030400187" MODIFIED="1436030407503"/>
<node TEXT="cwd $" ID="ID_773224343" CREATED="1436030418853" MODIFIED="1436030431119"/>
<node TEXT="env %" ID="ID_1202570489" CREATED="1436030437636" MODIFIED="1436030445336"/>
<node TEXT="uid $" ID="ID_1405472690" CREATED="1436030451817" MODIFIED="1436030455391"/>
<node TEXT="gid $" ID="ID_1950222415" CREATED="1436030456532" MODIFIED="1436030459123"/>
<node TEXT="priority $" ID="ID_115313343" CREATED="1436030477687" MODIFIED="1436030488628"/>
<node TEXT="check @" ID="ID_121957069" CREATED="1436448467146" MODIFIED="1436451097578">
<node TEXT="name &amp;" ID="ID_1201336243" CREATED="1436029945958" MODIFIED="1436451108696"/>
<node TEXT="arg..." ID="ID_853320997" CREATED="1436451145803" MODIFIED="1436451149287"/>
<node TEXT="retry" ID="ID_887857873" CREATED="1436473627611" MODIFIED="1436473637948">
<node TEXT="true||false" ID="ID_243641372" CREATED="1436473640006" MODIFIED="1436473650470"/>
</node>
</node>
<node TEXT="retry %" ID="ID_470478861" CREATED="1436030496630" MODIFIED="1436448532294">
<node TEXT="times" ID="ID_122509269" CREATED="1436447507361" MODIFIED="1436451937452"/>
<node TEXT="interval" ID="ID_1449651575" CREATED="1436448393172" MODIFIED="1436451940612"/>
</node>
<node TEXT="input" ID="ID_649952384" CREATED="1436170902711" MODIFIED="1436170905124">
<node TEXT="exec" ID="ID_1585099935" CREATED="1436170928672" MODIFIED="1436170932163"/>
<node TEXT="file" ID="ID_679070778" CREATED="1436170933199" MODIFIED="1436170935411"/>
<node TEXT="string" ID="ID_555349476" CREATED="1436170939383" MODIFIED="1436170941859"/>
<node TEXT="function" ID="ID_469926482" CREATED="1436171426320" MODIFIED="1436171429124"/>
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
<node TEXT="end" ID="ID_129310038" CREATED="1436030563087" MODIFIED="1436030564710"/>
<node TEXT="error" ID="ID_811053906" CREATED="1436030587365" MODIFIED="1436465694603">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="retrycount" ID="ID_541466901" CREATED="1436030621008" MODIFIED="1436030628765"/>
</node>
<node TEXT="result @" ID="ID_1368487173" CREATED="1436029795105" MODIFIED="1436465663240">
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
<node TEXT="&lt;line&gt;" ID="ID_1228422029" CREATED="1436464927826" MODIFIED="1436464939691"/>
</node>
<node TEXT="code" ID="ID_1310025452" CREATED="1436029883907" MODIFIED="1436465910777">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="control @%" ID="ID_1715992502" CREATED="1436039225105" MODIFIED="1436039286670">
<node TEXT="time" ID="ID_1152179483" CREATED="1436039260753" MODIFIED="1436039279230"/>
<node TEXT="virt mem" ID="ID_529615514" CREATED="1436039288349" MODIFIED="1436039373861"/>
<node TEXT="res mem" ID="ID_1993255707" CREATED="1436039374567" MODIFIED="1436039379078"/>
<node TEXT="status" ID="ID_299649464" CREATED="1436039413738" MODIFIED="1436039417977"/>
<node TEXT="%cpu" ID="ID_1646622193" CREATED="1436039426716" MODIFIED="1436039430889"/>
<node TEXT="%mem" ID="ID_1381463914" CREATED="1436039432020" MODIFIED="1436039446663"/>
<node TEXT="time" ID="ID_863022163" CREATED="1436039463352" MODIFIED="1436039466383"/>
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
<node TEXT="signal" ID="ID_865539441" CREATED="1436185840851" MODIFIED="1436447589108"/>
<node TEXT="rerun" ID="ID_635881055" CREATED="1436447600280" MODIFIED="1436447602908"/>
<node TEXT="stdout" ID="ID_1974853685" CREATED="1436466247402" MODIFIED="1436467289310">
<icon BUILTIN="button_ok"/>
</node>
<node TEXT="stderr" ID="ID_1054101510" CREATED="1436466252557" MODIFIED="1436467290227">
<icon BUILTIN="button_ok"/>
</node>
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
</node>
</map>
