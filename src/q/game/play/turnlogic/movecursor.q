.tl.getnewpos:{[pos;step;isvertical]
  x:pos mod 8;
  y:pos div 8;

  $[
    isvertical;y:mod[y+step;8];
    x:mod[x+step;8]
  ];

  :x+y*8;
 };

.tl.movecursor:{[input;csrd;iswhite]
  if[not input in "wasd";:csrd];

  sign:$[((input in "sd") and not iswhite) or iswhite and input in "wa";sign:-1;1];
  csrd[`pos]:.tl.getnewpos[csrd`pos;1*sign;input in "ws"];

  :csrd;
 };
