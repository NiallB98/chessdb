.play.showCheck:{[lvl;board;isWhite]
  bd:.play.getBoard1D board;

  if[.play.isChecked[board;1b];  // If white king is checked
    pos:first bd ss WHITE_KING_CHAR;
    if[not isWhite;pos:63-pos];

    indices:.play.indices[key CHECK_CHAR_DICT;pos];
    lvl[indices]:value CHECK_CHAR_DICT;
  ];

  if[.play.isChecked[board;0b];  // If black king is checked
    pos:first bd ss BLACK_KING_CHAR;
    if[not isWhite;pos:63-pos];

    indices:.play.indices[key CHECK_CHAR_DICT;pos];
    lvl[indices]:value CHECK_CHAR_DICT;
  ];

  :lvl;
 };

.play.showCursor:{[lvl;isWhite;pos]
  if[pos~-1;:lvl];  // Do not show if position is -1
  if[not isWhite;pos:63-pos];

  indices:.play.indices[key CURSOR_CHAR_DICT;pos];
  lvl[indices]:value CURSOR_CHAR_DICT;

  :lvl;
 };

.play.showSelected:{[lvl;isWhite;pickSq]
  if[pickSq~-1;:lvl];  // Do not show if position is -1
  if[not isWhite;pickSq:63-pickSq];

  indices:.play.indices[key SELECTED_CHAR_DICT;pickSq];
  lvl[indices]:value SELECTED_CHAR_DICT;

  :lvl;
 };

.play.showMoves:{[lvl;isWhite;moves]
  if[0~count moves;:lvl];  // Do not show if no moves are possible
  if[not isWhite;moves:63-moves];

  indices:raze .play.indices[key CAN_MOVE_CHAR_DICT;moves];
  chars:raze flip count[moves]#enlist value CAN_MOVE_CHAR_DICT;
  lvl[indices]:chars;

  :lvl;
 };

.play.showLastMove:{[lvl;isWhite;lastMove]
  if[0~count lastMove;:lvl];  // Do not show if there was no last move (ie. this is the first move)
  if[not isWhite;lastMove:63-lastMove];

  indices:raze .play.indices[key LAST_MOVE_CHAR_DICT;lastMove];
  chars:raze flip count[lastMove]#enlist value LAST_MOVE_CHAR_DICT;
  lvl[indices]:chars;

  :lvl;
 };

.play.showBoardUI:{[lvl;cd;csrd]
  lvl:.play.showLastMove[lvl;cd`isWhite;cd`lastMove];
  lvl:.play.showCheck[lvl;cd`bd;cd`isWhite];
  lvl:.play.showMoves[lvl;cd`isWhite;csrd`moves];
  lvl:.play.showSelected[lvl;cd`isWhite;csrd`pickSq];
  lvl:.play.showCursor[lvl;cd`isWhite;csrd`pos];

  :lvl;
 };
