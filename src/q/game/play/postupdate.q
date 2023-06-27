.play.postupdate:{[qd;board;takenpcs]
  res:@[{x y;1b}[qd`h];(`postupdate;qd`id;(board;takenpcs));(0b;`)];
  
  if[not first res;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;"Turn ended");
 };
