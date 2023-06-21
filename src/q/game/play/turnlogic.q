system"l game/play/turnlogic/cursorlogic.q";
system"l game/play/turnlogic/pickedlogic.q";

.play.turnlogic:{[input;board;cursorpos;picksq]
  cursorlogic[input;board;cursorpos];
  if[picksq<>-1;pickedlogic[input;board;cursorpos;picksq]];

  :(0b;board);
 };
