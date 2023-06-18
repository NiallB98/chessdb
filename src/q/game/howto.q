.howto.insertdata:{[lvl;section;data]
  :lvl;
 };

.howto.showtitle:{[lvl;sections;opened]
  :lvl;
 };

.howto.showsections:{[lvl;sections;opened;selected]
  :lvl;
 };

.howto.showscrollarrows:{[lvl;sections;sectiondata]
  :lvl;
 };

.howto.draw:{[sections;sectiondata;opened;selected]
  lvl:.howto.level;
  lvl:.howto.insertdata[lvl;sections opened;sectiondata opened];
  lvl:.howto.showscrollarrows[lvl;sections;sectiondata];
  lvl:.howto.showtitle[lvl;sections;opened];
  lvl:.howto.showsections[lvl;sections;opened;selected];

  draw[lvl;"Up/Down [W/S], Quit [Q], Menu [M], Select [E] "];
 };

howto:{[params]
  gd:`scene`params!(`spectate;()!());

  sections:key .howto.sections;
  sectiondata:value .howto.sections;
  opened:0;
  selected:0;

  .howto.draw[sections;sectiondata;opened;selected];

  while[`spectate~gd`scene;
    input:getinput[];
    $[
      input~"q";:.game.quitdict;
      input~"m";:.game.menudict;
    ];

    .howto.draw[sections;sectiondata;opened;selected];
  ];

  :gd;
 };
