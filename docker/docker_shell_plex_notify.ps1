
$container_name = "plex_notify"

if ( $null -eq $args[0] ) {
	$exprog = "/bin/sh"
} else {
	$exprog = $args[0]
}

$command = "docker run -ti $container_name ${exprog}"

Invoke-Expression $command
