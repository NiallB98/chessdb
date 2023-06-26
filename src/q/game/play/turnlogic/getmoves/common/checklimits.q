.tl.doesnotcheckself:{[board;iswhite;startpos;endpos]
  bd:first .play.movepiece[board;startpos;endpos];
  :not .play.ischecked[bd;iswhite];
 };

.tl.checklimits:{[moves;board;picksq;iswhite]
  :moves where .tl.doesnotcheckself[board;iswhite;picksq] each moves;
 };
