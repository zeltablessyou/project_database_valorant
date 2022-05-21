<?php 
//ouverture de la session
session_name('PRJVALORANT');
session_start();
//destruction de la session
session_destroy();
unset($_SESSION);
//renvoi sur la page d'accueil
header('Location: index.php');
?>
