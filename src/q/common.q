system"l common/levelEditing.q";

cls:{
  -1"\033[3;J\033[H\033[2J";
  -1"\033[3;J\033[H\033[2J";
 };

getFullInput:{
  :trim {x where x<>"\n"}read0 0;
 };

getInput:{
  :lower last getFullInput[];
 };

limitFPS:{[sts]
  ts:max(%[1;FPS]-(.z.p-sts)%1e9;0);
  system"sleep ",string ts;
 };

draw:{[lvl;prompt]
  cls[];
  -1 lvl;
  if[not prompt~"";1 prompt];
 };

limitLen:{[size;str]
  :$[size>=count str;:str;size#str];
 };

getNumChars:{[lvl;tgtChar]
  :count lvl ss tgtChar;
 };

getLevelNames:{[]
  dir:`:../../resources/levels;
  :`$_[-4]each string key[dir] where key[dir] like "*.txt";
 };
