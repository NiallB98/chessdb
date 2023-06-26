.play.updatecastle:{[bd;castlestr;movepiece;startpos;endpos]
  if["k"<>lower movepiece;:(bd;castlestr)];
  if[2<>abs startpos-endpos;:(bd;castlestr)];

  iswhite:movepiece~WHITE_KING_CHAR;
  dir:$[0>endpos-startpos;$[iswhite;"K";"k"];$[iswhite;"Q";"q"]];  // Determining whether king or queen side castling, capitalised if player castling is white

  rookstartpos:$["k"~lower dir;startpos+3;startpos-4];
  rookendpos:$["k"~lower dir;startpos+1;startpos-1];

  rookchar:bd[rookstartpos];

  bd[rookstartpos]:" ";
  bd[rookendpos]:rookchar;

  castlestr:castlestr except dir;
  if[castlestr~"";castlestr:"-"];

  :(bd;castlestr);
 };

.play.updateenpass:{[movepiece;startpos;endpos]
  if["p"<>lower movepiece;:raze"-"];
  if[16<>abs startpos-endpos;:raze"-"];

  enpasspos:startpos+(endpos-startpos)%2;
  x:"abcdefgh"`long$enpasspos mod 8;
  y:"87654321"`long$enpasspos div 8;

  :x,y;
 };

.play.getenpasspiece:{[bd;enpassstr]
  if[first[enpassstr]~"-";:" "];

  tgtx:first where (`$first enpassstr)=`a`b`c`d`e`f`g`h;
  tgty:8-value last enpassstr;

  $["3"~last enpassstr;tgty-:1;tgty+:1];  // Either white side or black side enpassant can only be coords X3 and X6 respectively

  :bd tgtx+8*tgty;
 };

.play.rmenpasspiece:{[bd;enpassstr]
  tgtx:first where (`$first enpassstr)=`a`b`c`d`e`f`g`h;
  tgty:8-value last enpassstr;

  bd[tgtx+8*tgty]:" ";

  :bd;
 };

.play.isenpasscapture:{[bd;enpassstr;movepiece;startpos;endpos]
  if[" "~.play.getenpasspiece[bd;enpassstr];:0b];
  if["p"<>lower movepiece;:0b];
  if[not abs[endpos-startpos] in 7 9;:0b];

  tgtx:first where (`$first enpassstr)=`a`b`c`d`e`f`g`h;
  tgty:8-value last enpassstr;

  :endpos~tgtx+8*tgty;
 };

.play.movepiece:{[board;startpos;endpos]
  bd:.play.getboard1d board;

  splitbd:" " vs board;
  sidestr:splitbd 1;
  castlestr:splitbd 2;
  enpassstr:splitbd 3;
  halfturnstr:splitbd 4;
  fullturnstr:splitbd 5;

  movepiece:bd[startpos];
  takenpiece:$[
    .play.isenpasscapture[bd;enpassstr;movepiece;startpos;endpos];
      .play.getenpasspiece[bd;enpassstr];
    bd[endpos]
  ];

  bd[startpos]:" ";
  bd[endpos]:movepiece;
  if[.play.isenpasscapture[bd;enpassstr;movepiece;startpos;endpos];
    bd:.play.rmenpasspiece[bd;enpassstr];
  ];

  sidestr:raze $[first[sidestr]~"w";"b";"w"];                                             // Switching sides
  res:.play.updatecastle[bd;castlestr;movepiece;startpos;endpos];                         // Update castling if it happened (If castling also move rook)
  bd:res 0; castlestr: res 1;
  enpassstr:.play.updateenpass[movepiece;startpos;endpos];                                // Update enpassant square if it needs to change
  halfturnstr:raze $[(movepiece~"p") or takenpiece<>" ";"0";string 1+value halfturnstr];  // Update half turns since last pawn move or piece capture
  fullturnstr:$[first[sidestr]~"w";string 1+value fullturnstr;fullturnstr];               // Update full move if new sidestr is white (ie. black just moved)

  board:" " sv (.play.fmtboard1d bd;sidestr;castlestr;enpassstr;halfturnstr;fullturnstr);

  :(board;takenpiece);
 };
