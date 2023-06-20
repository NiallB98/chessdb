.joincfg.isvalidip:{[input]
  if[any input in ("localhost";".z.a");:1b];  // Special cases
  :raze["1"]~raze system"bash ../sh/verify_ip.sh ",input;
 };

.joincfg.formatip:{[input]
  :$[any input in ("localhost";".z.a");"." sv string"i"$0x0 vs .z.a;input];
 };

.joincfg.editip:{[input;ip]
  msg:raze"";
  $[.joincfg.isvalidip[input];
    ip:.joincfg.formatip input;
    msg:"ERROR: Inputted IP address was invalid"
  ];
  :(ip;msg);
 };

.joincfg.isvalidport:{[input]
  res:all input in .Q.n;
  :$[not res;
    0b;
    65535>=value input
  ];
 };

.joincfg.editport:{[input;port]
  msg:raze"";
  $[.joincfg.isvalidport[input];
    port:value input;
    msg:"ERROR: Inputted port was invalid"
  ];
  :(port;msg);
 };

.joincfg.edit:{[input;selections;selected;ip;port;id]
  $[`ip~selections selected;
    [res:.joincfg.editip[input;ip];ip:first res];
    [res:.joincfg.editport[input;port];port:first res]
  ];

  msg:last res;

  :(0b;selected;msg;ip;port;id);
 };
