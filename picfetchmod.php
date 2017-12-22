<?php

foreach( $argv as $arg)
{
	if(end(explode(".",$arg))!="html") continue;
	$filename = $arg; 
	echo "\n===============================================================\nFile:$filename\n";
	$handle = fopen($filename, "r");
	$patt='(https://[a-zA-Z\._/0-9\-]+_n.jpg)';
	$resstr='(\/s[0-9]+x[0-9]+)';
	$pcontent=fread($handle, filesize($filename));
	if(preg_match_all($patt,$pcontent,$matches))
	{
		$totalstr=array();
		foreach($matches[0] as $m )
		    {
				if(preg_match($resstr,$m)) continue;
				array_push($totalstr,$m);
			}
			$totalstr=array_unique($totalstr);
			foreach($totalstr as $m)
				echo "\nMatch :$m";
			$totalstr=implode(" ",$totalstr);
			echo "\n$totalstr\n";
		//system("google-chrome-stable ".implode(" ",$matches[0]));
		system("google-chrome-stable $totalstr");
	
	}
	echo "\n===============================================================\n";
	fclose($handle);
}
die();
?>
