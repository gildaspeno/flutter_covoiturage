<?php
	include 'connexion.php';
	
	
	$requete="SELECT * FROM transport ORDER by typeOffre";
	
	$result=mysqli_query($db,$requete);
	$data=array();
	
	
	while($row = mysqli_fetch_assoc($result)){
		$data[]=$row;
		
	}
	
	echo json_encode($data);
	
	// Libérer le jeu de résultat
	mysqli_free_result($result);



?>