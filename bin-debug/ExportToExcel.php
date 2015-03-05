<?php //Edits the deal selected from a Search Query
	include("../include/session.php");
	session_start();
	
	$separator  	='||';
	$p_info= $_GET['xml_file'];
	//$p_info= $argv[1];#$_GET['xml_file'];
	$p_information = explode($separator,$p_info);
	//$p_report	= $p_information[0];
	//$p_file = $p_report.'.xml';
	
	//$filename = '../report/'.$p_file;
	//$filename = $p_file;

	header("Content-type: application/vnd.ms-excel");
	header("Content-disposition: csv" . date("Y-m-d") . ".xls");
	print "<pre>";

$root = simplexml_load_string($p_info);
$data = get_object_vars($root);

$producten = array();

foreach ($data['row'] as $keys => $values) {
    $producten['row'][$keys] = get_object_vars($data['row']);
    
    foreach ($values as $key => $value) {
        $value = str_replace("\r\n", '<br />', $value);
        $value = str_replace("\r", '<br />', $value);
        $value = str_replace("\n", '<br />', $value);
        $producten['row'][$keys][$key] = $value; 
    }
    
}
print_R($producten);

print "</pre>";

	
	//echo $p_info;
//if (file_exists($filename)) {
  //print $p_info;  
	//$xml_file = simplexml_load_file($p_info);
//echo $p_info;
//print($p_info);
	//for ($i=0; $i<6; $i++) {
	//	$aging = $xml_file->month[$i];
	//	$heading[$i] = substr($aging['name'],0,11);
	//	$total[$i] = $aging['revenue'];
	//}
	
	//$new_page='Y';

	//$name = "Account Receivable Aging Report";
	//$report_date = date("F jS, Y");
	
	
	
	/*
	foreach ($xml_file->month[0]->region as $region) {

		if ($new_page=='Y') {
			$csv_output = $name."\r\n".$report_date;
			$csv_output.="\r\n\r\n";
			$csv_output.= "Client"."\t"."Client Name"."\t".$heading[0]."\t".substr($heading[1],0,10)."\t".$heading[2]."\t".$heading[3]."\t";
			$csv_output.=$heading[4]."\t".substr($heading[5],0,10);
			$csv_output.="\r\n";
			$new_page='N';
		} // heading information
	
		// Content
		$client_name = $region['name'];
		$client_code_name = trim($region['code_name']);
		
		$csv_output.=$client_name."\t".$client_code_name."\t";
		$csv_output.= $region['revenue']."\t";
		
		for ($i=1; $i<6; $i++) {
			foreach ($xml_file->month[$i]->region as $region) {
				if ((string)$region['name']==$client_name) {
					$csv_output.=$region['revenue']."\t";
					break;
				}
			}
		}

		$csv_output.="\r\n";
	
	}
	
	
	print $csv_output;
	*/
//} else {
 //	exit('Failed to open '.$filename.'.');
//}

?>
