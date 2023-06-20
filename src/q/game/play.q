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

.play.quitgame:{[ishost;nextscene]
  if[ishost;.game.killserver[]];
  :`scene`params!(nextscene;()!());
 };

.play.waitforinput:{[]
  :getinput[];  // Placeholder
 };

play:{[params]
  pname:params`pname;
  otherpname:params`otherpname;
  iswhite:params`iswhite;
  handle:params`handle;
  id:params`id;

  gd:`scene`params!(`play;()!());

  isturn:iswhite;
  logmsg:"Game started!";

  .play.draw[iswhite;isturn;pname;logmsg;otherpname];

  while[`play~gd`scene;
    sts:.z.p;

    input:$[isturn;getinput[];.play.waitforinput[]];

    gd:$[
      input~"q";.play.quitgame`;
      input~"m";.play.quitgame`menu;
      gd
    ];

    .play.draw[iswhite;isturn;pname;logmsg;otherpname];

    if[not isturn;limitfps sts];
  ];

  :gd;
 };
