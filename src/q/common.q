system"l common/levelEditing.q";

.common.cls:{
  -1"\033[3;J\033[H\033[2J";
  -1"\033[3;J\033[H\033[2J";
 };

.common.getFullInput:{
  :trim {x where x<>"\n"}read0 0;
 };

.common.getInput:{
  :lower last .common.getFullInput[];
 };

.common.limitFPS:{[sts]
  ts:sts+`time$1e3%FPS;
  {t:.z.p;while[.z.p<x]}ts;
 };

.common.draw:{[lvl;prompt]
  .common.cls[];
  -1 lvl;
  if[not prompt~"";1 prompt];
 };

.common.limitLen:{[size;str]
  :$[size>=count str;:str;size#str];
 };

.common.getNumChars:{[lvl;tgtChar]
  :count lvl ss tgtChar;
 };

.common.getLevelNames:{[]
  dir:`:../../resources/levels;
  :`$_[-4]each string key[dir] where key[dir] like "*.txt";
 };
