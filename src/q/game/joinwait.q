system"l game/joinWait/getUpdate.q";

.joinWait.draw:{[loadStr;ip;portStr;msg;hasErrored]
  lvl:.joinWait.level;
  lvl:autoShowMsg[lvl;loadStr;"@";`left];
  lvl:autoShowMsg[lvl;ip;"#";`left];
  lvl:autoShowMsg[lvl;portStr;"$";`left];
  lvl:autoShowMsg[lvl;msg;"&";`];

  prompt:$[hasErrored;"Quit [Q], Menu [M] ";""];

  draw[lvl;prompt];
 };

joinWait:{[params]  // Repeatedly queries the host address until it receives the other player's name and what colour to start as
  gd:`scene`params!(`joinWait;()!());
  gd[`params;`pName]:params`pName;
  gd[`params;`address]:params`address;
  gd[`params;`id]:params`id;
  gd[`params;`otherPName]:"";  // Will be assigned by the server
  gd[`params;`isWhite]:0b;     // Will be assigned by the server

  ip:vs[":";string gd[`params;`address]]1;
  portStr:vs[":";string gd[`params;`address]]2;

  ready:0b;  // If ready to go to play mode
  msg:"";
  loadProg:0;
  hasErrored:0b;  // Stops the process trying to query the server if true

  .joinWait.draw[loadProg#".";ip;portStr;msg;hasErrored];

  while[`joinWait~gd`scene;
    sts:.z.p;

    if[hasErrored;  // If an error occurred when trying to query the server, allow user input
      input:getInput[];
      $[
        input~"q";:.game.quitDict;
        input~"m";:.game.menuDict
      ];
    ];

    if[not hasErrored;
      loadProg:mod[loadProg+1;4];

      res:.joinWait.getUpdate[gd[`params;`address];gd[`params;`id]];
      $[first res;if[res 1;  // If received all the details needed from the server
          gd[`params;`otherPName]:res 2;
          gd[`params;`isWhite]:res 3;
          gd[`scene]:`play;
          :gd;  // Move to play mode
        ];
        [
          msg:last res;  // If an error occurred, allow it to be logged on screen
          hasErrored:1b;
        ]
      ];
    ];

    .joinWait.draw[loadProg#".";ip;portStr;msg;hasErrored];

    if[not hasErrored;limitFPS sts];  // Prevents too much refreshing
  ];

  :gd;
 };
