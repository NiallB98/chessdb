.tl.getNewCursorPos:{[pos;step;isvertical]
  x:pos mod 8;
  y:pos div 8;

  $[
    isvertical;y:mod[y+step;8];
    x:mod[x+step;8]
  ];

  :x+y*8;
 };

.tl.moveCursor:{[input;csrd;isWhite]
  if[not input in "wasd";:csrd];

  sign:$[((input in "sd") and not isWhite) or isWhite and input in "wa";sign:-1;1];
  csrd[`pos]:.tl.getNewCursorPos[csrd`pos;1*sign;input in "ws"];

  :csrd;
 };
