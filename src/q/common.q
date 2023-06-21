system"l common/level_editing.q";

CAN_USE_SLEEP:@[{system"sleep 0";1b};0;0b];  // Checks if sleep command is possible (Can be possible in git bash for Windows so checking OS is not an alterative)

cls:{
  -1"",100#"\n";
 };

getfullinput:{
  :trim {x where x<>"\n"}read0 0;
 };

getinput:{
  :lower last getfullinput[];
 };

limitfps:{[sts]
  if[not CAN_USE_SLEEP;value"\\timeout 1";:()];  // For batch consoles, can only use integer numbers for timeout so will feel more sluggish than consoles that can use sleep instead

  ts:max(%[1;FPS]-(.z.p-sts)%1e9;0);
  system"sleep ",string ts;
 };

draw:{[lvl;prompt]
  cls[];
  -1 lvl;
  if[not prompt~"";1 prompt];
 };

limitlen:{[size;str]
  :$[size>=count str;:str;size#str];
 };

getnumchars:{[lvl;tgtchar]
  :count lvl ss tgtchar;
 };

getlevelnames:{[]
  dir:`:../../resources/levels;
  :`$_[-4]each string key[dir] where key[dir] like "*.txt";
 };
