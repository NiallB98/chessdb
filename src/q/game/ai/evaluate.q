system"l game/ai/evaluate/material.q";
system"l game/ai/evaluate/mobility.q";

evaluate:{[board]
  bd1D:.common.game.getBoard1D board;

  whoToMove:if[.common.game.isWhiteTurn board;1;-1];  // +1 for white, -1 for black

  materialScore:material[bd1D];
  mobilityScore:mobility[bd1D];

  :(materialScore+mobilityScore)*whoToMove;
 };
