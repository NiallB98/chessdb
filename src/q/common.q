cls:{
  -1"";
  system"clear";
 };

getinput:{
  :lower last -1 _ read0 0;
 };

replaceall:{[lvl;char;newchar]
  :ssr[lvl;char;newchar];
 };

replaceone:{[lvl;char;newchar;charnum;otherchar]
  indices:lvl ss char;
  lvl[indices[charnum]]:newchar;

  :replaceall[lvl;char;otherchar];
 };

limitfps:{[st]
  system"sleep ",string max,[%[1;FPS]-%[.z.t-st]1e3;0];
 };

setlen:{[size;str;align]
  c:count str;
  if[c>=size;:size#str];

  $[
    align~`left;[lnum:0;rnum:size-c];
    align~`right;[lnum:size-c;rnum:0];
    [lnum:floor (size-c)%2;rnum:ceiling (size-c)%2]
  ];

  :#[lnum;" "],str,rnum#" ";
 };

limitlen:{[size;str]
  :$[size>=count str;:str;size#str];
 };

draw:{[lvl;prompt]
  cls[];
  -1 lvl;
  1 prompt;
 };

getnumchars:{[lvl;tgtchar]
  :count lvl ss tgtchar;
 };

showmsg:{[lvl;msg;tgtstr;align]
  msg:setlen[count tgtstr;msg;align];
  :replaceall[lvl;tgtstr;msg];
 };

autoshowmsg:{[lvl;msg;tgtchar;align]
  num:getnumchars[lvl;tgtchar];
  :showmsg[lvl;msg;num#tgtchar;align];
 };

stophost:{
  value"\\p 0";
 };
