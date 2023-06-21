.play.quitgame:{[nextscene;handle;id]
  @[{x y}[handle];(`postupdate;id;0b);()];  // Trying to tell the server the player is quitting
  :`scene`params!(nextscene;()!());
 };
