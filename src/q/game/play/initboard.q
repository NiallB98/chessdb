.play.initboard:{[handle;id]
  0N!res:@[{x y}[handle];(`.mid.initboard;id);(0b;"<Lost connection>")];

  if[not first res;:res];

  :(1b;"Initial turn";last res);
 };
