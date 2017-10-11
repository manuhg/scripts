<?php
$i=0;
foreach( $argv as $arg)
{
	echo $arg."\n";
	if($i++==0/* && !preg_match('http',$arg)*/)continue;
	$patt='<meta\s+property="og:image".*content="(.*)".*>';
	$pcontent=get_url($arg);
	if(preg_match($patt,$pcontent,$matches))
	{
		echo $matches[1];
		system("wget $matches[1]");
	}	
}
die();
function get_url($url)
{
	$c=curl_init();
	curl_setopt($c,CURLOPT_URL,$url);
	curl_setopt($c,CURLOPT_RETURNTRANSFER,1);
	$output=curl_exec($c);
	curl_close($c);
	return $output;
}
?>