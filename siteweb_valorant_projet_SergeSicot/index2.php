<?php 
//ouverture d'une session
session_name('PRJVALORANT');
session_start();

//on regarde si l'utilisateur est authentifié
if (isset($_SESSION['login'])) {
	$login=$_SESSION['login'];
} else {
	$login=null;
}

?>

<!DOCTYPE>
<html>
<head>
<meta charset=UTF-8">
<title>Valorant Data</title>
</head>
<body>
<h1>Valorant player's data</h1>
<?php
//on regarde si l'utilisateur est authentifié
if (isset($_SESSION['login'])) {
	$login=$_SESSION['login'];
} else {
	echo 'Vous devez vous authentifier !';
	exit;
}
//interrogation bd
	include('config/db.cfg');
	$con = new PDO($sgbd.':host='.$host.';dbname='.$base, $user, $passwd);
	$req="SELECT pseudoJoueur, email FROM Compte inner join Joueur on Compte.idJoueur=Joueur.idJoueur WHERE email='$login'";
	$res=$con->query($req);
	
	while ($row=$res->fetch(PDO::FETCH_OBJ)){
			echo"<h4>Pseudo: ".$row->pseudoJoueur."</h4>";
			echo"<h4>L'adresse de mail: ".$row->email."</h4>";
		}	
	$res->closeCursor();
	unset($con);
?>
<br>
<div>
	<?php
	include('config/db.cfg');
	$con = new PDO($sgbd.':host='.$host.';dbname='.$base, $user, $passwd);
	$req="select Ranks.idRanks, nomRank from Ranks inner join Joueur on Ranks.idRanks=Joueur.idRanks inner join Compte on Joueur.idJoueur=Compte.idJoueur where email='$login'";
	$res=$con->query($req);
	
	while ($row=$res->fetch(PDO::FETCH_OBJ)){
			echo"<h3>Rank actuel:</h3>";
			echo"<h4>".$row->nomRank."</h4>";
			$img=$row->idRanks;
			echo '<img src="rankimg/'.$img.'.png" alt="'.$row->nomRank.'" />';
		}	
	$res->closeCursor();
	unset($con);
	?>
	

</div>
<br><br>
<a href="deconnexion.php" > Se déconnecter</a>


</body>
</html>
