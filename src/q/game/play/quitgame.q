.play.quitgame:{[qd;nextscene]
  @[{x y}[qd`h];(`postupdate;qd`id;0b);()];  // Trying to tell the server the player is quitting
  :`scene`params!(nextscene;()!());
 };
