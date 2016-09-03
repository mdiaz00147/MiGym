<!DOCTYPE html>
<html>
<head>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

			<script>
 					function check_if_open() {
					var t=setTimeout('closeIframe()',10000);
					}
					function closeIframe() {
					var iframe = document.getElementById('Ifid');
					iframe.parentNode.removeChild(iframe);
					}
			</script>
</head>
<body>
<?PHP
define ("matomy", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://t.mdn2015x1.com/build/fdd7d65b/v1/script/' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("adc", "<!--adc--><iframe id='Ifid' width='1' height='1' src='http://www.vipgoal.net/adc.html' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("tara", "<!--mato--><iframe id='Ifid' width='1' height='1' src='//d.bukatokin.biz/api/mpup/1?aus=2862' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("mediahub", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://www.xmediaserve.com/apu.php?n=&zoneid=10652&cb=INSERT_RANDOM_NUMBER_HERE&popunder=1&direct=1' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("matomyvideo", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://ads.playerapp1.pw/ads/matvideo.html' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("n280", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://n280adserv.com/ads?key=2a85700076a7f9c4e83a527cd40193b3&ch=&width=0&height=0' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("yepdigital", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://yepdigital.adk2x.com/imp?p=62521342&ct=html&ap=1304&iss=0&f=0' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define ("adorika", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://a.adquantix.com/c/banner_s?tenant=AD&selection=12092&size=UN&skin=pop&auto_click=1' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define("gunggo", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://ad.directrev.com/RealMedia/ads/adstream_sx.ads/S0009822/127547249291092156@x10' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");
define("wafra", "<!--mato--><iframe id='Ifid' width='1' height='1' src='http://wmedia.adk2x.com/imp?p=61861224&ct=html&ap=1303&iss=0&f=0' frameBorder='0' sandbox='allow-forms allow-same-origin allow-scripts' onload='check_if_open()'></iframe>");


define ("pais", $_SERVER['HTTP_CF_IPCOUNTRY']);
define ("ip", $_SERVER['HTTP_CF_CONNECTING_IP']);

$value = ip;
$fecha = "hdm_1_".date("d");
$expire=time()+60*60*24;

if(isset($_SERVER['HTTP_USER_AGENT'])){
		$agent = $_SERVER['HTTP_USER_AGENT'];
	}
	if(strlen(strstr($agent,"Firefox")) > 0 ){ 
		$browser = 'firefox';
	}
	elseif(strlen(strstr($agent,"Chrome")) > 0 ){ 
		$browser = 'chrome';
	}
	elseif(strlen(strstr($agent,"Trident")) > 0 ){ 
		$browser = 'explorer';
	}
	else { 
		$browser = 'resto';
	}
	
switch ($browser)
{
	case 'firefox':
	{
	$array1=array('TR', 'GB', 'US', 'BR');
	if (in_array(pais,$array1)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			//echo adorika;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array2=array('US', 'CA', 'AU', 'GB');
	if (in_array(pais,$array2)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomyvideo;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array3=array('FR');
	if (in_array(pais,$array3)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo n280;
			echo yepdigital;
			echo gunggo;
	   	    setcookie($fecha,$value,$expire);
		}	
	}
	$array4=array('BR');
	if (in_array(pais,$array4)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo gunggo;
	   	    setcookie($fecha,$value,$expire);
		}	
	}
	$array5=array('FR', 'BR');
	if (!in_array(pais,$array5)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			echo matomy;
			echo mediahub;
			echo tara;
			echo n280;
			echo yepdigital;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		}	
	}
	}
	break;
	case 'chrome': 
	{
	$array1=array('TR', 'GB', 'US', 'BR');
	if (in_array(pais,$array1)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			//echo adorika;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array2=array('US', 'CA', 'AU', 'GB');
	if (in_array(pais,$array2)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomyvideo;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array3=array('FR');
	if (in_array(pais,$array3)) {
		if ($_COOKIE[$fecha]==false) { 
			echo adc;
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo n280;
			echo yepdigital;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		  }	
	}
	$array3=array('BR');
	if (in_array(pais,$array3)) {
		if ($_COOKIE[$fecha]==false) { 
			echo adc;
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo n280;
			echo yepdigital;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		  }	
	}
	$array4=array('FR', 'BR');
	if (!in_array(pais,$array4)) {
			if ($_COOKIE[$fecha]==false) { 
				echo adc;
				echo matomy;
				echo matomy;
				//echo mediahub;
				echo tara;
				echo n280;
				echo yepdigital;
				echo gunggo;
				setcookie($fecha,$value,$expire);
				}	
			}
	}
	break;
	case 'explorer':
	{
		$array1=array('TR', 'GB', 'US', 'BR');
	if (in_array(pais,$array1)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			//echo adorika;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array2=array('US', 'CA', 'AU', 'GB');
	if (in_array(pais,$array2)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomyvideo;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array3=array('FR');
	if (in_array(pais,$array3)) {
		if ($_COOKIE[$fecha]==false) { 
		echo adc;
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo n280;
			echo yepdigital;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		  }	
	}
	$array4=array('BR');
	if (in_array(pais,$array4)) {
		if ($_COOKIE[$fecha]==false) { 
			echo adc;
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		  }	
	}
	$array5=array('FR', 'BR');
	if (!in_array(pais,$array5)) {
			if ($_COOKIE[$fecha]==false) { 
			    echo adc;
				echo matomy;
				//echo mediahub;
				echo tara;
				echo n280;
				echo yepdigital;
				echo gunggo;
				setcookie($fecha,$value,$expire);
				}	
			}
	} 
	break;
	case 'resto': 
	{
	$array1=array('TR', 'GB', 'US', 'BR');
	if (in_array(pais,$array1)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomy;
			//echo adorika;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array2=array('US', 'CA', 'AU', 'GB');
	if (in_array(pais,$array2)) {
		if ($_COOKIE[$fecha]==false) { 
			echo matomyvideo;
		setcookie($fecha,$value,$expire);
		}	
	}
	$array3=array('FR');
	if (in_array(pais,$array3)) {
		if ($_COOKIE[$fecha]==false) { 
			echo adc;
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo n280;
			echo yepdigital;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		  }	
	}
	$array4=array('FR');
	if (in_array(pais,$array4)) {
		if ($_COOKIE[$fecha]==false) { 
			echo adc;
			echo matomy;
			echo matomy;
			//echo mediahub;
			echo tara;
			echo gunggo;
			setcookie($fecha,$value,$expire);
		  }	
	}
	$array5=array('FR', 'BR');
	if (!in_array(pais,$array5)) {
			if ($_COOKIE[$fecha]==false) { 
				echo adc;
				echo matomy;
				//echo mediahub;
				echo tara;
				echo n280;
				echo yepdigital;
				echo gunggo;
				setcookie($fecha,$value,$expire);
				}	
		}
	}
	break;
}
?>