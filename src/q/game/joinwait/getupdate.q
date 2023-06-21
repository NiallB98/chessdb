.joinwait.getupdate:{[address;id]  // Either returns 4 arguments if no error occured or 2 if one has, the first argument == 0b if an error has occurred
  res:@[{x y}[address];(`getupdate;id);0b];  // If successful res == (1b;`pre;"Some player name";"w" or "b")

  if[not first res;:(0b;"ERROR: Lost connection to the host")];  // Return early if query failed
  
  if[not `pre~res 1;                 // Return early if server is not at pre-game stage
    :$[`error~res 1;(0b;res 2);      // If server has provided an error message
      (0b;"ERROR:Denied by host")];  // Otherwise just give a more generic error
  ];
  
  otherpname:res 2;
  iswhite:"w"~res 3;
  
  ready:not ""~otherpname;
  :(1b;ready;otherpname;iswhite);
 };
