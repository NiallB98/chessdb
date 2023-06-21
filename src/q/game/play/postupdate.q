.play.postupdate:{[handle;id;board]
  res:@[{x y}[handle];(`postupdate;id;board);(0b;`)];
  
  if[not first res;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;"Turn ended");
 };
