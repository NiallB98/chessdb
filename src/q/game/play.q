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

.play.quitgame:{[nextscene;handle;id]
  @[{0N!x y};(`postupdate;id;0b);()];  // Trying to tell the server the player is quitting
  :`scene`params!(nextscene;()!());
 };

.play.getupdate:{[handle;id]
  res:@[{x y}[handle];(`getupdate;id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;"Waiting for turn...");
 };

play:{[params]
  gd:`scene`params!(`play;()!());

  pname:params`pname;
  otherpname:params`otherpname;

  iswhite:params`iswhite;
  isturn:iswhite;

  handle:params`handle;
  id:params`id;

  logmsg:"Game started!";
  haserrored:0b;

  .play.draw[iswhite;isturn;pname;logmsg;otherpname;haserrored];

  while[`play~gd`scene;
    sts:.z.p;

    input:$[haserrored or isturn;getinput[];""];

    $[
      input~"q";:.play.quitgame[`;handle;id];
      input~"m";:.play.quitgame[`menu;handle;id]
    ];

    if[not[haserrored] and isturn;
      .play.turnlogic[];
    ];

    if[not[haserrored] and not isturn;
      res:0N!.play.getupdate[handle;id];
      haserrored:not first res;
      logmsg:res 1;
    ];

    .play.draw[iswhite;isturn;pname;logmsg;otherpname;haserrored];

    if[not[haserrored] and not isturn;limitfps sts];
  ];

  :gd;
 };
