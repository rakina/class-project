<!doctype html>
<html>
<head>
	<meta charset="utf-8" /> 
	<title>Tugas Diffie Hellman</title> 
	<link rel="stylesheet" href="style.css" /> 
</head>
<?php
	function modpow($a, $b, $m){
		// algoritma pemangkatan modular, menghitung a^b mod m
		if ($b == 0) return 1%$m;
		$tmp = modpow($a,$b/2,$m);
		if ($b%2 == 0) return $tmp*$tmp%$m;
		return (($tmp*$tmp%$m)*$a)%$m;
	}
	function getSharedKey($a,$B, $p){
		/*
			shared key 	= g^(a.b) mod p
						= (g^a)^b mod p
						= (g^b)^a mod p
						= B^a mod p
		*/
		return modpow($B,$a,$p);
	}
	function cryptaAnalysisDiffieHellman($p, $g, $A,$B){
		for ($x = 0; $x < $p; ++$x){
			if (modpow($g,$x,$p) == $A){
				// g^x ekivalen dengan A modulo p, maka sharedkeynya adalah g^(x.b) = B^x modulo p
				return modpow($B,$x,$p);
			}
		}
	}
?>
<body>
	<h1> Web App - Diffie Hellman </h1>
	<h2> Rakina Zata Amni, 1306398951 </h2>
	<h3> Kelas A, Asdos Dinda Susanti </h3>
	<p>
		Anda (Alice) dan teman anda (Bob) ingin mendapatkan <i>shared key</i> untuk melakukan enkripsi dan telah sepakat untuk menggunakan algoritma Diffie-Hellman. <br>
		Anda berdua sudah menentukan bilangan prima <b><i>p</i></b> dan bilangan bulat <b><i>g</i></b> yang merupakan primitive root modulo g. </br>
		Anda sudah memiliki bilangan rahasia <b><i>a</i></b>, dan Bob sudah memiliki bilangan rahasia <b><i>b</i></b>. <br>
		Bob sudah mengirimkan <b><i>B</i></b>, yaitu <b><i>g<sup>b</sup></i></b> mod <b><i>p</i></b>. <br>
		Kini anda ingin menghitung <i>shared key</i> yang (seharusnya) rahasia. <br>
		Tanpa ada ketahui, ada penguping yang mengetahui informasi-informasi publik yang and kirimkan dan mencoba menemukan <i>shared key</i> itu juga!
	</p>
	<hr>
	<form method="post">
		Nilai p: <input required type = "number" name = "p"> <br>
		Nilai g: <input required type = "number" name = "g"> <br>
		Nilai a: <input required type = "number" name = "a"> <br>
		Nilai B: <input required type = "number" name = "B"> <br>
		<input type = "submit" name = "Hitung Shared Key!">
	</form>
	<?php
		if (isset($_POST['p']) && isset($_POST['g']) && isset($_POST['a']) && isset($_POST['B']) ){
			$p = $_POST['p'];
			$g = $_POST['g'];
			$a = $_POST['a'];
			$B = $_POST['B'];
			echo "<h2> Shared Key = ".getSharedKey($a,$B,$p)."</h2>";
			$A = modpow($g,$a,$p);
			echo "<h2> Hasil Cryptanalysis = ".cryptaAnalysisDiffieHellman($p,$g,$A,$B)."</h2>";
		}
	?>
</body>
</html>