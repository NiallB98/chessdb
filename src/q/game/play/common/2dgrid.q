.play.get2dpos:{[pos]
  x:pos mod 8;
  y:pos div 8;

  :x,y;
 };

.play.rmoutofgrid:{[xylist]
  :flip flip[xylist] where {(x<8) and x>=0}[first xylist] and {(x<8) and x>=0}last xylist;
 };
