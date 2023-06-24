.play.showcheck:{[lvl;iswhite;pos]
  if[pos~-1;:lvl];  // Do not show if position is -1
  if[not iswhite;pos:63-pos];

  indices:.play.indices[key CHECK_CHAR_DICT;pos];
  lvl[indices]:value CHECK_CHAR_DICT;

  :lvl;
 };

.play.showcursor:{[lvl;iswhite;pos]
  if[pos~-1;:lvl];  // Do not show if position is -1
  if[not iswhite;pos:63-pos];

  indices:.play.indices[key CURSOR_CHAR_DICT;pos];
  lvl[indices]:value CURSOR_CHAR_DICT;

  :lvl;
 };

.play.showselected:{[lvl;iswhite;picksq]
  if[picksq~-1;:lvl];  // Do not show if position is -1
  if[not iswhite;picksq:63-picksq];

  indices:.play.indices[key SELECTED_CHAR_DICT;picksq];
  lvl[indices]:value SELECTED_CHAR_DICT;

  :lvl;
 };

.play.showmoves:{[lvl;iswhite;moves]
  if[0~count moves;:lvl];  // Do not show if no moves are possible
  if[not iswhite;moves:63-moves];

  indices:raze .play.indices[key CAN_MOVE_CHAR_DICT;moves];
  chars:raze flip count[moves]#enlist value CAN_MOVE_CHAR_DICT;
  lvl[indices]:chars;

  :lvl;
 };

.play.showlastmove:{[lvl;iswhite;lastmove]
  if[0~count lastmove;:lvl];  // Do not show if there was no last move (ie. this is the first move)
  if[iswhite;lastmove:63-lastmove];

  indices:raze .play.indices[key LAST_MOVE_CHAR_DICT;lastmove];
  chars:raze flip count[lastmove]#enlist value LAST_MOVE_CHAR_DICT;
  lvl[indices]:chars;

  :lvl;
 };

.play.showboardui:{[lvl;cd;csrd]
  lvl:.play.showlastmove[lvl;cd`iswhite;cd`lastmove];
  lvl:.play.showcheck[lvl;cd`iswhite;cd`checksq];
  lvl:.play.showmoves[lvl;cd`iswhite;csrd`moves];
  lvl:.play.showselected[lvl;cd`iswhite;csrd`picksq];
  lvl:.play.showcursor[lvl;cd`iswhite;csrd`pos];

  :lvl;
 };
