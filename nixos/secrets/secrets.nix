let

  user = {
    chocola = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlmzWQnsgjBovCkBOw4nMr0aZI+qOG9XjVG8Pkn1Cze chocola";
    vanilla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRyEjUr9iwPHHdSqxkj6CL7Rq03evD/0DJGeLx1CoCN vanilla";
    azuki = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmTpqEOGdsqInl+lcCUp1YsRZcjzAW3Ekc6qU+e8E6K azuki";
  };

  users = with user; [
    chocola
    vanilla
    azuki
  ];

  system = {
    vanilla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlXmYUlwftD80MSpFLG7uBPSNWeJw2VuIuhVZt+fy3t root@vanilla";
  };

  systems = with system; [
    vanilla
  ];

  all = users ++ systems;
in
{
  "vanilla.cloudfalred.f14135e3-03af-4f23-9493-e4d0a169a232.json.age".publicKeys = all;
}
