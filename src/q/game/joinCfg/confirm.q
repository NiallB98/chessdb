.joinCfg.tryQuery:{[ip;port;pName]
  res:@[{(`$":",x,":",string y)z}[ip;port];(`.subs.chessPlayerSub;pName);0b];
  
  confirmed:first res;
  msg:$[confirmed;raze"";"ERROR: Host unreachable"];
  id:$[not 0b~last res;last res;`];

  :(confirmed;msg;id);
 };

.joinCfg.confirm:{[ip;port;pName]  // Confirms the following the host exists and they were looking for a player
  res:.joinCfg.tryQuery[ip;port;pName];
  
  confirmed:res 0;
  msg:res 1;
  id:res 2;

  :(confirmed;0;msg;ip;port;id);
 };
