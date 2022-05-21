<?php 

//recuperation données formulaire
$login_a_tester=$_POST['login'];
$pass_a_tester=$_POST['pass'];



	//interrogation bd
	include('config/db.cfg');
	$con = new PDO($sgbd.':host='.$host.';dbname='.$base, $user, $passwd);
	$req="SELECT email,mdpCompte FROM Compte WHERE email='$login_a_tester' AND mdpCompte='$pass_a_tester'";

	$res=$con->query($req);
	unset($con);

	if ($login_db=$res->fetch(PDO::FETCH_OBJ)) {
		//ouverture de la session
		session_name('PRJVALORANT');
		session_start();
		$_SESSION['login']=$login_a_tester;
		header('Location: index.php');
	} else {
		//refus
		echo 'authentification non valide';
}






?>
