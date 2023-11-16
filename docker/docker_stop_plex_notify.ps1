
$container_name = "plex_notify"

function GetRunningContainer {
	$container = Invoke-Expression "docker container ls --no-trunc" | Select-String "$container_name"

	if ( $null -ne $container ) {
		$container = $container.ToString()
		$container = $container.Split(" ")[0]
	}
	return $container
}

$running_container = GetRunningContainer

if ( $null -ne $running_container ) {
	Write-Output "stopping container ", $running_container
	$command = "docker container stop $running_container"
	Invoke-Expression "$command"
	Write-Output "cleaning up..."
	$command = "docker system prune -f"
	Invoke-Expression "$command"
} else {
	Write-Error "running container ${container_name} not found!"
}
