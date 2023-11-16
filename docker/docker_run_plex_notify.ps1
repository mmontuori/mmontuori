
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
    Write-Error "container ${container_name} is running. Stop it first!"
    Exit 1
}

if ( $null -ne $args[0] ) {
    $docker_tag = $args[0]
} else {
    $docker_tag = "latest"
}
    
$command = "docker run -d ${container_name}:$docker_tag"

Invoke-Expression "$command"
