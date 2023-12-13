MATERIAL_WEIGHTS:()!();
MATERIAL_WEIGHTS["p"]:100;
MATERIAL_WEIGHTS["n"]:350;
MATERIAL_WEIGHTS["b"]:350;
MATERIAL_WEIGHTS["r"]:525;
MATERIAL_WEIGHTS["q"]:1000;
MATERIAL_WEIGHTS["k"]:10000;

.material.getPieceNums:{[board1D]
  :ALL_PIECES!(count each group board1D)ALL_PIECES;
 };

.material.getScores:{[pieceNums]
  :ALL_PIECES!pieceNums[ALL_PIECES]*MATERIAL_WEIGHTS lower ALL_PIECES;
 };

material:{[board1D]
  pieceNums:.material.getPieceNums board1D;
  
  scores:.material.getScores[pieceNums;1b]WHITE_PIECES;

  :sum scores[WHITE_PIECES]-scores BLACK_PIECES;
 };
