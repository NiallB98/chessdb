system"l common.q";
system"l pre.q";
system"l game.q";
system"l post.q";

FPS:10;
DEBUG:0b;
LEVELS:getlevelnames[];

main:{
  pre[];
  game[];
  post[];
 };

if[not DEBUG;main[]];
