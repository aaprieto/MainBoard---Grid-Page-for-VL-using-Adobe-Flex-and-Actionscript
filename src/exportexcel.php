<?php
/**
 * Export data, delivered in the POST, to excel.
 */
header('ETag: etagforie7download'); //IE7 requires this header
header('Content-type: application/octet-stream');
header('Content-disposition: attachment; filename="ActionGrid.xls"');

//Add html tags, so that excel can interpret it
echo "<html>
<body>
".stripslashes($_POST["htmltable"])."
</body>
</html>
";
?>
