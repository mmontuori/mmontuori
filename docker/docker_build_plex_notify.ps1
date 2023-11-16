
$container_name = "plex_notify"
$container_file = "docker/plex_notify_containerfile"

$path = Test-Path "$container_file"

if ( $path -eq $false ) {
    Write-Error "Error! Run this where Dockerfile is present!"
    Exit 1
}

if ( $null -ne $args[0] ) {
    $docker_tag = $args[0]
} else {
    $docker_tag = "latest"
}

Write-Output "building  ${container_name} with tag:${docker_tag}"

$command = "docker build --file $container_file -t ${container_name}:${docker_tag} ."

Invoke-Expression "$command"