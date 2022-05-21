# Projet perso database Valorant

Ce projet est un mélange d'un mini projet et la combinaison de deux TP. Dans un premier temps, lors d'un TP, avec un groupe de 3 dev, on a mis en place d'une base des données avec un thème: Valorant. J'ai pris ce TP avec un autre TP effectué auparavant qui consistait à s'authentifier dans un site web. Attention, le design du site web n'est pas un but recherché.


# Scole technique 🔧

 - VituralBox 
 - Debian
 - Apache
 - SQL

## Installation

Soyez sûr de posséder mySql et PHP7 ainsi que PHP PDO.
Il suffit de mettre le dossier dans le répertoire Apache de la machine virtuelle et lancez en localhost sur un navigateur de la machine virtuelle.

Assurez vous d'avoir modifié les param du config dans le dossier `config/db.cfg`:

```bash
<?php
//Config de l'accès à la base
$sgbd='mysql';
$host='localhost';
$base='db_valorant';
$user='user'; 
$passwd='passwd'; 
?>
```
