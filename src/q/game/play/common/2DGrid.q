.common.play.get2DPos:{[pos]
  x:pos mod 8;
  y:pos div 8;

  :x,y;
 };

.common.play.rmOutOfGrid:{[xyList]
  :flip flip[xyList] where {(x<8) and x>=0}[first xyList] and {(x<8) and x>=0}last xyList;
 };
