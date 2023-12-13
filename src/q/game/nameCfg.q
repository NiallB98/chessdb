system"l game/nameCfg/draw.q";

.nameCfg.confirmName:{[pName;passToScene]
  :`scene`params!(passToScene;enlist[`pName]!enlist pName);
 };

.nameCfg.isValidName:{[input]
  input:trim raze input;
  :all[input in .Q.an," "] and not ""~.common.limitLen[18;input];  // Name has to be all alphanumeric characters and not an empty string
 };

nameCfg:{[params]
  passToScene:params`passToScene;

  gd:`scene`params!(`nameCfg;()!());
  gd[`params;`pName]:18#"*";

  isEditing:1b;

  .nameCfg.draw[gd[`params;`pName];isEditing];

  while[`nameCfg~gd`scene;
    input:$[isEditing;.common.getFullInput[];.common.getInput[]];

    $[
      not[isEditing] and input~"q";:.game.quitDict;
      not[isEditing] and input~"m";:.game.menuDict;
      not[isEditing] and input~"y";:.nameCfg.confirmName[gd[`params;`pName];passToScene];
      not[isEditing] and input~"n";isEditing:1b;
      isEditing and .nameCfg.isValidName input;[
          gd[`params;`pName]:.common.limitLen[18;trim raze input];
          isEditing:0b;
        ]
    ];

    .nameCfg.draw[gd[`params;`pName];isEditing];
  ];

  :gd;
 };
