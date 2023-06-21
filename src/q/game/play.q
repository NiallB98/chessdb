system"l game/play/constants.q";
system"l game/play/common.q";
system"l game/play/turnlogic.q";
system"l game/play/initboard.q";
system"l game/play/getupdate.q";
system"l game/play/postupdate.q";
system"l game/play/draw.q";
system"l game/play/quitgame.q";

play:{[params]
  gd:`scene`params!(`play;()!());

  pname:params`pname;
  otherpname:params`otherpname;

  board:"";
  iswhite:params`iswhite;
  turndone:0b;

  handle:hopen params`address;
  id:params`id;

  0N!logmsg:"Game started!";
  haserrored:0b;

  .play.draw[board;iswhite;pname;logmsg;otherpname;haserrored];

  while[`play~gd`scene;
    sts:.z.p;

    0N!"0";

    input:$[haserrored or .play.isturn[board;iswhite];getinput[];""];

    0N!"1";

    $[
      input~"q";:.play.quitgame[`;handle;id];
      input~"m";:.play.quitgame[`menu;handle;id]
    ];
    
    0N!"2";

    if[(not board~"") and not[haserrored] and .play.isturn[board;iswhite];      // If taking turn (and not errored)
      res:.play.turnlogic[input];
      turndone:res 0; board:res 1;
    ];

    0N!"3";

    if[turndone;                                                                // If turn is done
          res:.play.postupdate[id;board];  // Send updated board to server
          haserrored:not res 0; logmsg:res 1;

          turndone:0b; picksq:-1;
    ];

    0N!"4";

    if[(not board~"") and not[haserrored] and not .play.isturn[board;iswhite];  // If other player's turn (and not errored)
      res:.play.getupdate[handle;id;board];
      haserrored:not res 0; logmsg:res 1;

      if[not haserrored;board:res 2];
    ];

    0N!"5";

    if[board~"";                                                                // If waiting to get initial board from server
      res:0N!.play.initboard[handle;id];
      haserrored:not res 0; logmsg:res 1;

      if[not haserrored;board:res 2];
    ];

    0N!"6";

    .play.draw[board;iswhite;pname;logmsg;otherpname;haserrored];

    if[(board~"") or not[haserrored] and not .play.isturn[board;iswhite];limitfps sts];
  ];

  :gd;
 };
