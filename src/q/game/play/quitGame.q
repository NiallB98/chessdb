.play.quitGame:{[qd;hasErrored;nextScene]
  if[not hasErrored;@[{x y}[qd`h];(`postUpdate;qd`id;0b);()]];  // Trying to tell the server the player is quitting if the game has not received an error
  :`scene`params!(nextScene;()!());
 };
