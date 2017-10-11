<?php
$urls=array();
$stexts=array('wins','medal','gold','beats');
scrape_news("http://www.news.com.au/sport/olympics");
function scrape_news($url)
{
	$time1=microtime(true);
	crawl_all($url);
	$time2=microtime(true);$t=$time2-$time1;
	echo "<br/><h1><b><u>TIME:$t</u></b></h1>";
}
function crawl_all($url)
{
	$page=get_url($url);global $urls;
	$p1=strpos($url,'://')+3;
	$p2=strpos($url,'/',$p1);
	if(!$p2)$p2=strrpos($url,'?',$p1);
	if(!$p2)$p2=strrpos($url,'#',$p1);
	if($p2)
	  $parent_site=substr($url,$p1,$p2-$p1);
	else
	  $parent_site=substr($url,$p1);
	echo "parent site:$parent_site\n";
	$d= new DOMDocument('1.0','utf-8');
	@$d->loadHTML($page);//@ is to supress warnings
	$lnks=$d->getElementsByTagName('a');
	foreach($lnks as $lnk)
	{
		$href=$lnk->getAttribute('href');
		if(strpos($href,$parent_site))
		 {
			 if(stripos($href,'olympics')&&(!strpos($href,'ailto:')))
			 {
				 $urls[]=$href;
				 crawl_page($href,$parent_site);
			 }
		 }
	}
	$urls=array_unique($urls);
	foreach($urls as $url)
	  scrape_page($url);
}
function crawl_page($url,$parent_site)
{
	$page=get_url($url);global $urls;
	$d= new DOMDocument('1.0','utf-8');
	@$d->loadHTML($page);//@ is to supress warnings
	$lnks=$d->getElementsByTagName('a');
	foreach($lnks as $lnk)
	{
		$href=$lnk->getAttribute('href');
		if(strpos($href,$parent_site))
		 {
			 if(stripos($href,'olympics')&&(!strpos($href,'ailto:')))//mailto with 'm' at beggininsg, strpos rets 0
			   $urls[]=$href;
		 }
	}
}
function scrape_page($url)
{
	global $stexts;
	$page=get_url($url);
	$d= new DOMDocument('1.0','utf-8');
	@$d->loadHTML($page);//@ is to supress warnings
	$text=$d->textContent;
	$pss;
	$cpos=0;
	//while(($cpos=stripos($text,$stext,$cpos))!=false)
	//{
	//	$p=strrpos(substr$text,'. '
	$x=0;
	foreach($stexts as $stext)
	 if(stripos($text,$stext)) $x=1;
	//echo "<br/>==>$url:$x";
	//if($x)
	if(preg_match_all("#\\s+[A-Za-z,;'\"\\s]+[.?!]#",$text,$arr))
	{
		//print_r($arr);die();//unset($arr[0]);
		foreach($arr as $sentence)
		{
			foreach($stexts as $stext)
				if(stripos($sentence,$stext))
				  echo "<br/>==>$url:\n$sentence\n";
		}
	}
}
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