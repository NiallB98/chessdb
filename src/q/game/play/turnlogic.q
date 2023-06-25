system"l game/play/turnlogic/movecursor.q";

.tl.move:{[cd;startpos;endpos]
  
 };

.tl.selectsq:{[cd;csrd]
  if[(csrd[`pos] in csrd`moves) and -1<>csrd`picksq;.tl.move[cd;csrd`picksq;csrd`pos]];

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

  :(cd;csrd);
 };
