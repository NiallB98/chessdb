system"l game/play/turnlogic/movecursor.q";
system"l game/play/turnlogic/getmoves.q";

.tl.move:{[cd;startpos;endpos]
  res:.play.movepiece[cd`bd;startpos;endpos];

  cd[`bd]:first res;

  if[last res<>" ";
    $[cd`iswhite;cd[`takenpcs;0],:last res;cd[`takenpcs;1],:last res];
  ];

  cd[`turndone]:1b;

  :cd;
 };

.tl.selectsq:{[cd;csrd]
  if[(csrd[`pos] in csrd`moves) and -1<>csrd`picksq;
    cd:.tl.move[cd;csrd`picksq;csrd`pos];
    :(cd;csrd);
  ];

  csrd[`picksq]:$[
    not[.play.isownedpiece[cd`bd;csrd`pos;cd`iswhite]] or csrd[`picksq]~csrd`pos;-1;
    csrd`pos
  ];

  :(cd;csrd);
 };

.play.turnlogic:{[input;cd;csrd]
  if[-1~csrd`pos;csrd[`pos]:$[cd`iswhite;63-11;12]];
  
  if[not input~"";
    if[input in "wasd";csrd:.tl.movecursor[input;csrd;cd`iswhite]];
    if[input~"e";res:.tl.selectsq[cd;csrd];cd:res 0;csrd:res 1];
  ];

  csrd[`moves]:$[-1~csrd`picksq;();.tl.getmoves[cd`bd;csrd`picksq;cd`iswhite]];

  :(cd;csrd);
 };
