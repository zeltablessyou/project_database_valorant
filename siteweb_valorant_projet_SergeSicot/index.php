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

<br /><br />
<?php 
if (empty($login)) {
	echo '<form method="post" action="traite_form_login.php" enctype="multipart/form-data">
	<fieldset>
	<legend>Identifiez-vous !</legend>
	<label for="login">Login :</label><input type="text" id="login" name="login" placeholder="Entrez votre adresse de mail"/>
	<label for="pass">Mot de passe :</label><input type="password" id="pass" name="pass" placeholder="Entrez votre mote de passe" />
	<input type="submit" value="Valider">
	</fieldset>
	</form>';
} else {
	header('Location: index2.php');
}

?>

</body>
</html>
