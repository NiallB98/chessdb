assignlevel:{[lvl;data]
  $[`;".",string[lvl],".level"] set data;
 };

loadhowtodata:{[dir;filestr]
  tgt:dir,filestr;
  :"\n" sv read0`$":",tgt;
 };

loadhowtosections:{[]
  dir:"../../resources/levels/howto/";
  files:key`$":",dir;
  sections:`$_[-4]each string files;

  data:loadhowtodata[dir]each string files;
  
  .howto.sections:sections!data;
 };

loadlevel:{[lvl]
  file:"../../resources/levels/",string[lvl],".txt";

  -1"Loading ",file," . . .";
  assignlevel[lvl] "\n" sv read0`$":",file;
  -1"Loaded";
 };

loadlevels:{
  loadlevel each LEVELS;
  loadhowtosections[];
 };

pre:{
  -1"Loading level data . . .";
  loadlevels[];
  -1"All level data loaded";

  -1"Starting game . . .";
  cls[];
 };
