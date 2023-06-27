.play.quitgame:{[qd;haserrored;nextscene]
  if[not haserrored;@[{x y}[qd`h];(`postupdate;qd`id;0b);()]];  // Trying to tell the server the player is quitting if the game has not received an error
  :`scene`params!(nextscene;()!());
 };
