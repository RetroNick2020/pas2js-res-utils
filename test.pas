// RESUtils example
// see video for additional info

Program test;
  uses browserconsole,Web,p2jsres,RESread,bitfonts;

{$R ibmfontvga.bin}
{$R text.txt}

Const
 FontPixelSize = 2;

var
 canvas : TJSHTMLCanvasElement;
 ctx    : TJSCanvasRenderingContext2D;

Procedure InitCanvas;
begin
  canvas:=TJSHTMLCanvasElement(document.getElementById('canvas'));
  ctx:=TJSCanvasRenderingContext2D(canvas.getContext('2d'));
  ctx.fillStyle := 'green';
  ctx.fillRect(0, 0, 800, 600);
end;

Procedure DisplayFonts;
begin
  ctx.fillStyle := 'red';
  ctx.font := '48px serif';
  ctx.fillText('Canvas Font Nick', 10, 50);
  ctx.fillStyle := 'blue';
  TextAt(0,100,'Bit Font Nick')
end;

Procedure DisplayTextFile;
var
 F : FileRes;
 LineStr : string;
 y : integer;
begin
 y:=10;
 RESAssignFile(F,'text'); 
 
 ctx.fillStyle := 'white';
 while (Not ResEOF(F)) do
 begin
    LineStr:=RESreadLine(F);
    textAt(8,y,LineStr);
    inc(y,10);
 end;   
end;

procedure DisplayAllChars;
var
 i,j, c : integer;
begin
  c:=0;
  ctx.fillStyle := 'white';
  for j:=1 to 16 do
  begin
    for i:=1 to 16 do
    begin
       charat(i*10,j*10,chr(c));
       inc(c);
    end;  
  end;  
end; 

Procedure BitFontPutPixel(x,y : integer);
begin
  //putpixel(x,y);
  ctx.fillRect(x*FontPixelSize, y*FontPixelSize, FontPixelSize, FontPixelSize);
end;

begin
  SetResourceSource(rsHTML); //do not forget this line
  InitCanvas;
  InitBitFonts;
  SetBitFontPixelProc(@BitFontPutPixel);
  //DisplayFonts;
  //DisplayTextFile;
  DisplayAllChars;
end.