system"l game/joinwait/getupdate.q";

.joinwait.draw:{[loadstr;ip;portstr;msg;haserrored]
  lvl:.joinwait.level;
  lvl:autoshowmsg[lvl;loadstr;"@";`left];
  lvl:autoshowmsg[lvl;ip;"#";`left];
  lvl:autoshowmsg[lvl;portstr;"$";`left];
  lvl:autoshowmsg[lvl;msg;"&";`];

  prompt:$[haserrored;"Quit [Q], Menu [M] ";""];

  draw[lvl;prompt];
 };

joinwait:{[params]  // Repeatedly queries the host address until it receives the other player's name and what colour to start as
  gd:`scene`params!(`joinwait;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`address]:params`address;
  gd[`params;`id]:params`id;
  gd[`params;`otherpname]:"";  // Will be assigned by the server
  gd[`params;`iswhite]:0b;     // Will be assigned by the server

  ip:vs[":";string gd[`params;`address]]1;
  portstr:vs[":";string gd[`params;`address]]2;

  ready:0b;  // If ready to go to play mode
  msg:"";
  loadprog:0;
  haserrored:0b;  // Stops the process trying to query the server if true

  .joinwait.draw[loadprog#".";ip;portstr;msg;haserrored];

  while[`joinwait~gd`scene;
    sts:.z.p;

    if[haserrored;  // If an error occurred when trying to query the server, allow user input
      input:getinput[];
      $[
        input~"q";:.game.quitdict;
        input~"m";:.game.menudict
      ];
    ];

    if[not haserrored;
      loadprog:mod[loadprog+1;4];

      res:.joinwait.getupdate[gd[`params;`address];gd[`params;`id]];
      $[first res;if[res 1;  // If received all the details needed from the server
          gd[`params;`otherpname]:res 2;
          gd[`params;`iswhite]:res 3;
          gd[`scene]:`play;
          :gd;  // Move to play mode
        ];
        [
          msg:last res;  // If an error occurred, allow it to be logged on screen
          haserrored:1b;
        ]
      ];
    ];

    .joinwait.draw[loadprog#".";ip;portstr;msg;haserrored];

    if[not haserrored;limitfps sts];  // Prevents too much refreshing
  ];

  :gd;
 };
