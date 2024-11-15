let
  config = import ../config.nix;
  users = [ config.me.sshKey ];

  emily = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICra+ZidiwrHGjcGnyqPvHcZDvnGivbLMayDyecPYDh0";
  lea = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZALEiJIrH1Kj10u+WshkQXr5NHmszza8wNLqW+2fB0";
  vanessa = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZALEiJIrH1Kj10u+WshkQXr5NHmszza8wNLqW+2fB0";
  systems = [ emily lea vanessa ];
in
{
  "hedgedoc.env.age".publicKeys = users ++ systems;
  "github-nix-ci/srid.token.age".publicKeys = users ++ systems;
}
