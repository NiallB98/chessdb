.play.waitingnum:0;

.play.getwaitingnum:{[]
  .play.waitingnum:(.play.waitingnum+1) mod 4;
  :.play.waitingnum;
 };

.play.generatemsg:{[bdstart;bdend;iswhite;starttknpcs;endtknpcs]
  msg:$[
    bdstart~bdend;(n#" "),"Waiting",(n:.play.getwaitingnum[])#".";
    .play.ischecked[bdend;iswhite];"You are checked!";
    not starttknpcs~endtknpcs;"Piece captured!";
    "It is your turn"
  ];

  :msg;
 };

.play.getupdate:{[qd;board;takenpcs;iswhite]
  res:@[{x y}[qd`h];(`getupdate;qd`id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;.play.generatemsg[board;res 2;iswhite;takenpcs;res 3];res 2;res 3);
 };
