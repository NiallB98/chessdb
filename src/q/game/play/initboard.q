.play.initboard:{[qd]
  0N!res:@[{x y}[qd`h];(`.mid.initboard;qd`id);(0b;"<Lost connection>")];

  if[not first res;:res];

  :(1b;"Initial turn";last res);
 };
