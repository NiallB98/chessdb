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
  -1"Loading level data . . .";

  loadlevel each LEVELS;
  loadhowtosections[];

  -1"All level data loaded";
 };

indexgameboard:{[]  // Organises the indexes of the play level's chess board that correspond to the characters North, North-East, East, etc. of the centre of each chess square (So that they can be replaced with characters later)
  -1"Indexing game board . . .";
  
  .play.indices:(`$())!();

  lvlwidth:1+count first "\n" vs .play.level;  // Width of each line of the play level (including "\n")
  centreindices:.play.level ss "@";  // Indicies for centre characters of chess board squares

  .play.indices[`n]:centreindices-lvlwidth;
  .play.indices[`e]:centreindices+1;
  .play.indices[`s]:centreindices+lvlwidth;
  .play.indices[`w]:centreindices-1;

  .play.indices[`ne]:.play.indices[`n]+1;
  .play.indices[`se]:.play.indices[`s]+1;
  .play.indices[`sw]:.play.indices[`s]-1;
  .play.indices[`nw]:.play.indices[`n]-1;

  -1"Game board indexed";
 };

pre:{
  loadlevels[];
  indexgameboard[];

  -1"Starting game . . .";
  cls[];
 };
