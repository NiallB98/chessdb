.joinCfg.logic:{[input;selections;selected;ip;port;pName;id]
  $[
    "w"~lower last input;selected:mod[selected-1;count selections];
    "s"~lower last input;selected:mod[selected+1;count selections];
    (`join~selections selected) and "e"~lower last input;:.joinCfg.confirm[ip;port;pName];
    (1<count input) and selections[selected] in `ip`port;
      :.joinCfg.edit[input;selections;selected;ip;port;id]
  ];

  :$[
    `join~selections selected;(0b;selected;"Confirm? [E]";ip;port;id);
    (0b;selected;"";ip;port;id)
  ];
 };
