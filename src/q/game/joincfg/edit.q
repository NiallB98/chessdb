.joinCfg.isValidIP:{[input]
  if[any input in ("localhost";".z.a");:1b];  // Special cases
  :raze["1"]~raze system"bash ../sh/verify_ip.sh ",input;
 };

.joinCfg.formatIP:{[input]
  :$[any input in ("localhost";".z.a");"." sv string"i"$0x0 vs .z.a;input];
 };

.joinCfg.editIP:{[input;ip]
  msg:raze"";
  $[.joinCfg.isValidIP[input];
    ip:.joinCfg.formatIP input;
    msg:"ERROR: Inputted IP address was invalid"
  ];
  :(ip;msg);
 };

.joinCfg.isValidPort:{[input]
  res:all input in .Q.n;
  :$[not res;
    0b;
    65535>=value input
  ];
 };

.joinCfg.editPort:{[input;port]
  msg:raze"";
  $[.joinCfg.isValidPort[input];
    port:value input;
    msg:"ERROR: Inputted port was invalid"
  ];
  :(port;msg);
 };

.joinCfg.edit:{[input;selections;selected;ip;port;id]
  $[`ip~selections selected;
    [res:.joinCfg.editIP[input;ip];ip:first res];
    [res:.joinCfg.editPort[input;port];port:first res]
  ];

  msg:last res;

  :(0b;selected;msg;ip;port;id);
 };
