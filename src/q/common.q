system"l common/level_editing.q";

cls:{
  -1"";
  system"clear";
 };

getinput:{
  :lower last -1 _ read0 0;
 };

limitfps:{[sts]
  ts:(.z.p-sts)%1e9;
  system"sleep ",string max,[%[1;FPS]-ts;0];
 };

draw:{[lvl;prompt]
  cls[];
  -1 lvl;
  1 prompt;
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
