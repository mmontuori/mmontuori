
$container_name = "plex_notify"

function GetRunningContainer {
	$container = Invoke-Expression "docker container ls --no-trunc" | Select-String "$container_name"

	if ( $null -ne $container ) {
		$container = $container.ToString()
		$container = $container.Split(" ")[0]
	}
	return $container
}

if ( $null -ne $args[0] ) {
    $docker_tag = $args[0]
} else {
    $docker_tag = "latest"
}

$flags="-f --details --tail 500"

$running_container = GetRunningContainer

if ( $null -eq $running_container ) {
	Write-Output "container ${container_name} is not running!"
	Exit 1
}

$command = "docker logs $flags $running_container"

Invoke-Expression $command
