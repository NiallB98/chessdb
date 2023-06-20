.joincfg.tryquery:{[ip;port;pname]
  res:@[{(`$":",x,":",string y)z}[ip;port];(`.subs.chessplayersub;pname);0b];
  
  confirmed:first res;
  msg:$[confirmed;raze"";"ERROR: Host unreachable"];
  id:$[not 0b~last res;last res;`];

  :(confirmed;msg;id);
 };

.joincfg.confirm:{[ip;port;pname]  // Confirms the following the host exists and they were looking for a player
  res:.joincfg.tryquery[ip;port;pname];
  
  confirmed:res 0;
  msg:res 1;
  id:res 2;

  :(confirmed;0;msg;ip;port;id);
 };
