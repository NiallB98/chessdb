.joincfg.logic:{[input;selections;selected;ip;port;pname;id]
  $[
    "w"~lower last input;selected:mod[selected-1;count selections];
    "s"~lower last input;selected:mod[selected+1;count selections];
    (`join~selections selected) and "e"~lower last input;:.joincfg.confirm[ip;port;pname];
    (1<count input) and selections[selected] in `ip`port;
      :.joincfg.edit[input;selections;selected;ip;port];
  ];

  :$[
    `join~selections selected;(0b;selected;"Confirm? [E]";ip;port;id);
    (0b;selected;"";ip;port;id)
  ];
 };
