.play.getupdate:{[qd;board]
  res:@[{x y}[qd`h];(`getupdate;qd`id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;"Waiting for turn...";res 2);
 };
