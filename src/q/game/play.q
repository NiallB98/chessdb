CHECK_CHAR_DICT:`nw`ne`sw`se!"!!!!";
CURSOR_CHAR_DICT:`n`w`e`s!"-||-";
SELECTED_CHAR_DICT:`nw`ne`sw`se!"/\\\\/";
CAN_MOVE_CHAR_DICT:`nw`ne`sw`se!"\\//\\";
LAST_MOVE_CHAR_DICT:`nw`ne`sw`se!"++++";

BLACK_SQUARE_CHAR:"#";
WHITE_SQUARE_CHAR:" ";

WHITE_KING_CHAR:"K";
WHITE_QUEEN_CHAR:"Q";
WHITE_ROOK_CHAR:"R";
WHITE_BISHOP_CHAR:"B";
WHITE_KNIGHT_CHAR:"K";
WHITE_PAWN_CHAR:"P";

BLACK_KING_CHAR:"k";
BLACK_QUEEN_CHAR:"q";
BLACK_ROOK_CHAR:"r";
BLACK_BISHOP_CHAR:"b";
BLACK_KNIGHT_CHAR:"k";
BLACK_PAWN_CHAR:"p";

system"l game/play/draw.q";

.play.quitgame:{[nextscene]
  stophost[];
  :`scene`params!(nextscene;());
 };

.play.waitforinput:{[]
  :getinput[];  // Placeholder
 };

play:{[params]
  pname:params`pname;
  otherpname:params`otherpname;
  iswhite:params`iswhite;
  ishost:params`ishost;

  gd:`scene`params!(`play;()!());

  isturn:iswhite;
  logmsg:"";

  .play.draw[iswhite;isturn;pname;"Game started!";otherpname];

  while[`play~gd`scene;
    input:$[isturn;getinput[];.play.waitforinput[]];

    gd:$[
      input~"q";.play.quitgame`;
      input~"m";.play.quitgame`menu;
      gd
    ];

    .play.draw[iswhite;isturn;pname;logmsg;otherpname];
  ];

  :gd;
 };