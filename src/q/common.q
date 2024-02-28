system"l common/levelEditing.q";

cls:{
  1"\033[H\033[2J\033[3J";
 };

getFullInput:{
  :trim {x where x<>"\n"}read0 0;
 };

getInput:{
  :lower last getFullInput[];
 };

limitFPS:{[sts]
  ts:sts+`time$1e3%FPS;
  {t:.z.p;while[.z.p<x]}ts;
 };

centreLvl:{[lvl]
  splitLvl:"\n" vs lvl;

  lvlWidth:count first splitLvl;
  termSize:@[{"J"$first system x};"tput cols";0];

  spacesCount:0|(floor termSize%2)-floor lvlWidth%2;

  :"\n" sv ,[spacesCount#" "]each splitLvl;
 };

draw:{[lvl;prompt]
  cls[];
  1 centreLvl lvl,"\n",prompt;
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
