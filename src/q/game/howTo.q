.howTo.insertData:{[lvl;section;data]
  :lvl;
 };

.howTo.showTitle:{[lvl;sections;opened]
  :lvl;
 };

.howTo.showSections:{[lvl;sections;opened;selected]
  :lvl;
 };

.howTo.showScrollArrows:{[lvl;sections;sectionData]
  :lvl;
 };

.howTo.draw:{[sections;sectionData;opened;selected]
  lvl:.howTo.level;
  lvl:.howTo.insertData[lvl;sections opened;sectionData opened];
  lvl:.howTo.showScrollArrows[lvl;sections;sectionData];
  lvl:.howTo.showTitle[lvl;sections;opened];
  lvl:.howTo.showSections[lvl;sections;opened;selected];

  draw[lvl;"Up/Down [W/S], Quit [Q], Menu [M], Select [E] "];
 };

howTo:{[params]
  gd:`scene`params!(`howTo;()!());

  sections:key .howTo.sections;
  sectionData:value .howTo.sections;
  opened:0;
  selected:0;

  .howTo.draw[sections;sectionData;opened;selected];

  while[`howTo~gd`scene;
    input:getInput[];
    $[
      input~"q";:.game.quitDict;
      input~"m";:.game.menuDict;
    ];

    .howTo.draw[sections;sectionData;opened;selected];
  ];

  :gd;
 };
