replaceall:{[lvl;char;newchar]
  :ssr[lvl;char;newchar];
 };

replaceone:{[lvl;char;newchar;charnum;otherchar]
  indices:lvl ss char;
  lvl[indices[charnum]]:newchar;

  :replaceall[lvl;char;otherchar];
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

showmsg:{[lvl;msg;tgtstr;align]
  msg:setlen[count tgtstr;msg;align];
  :replaceall[lvl;tgtstr;msg];
 };

autoshowmsg:{[lvl;msg;tgtchar;align]
  tgtchar;
  num:getnumchars[lvl;tgtchar];
  :showmsg[lvl;msg;num#tgtchar;align];
 };
