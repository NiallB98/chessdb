.play.initBoard:{[qd]
  res:@[{x y}[qd`h];(`.mid.initBoard;qd`id);(0b;"<Lost connection>")];

  if[not first res;:res];

  :(1b;"Initial turn";last res);
 };
