system"l game/ai/evaluate/material.q";
system"l game/ai/evaluate/mobility.q";

evaluate:{[board1D]
  whoToMove:if["w"~first vs[" ";board1D]1;1;-1];  // +1 for white, -1 for black

  materialScore:material[board1D];
  mobilityScore:mobility[board1D];

  :(materialScore+mobilityScore)*whoToMove;
 };
