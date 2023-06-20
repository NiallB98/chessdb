.pre.receivedids:`$();  // IDs of players that have moved to play mode
.pre.sides:-2?01b;      // Randomly assigns which player will be white (1b)

.pre.iscomplete:{[]  // Tracks if both players have gotten the details needed for them to move to play mode
  :2~count .pre.receivedids;
 };

.pre.getotherpname:{[id]
  :string first value[.subs.playernames] where not id in key .subs.playernames;
 };

.pre.getupdate:{[id]
  .pre.receivedids:distinct (.pre.receivedids,id) where (.pre.receivedids,id) in key .subs.players;  // Add to list of IDs received in pre-game stage and make sure it has no missing player IDs in it
  log_info"Pre-game update received for player '",string[.subs.playernames[id]],
          "' with handle [",string[.z.w],"]";
  
  if[.pre.iscomplete[];log_info"Both players updated, game has started"];

  :(`pre;.pre.getotherpname[id];.pre.sides .pre.receivedcount-1);
 };
