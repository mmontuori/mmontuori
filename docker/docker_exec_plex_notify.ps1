
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

if ( $null -eq $running_container ) {
	Write-Error "container ${container_name} is not running!"
	Exit 1
}

if ( $null -eq $args[0] ) {
	$exprog = "/bin/sh"
} else {
	$exprog = $args[0]
}

$command = "docker exec -ti $running_container $exprog"

Invoke-Expression $command
