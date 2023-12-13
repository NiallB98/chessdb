.tl.doesNotCheckSelf:{[board;isWhite;startPos;endPos]
  bd:first .common.play.movePiece[board;startPos;endPos];
  :not .common.play.isChecked[bd;isWhite];
 };

.tl.checkLimits:{[moves;board;pickSq;isWhite]
  :moves where .tl.doesNotCheckSelf[board;isWhite;pickSq] each moves;
 };
