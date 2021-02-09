unit ProgressBar32;

interface

uses SysUtils, Classes, Controls, GR32_Image, GR32, ExtCtrls;

type
  TProgressBar32 = class(TImage32)
  private
    { Private declarations }
    FMaximum: int64;
    FPosition: int64;
    FThumbPosition: integer;
    FPressed: boolean;
    FIsThumbCenter: Boolean;
    // Samples
    FRuler: TBitmap32;
    FThumbNormal: TBitmap32;
    FThumbPressed: TBitmap32;
    FRulerImageFN:string;
    FThumbNormalImageFN:string;
    FThumbPressedImageFN:string;
    //
    FPos:integer;
    FMouseOverPos:Integer;
    FThumbPosX:integer;
    // Functions
    procedure DrawProgress;
    procedure SetThumbNormalImage(const Value: TBitmap32);
    procedure SetThumbPressedImage(const Value: TBitmap32);
    procedure SetRulerImage(const Value: TBitmap32);
    procedure SetPosition(const Value: int64);
    procedure SetMaximum(const Value: int64);
    // Load images
    procedure LoadRuler(FileName: string);
    procedure LoadThumbNormal(FileName: string);
    procedure LoadThumbPressed(FileName: string);
  protected
    // Mouse events
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); overload; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); overload; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); overload; override;
  public
    constructor Create;
    destructor  Destroy; override;
    // Set images
    property Ruler: TBitmap32 read FRuler write SetRulerImage;
    property ThumbNormal: TBitmap32 read FThumbNormal write SetThumbNormalImage;
    property ThumbPressed: TBitmap32 read FThumbPressed write SetThumbPressedImage;
    // images
    property RulerImage:string read FRulerImageFN write FRulerImageFN;
    property ThumbNormalImage:string read FThumbNormalImageFN write FThumbNormalImageFN;
    property ThumbPressedImage:string read FThumbPressedImageFN write FThumbPressedImageFN;
    // Set property
    property IsThumbCenter: boolean read FIsThumbCenter write FIsThumbCenter;
    property Maximum: int64 read FMaximum write SetMaximum;
    property Position: int64 read FPosition write SetPosition;
    property Pressed: boolean read FPressed;
    property MouseOverPos:Integer read FMouseOverPos write FMouseOverPos;
    property ThumbPos:Integer read FThumbPosX write FThumbPosX;
  published
    { Published declarations }
  end;

procedure Register;

implementation

// Register component
procedure Register;
begin
  RegisterComponents('Graphics32', [TProgressBar32]);
end;


// Create
constructor TProgressBar32.Create;
begin
  FMaximum:=100;
  FPosition:=0;
  FThumbPosition:=0;
  FPressed:=false;
//
  FRuler:= TBitmap32.Create;
  FThumbNormal:= TBitmap32.Create;
  FThumbPressed:= TBitmap32.Create;
  if FRulerImageFN='' then raise Exception.Create('No ruler image specified');
  if FThumbNormalImageFN='' then raise Exception.Create('No thumb normal image specified');
  if FThumbPressedImageFN='' then raise Exception.Create('No thumb presed image specified');
  LoadRuler(FRulerImageFN);
  LoadThumbNormal(FThumbNormalImageFN);
  LoadThumbPressed(FThumbPressedImageFN);
  Bitmap:=TBitmap32.Create;
  if IsThumbCenter then
    Bitmap.Width:=FRuler.Width+FThumbNormal.Width
  else
    Bitmap.Width:=FRuler.Width;
  Bitmap.Height:=FRuler.Height;
  Width:=Bitmap.Width;
  Height:=Bitmap.Height;
end;


// Destroy
destructor TProgressBar32.Destroy;
begin
//  FRuler.Free;
//  FThumbNormal.Free;
//  FThumbPressed.Free;
  inherited;
end;

// Draw Progress Bar
procedure TProgressBar32.DrawProgress;
var
 pos: integer;
 col:longint;
begin
  //
  if not Visible then exit;
  try
   {if not (FRuler=nil) then Bitmap:=FRuler
    else exit;}
  if FRuler=nil then exit;

  // resets somewhere
  //Width:=FRuler.Width+FThumbNormal.Width;
  //Height:=FRuler.Height;

  if FMaximum=0 then FMaximum:=1;

  //pos:=(FPosition*(Width-ThumbNormal.Width)) div FMaximum;
  if IsThumbCenter then
    pos:=(FPosition*(FRuler.Width)) div FMaximum-ThumbNormal.Width div 2
  else
    begin
    pos:=(FPosition*(FRuler.Width)) div FMaximum-ThumbNormal.Width div 2;
    if pos<0 then pos:=0;
    if pos>FRuler.Width-ThumbNormal.Width then pos:=FRuler.Width-ThumbNormal.Width;
    end;

  FThumbPosition:=pos;

  if IsThumbCenter then
    begin
    FThumbPosX:=FThumbPosition+(ThumbNormal.Width div 2)+(ThumbNormal.Width div 2); // first is center of thumb, second is padding left of ruler
    col:=FRuler.Pixel[0,0];
    Bitmap.FillRect(0,0,Bitmap.Width,Bitmap.Height,col);
    FRuler.DrawTo(Bitmap,ThumbNormal.Width div 2,0);
    if FPressed
     then FThumbPressed.DrawTo(Bitmap, Pos+ThumbNormal.Width div 2, 0)
     else FThumbNormal.DrawTo(Bitmap, Pos+ThumbNormal.Width div 2, 0);
    end
  else
    begin
    FThumbPosX:=FThumbPosition+ThumbNormal.Width div 2;
    FRuler.DrawTo(Bitmap,0,0);
    if FPressed
     then FThumbPressed.DrawTo(Bitmap, Pos, 0)
     else FThumbNormal.DrawTo(Bitmap, Pos, 0);
    end;
  except
  end;
  //
end;


// Set images
procedure TProgressBar32.SetThumbNormalImage(const Value: TBitmap32);
begin
  FThumbNormal := Value;
end;
procedure TProgressBar32.SetThumbPressedImage(const Value: TBitmap32);
begin
  FThumbPressed := Value;
end;
procedure TProgressBar32.SetRulerImage(const Value: TBitmap32);
begin
  FRuler := Value;
end;


// Load images
procedure TProgressBar32.LoadRuler(FileName: string);
var
 tempImage: TBitmap32;
begin
 tempImage:=TBitmap32.Create;
 tempImage.LoadFromFile(FileName);
 FRuler:=tempImage;
end;

procedure TProgressBar32.LoadThumbNormal(FileName: string);
var
 tempImage: TBitmap32;
begin
 tempImage:=TBitmap32.Create;
 tempImage.LoadFromFile(FileName);
 FThumbNormal:=tempImage;
end;

procedure TProgressBar32.LoadThumbPressed(FileName: string);
var
 tempImage: TBitmap32;
begin
 tempImage:=TBitmap32.Create;
 tempImage.LoadFromFile(FileName);
 FThumbPressed:=tempImage;
end;


// Set thumb position
procedure TProgressBar32.SetPosition(const Value: int64);
begin
  FPosition := Value;
//  if
  if Visible then DrawProgress;
end;


// Set progress maximum
procedure TProgressBar32.SetMaximum(const Value: int64);
begin
  FMaximum := Value;
  if Visible then DrawProgress;
end;


// On mouse down
procedure TProgressBar32.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pos: integer;
begin
  //
  if Button<>mbLeft then exit;
  if IsThumbCenter then x:=x-FThumbNormal.Width div 2;
  if x<0 then x:=0;
  pos:=(x*FMaximum) div FRuler.Width;
  // Если щелкнули НЕ на бегунке
  if (x<FThumbPosition )
  or (x>FThumbPosition+FThumbNormal.Width)
  then
   begin
   FPosition:=pos;
   if FPosition>FMaximum then FPosition:=FMaximum;
   FPressed:=true;
   if Visible then DrawProgress;
   end
  else
   // Если щелкнули НА бегунке
   begin
    FPressed:=true;
    FPosition:=pos;
    if FPosition>FMaximum then FPosition:=FMaximum;
    if Visible then DrawProgress;
   end;

  inherited;

end;


// On mouse move
procedure TProgressBar32.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 pos: LongInt;
begin
  if IsThumbCenter then x:=x-FThumbNormal.Width div 2;
  if x<0 then x:=0;
  //
    pos:=(x*FMaximum) div FRuler.Width;
    if pos<=0 then pos:=0;
    if pos>=FMaximum
     then pos:=FMaximum;
    FMouseOverPos:=pos; 
  //
  if FPressed=true then
   begin
    FThumbPosition:=pos;
    FPosition:=pos;
    if Visible then DrawProgress;
   end;
  inherited; 

end;


// On mouse UP
procedure TProgressBar32.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //
  if Button<>mbLeft then exit;
  if FPressed=true then
   begin
     FPressed:=false;
     if Visible then DrawProgress;
   end;

  inherited;

end;

end.
