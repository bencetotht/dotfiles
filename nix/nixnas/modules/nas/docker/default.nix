{ ... }:
{
  virtualisation.docker.enable = true;

  users.groups.docker-shared = {};

  users.users.dockerstorage = {
    isSystemUser = true;
    description = "Shared user for Docker storage access";
    group = "docker-shared";
    home = "/var/lib/dockerstorage";
  };
}