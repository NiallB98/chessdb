replaceAll:{[lvl;char;newChar]
  :ssr[lvl;char;newChar];
 };

replaceOne:{[lvl;char;newChar;charNum;otherChar]
  indices:lvl ss char;
  lvl[indices[charNum]]:newChar;

  :replaceAll[lvl;char;otherChar];
 };

setLen:{[size;str;align]
  c:count str;
  if[c>=size;:size#str];

  $[
    align~`left;[lNum:0;rNum:size-c];
    align~`right;[lNum:size-c;rNum:0];
    [lNum:floor (size-c)%2;rNum:ceiling (size-c)%2]
  ];

  :#[lNum;" "],str,rNum#" ";
 };

showMsg:{[lvl;msg;tgtStr;align]
  msg:setLen[count tgtStr;msg;align];
  :replaceAll[lvl;tgtStr;msg];
 };

autoShowMsg:{[lvl;msg;tgtChar;align]
  tgtChar;
  num:getNumChars[lvl;tgtChar];
  :showMsg[lvl;msg;num#tgtChar;align];
 };
