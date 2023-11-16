
$container_name = "plex_notify"
$container_file = "docker/plex_notify_containerfile"

$path = Test-Path "$container_file"

if ( $path -eq $false ) {
    Write-Output "Error! Run this where ${container_file} file is present!"
    Exit 1
}

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
	Write-Error "Container not found!"
	Exit 1
}


dockerstop
dockerbuild
dockerrun
