assignLevel:{[lvl;data]
  $[`;".",string[lvl],".level"] set data;
 };

loadHowToData:{[dir;fileStr]
  tgt:dir,fileStr;
  :"\n" sv read0`$":",tgt;
 };

loadHowToSections:{[]
  dir:"../../resources/levels/howTo/";
  files:key`$":",dir;
  sections:`$_[-4]each string files;

  data:loadHowToData[dir]each string files;
  
  .howTo.sections:sections!data;
 };

loadLevel:{[lvl]
  file:"../../resources/levels/",string[lvl],".txt";

  -1"Loading ",file," . . .";
  assignLevel[lvl] "\n" sv read0`$":",file;
  -1"Loaded";
 };

loadLevels:{
  -1"Loading level data . . .";

  loadLevel each LEVELS;
  loadHowToSections[];

  -1"All level data loaded";
 };

indexGameBoard:{[]  // Organises the indices of the play level's chess board that correspond to the characters North, North-East, East, etc. of the centre of each chess square (So that they can be replaced with characters later)
  -1"Indexing game board . . .";
  
  .play.indices:(`$())!();

  lvlWidth:1+count first "\n" vs .play.level;  // Width of each line of the play level (including "\n")
  centreIndices:.play.level ss "@";  // Indicies for centre characters of chess board squares

  .play.indices[`n]:centreIndices-lvlWidth;
  .play.indices[`e]:centreIndices+1;
  .play.indices[`s]:centreIndices+lvlWidth;
  .play.indices[`w]:centreIndices-1;

  .play.indices[`ne]:.play.indices[`n]+1;
  .play.indices[`se]:.play.indices[`s]+1;
  .play.indices[`sw]:.play.indices[`s]-1;
  .play.indices[`nw]:.play.indices[`n]-1;

  -1"Game board indexed";
 };

pre:{
  loadLevels[];
  indexGameBoard[];

  -1"Starting game . . .";
  cls[];
 };
