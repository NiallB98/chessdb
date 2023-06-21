.play.getupdate:{[handle;id;board]
  res:@[{x y}[handle];(`getupdate;id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;"Waiting for turn...";board);
 };
