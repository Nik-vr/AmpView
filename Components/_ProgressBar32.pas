unit ProgressBar32;

interface

uses SysUtils, Classes, Controls, GR32_Image, GR32;

type
  TProgressBar32 = class(TImage32)
  private
    { Private declarations }
    FMaximum: cardinal;
    FPosition: cardinal;
    FThumbPosition: cardinal;
    FPressed: boolean;
    // Samples
    FRuler: TBitmap32;
    FThumbNormal: TBitmap32;
    FThumbPressed: TBitmap32;
    // Functions
    procedure DrawProgress;
    procedure SetThumbNormalImage(const Value: TBitmap32);
    procedure SetThumbPressedImage(const Value: TBitmap32);
    procedure SetRulerImage(const Value: TBitmap32);
    procedure SetPosition(const Value: cardinal);
    procedure SetMaximum(const Value: cardinal);
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
    // Load images
    procedure LoadRuler(FileName: string);
    procedure LoadThumbNormal(FileName: string);
    procedure LoadThumbPressed(FileName: string);
    // Set property
    property Maximum: cardinal read FMaximum write SetMaximum;
    property Position: cardinal read FPosition write SetPosition;
    property Pressed: boolean read FPressed;    
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
 pos: cardinal;
begin
  //
  if not Visible then exit;
  try
   if not (FRuler=nil) then Bitmap:=FRuler
    else exit;

  Width:=FRuler.Width;
  Height:=FRuler.Height;

  if FMaximum=0 then FMaximum:=1;

  pos:=(FPosition*(Width-ThumbNormal.Width)) div FMaximum;
  FThumbPosition:=pos;

  if FPressed
   then FThumbPressed.DrawTo(Bitmap, Pos, 0)
   else FThumbNormal.DrawTo(Bitmap, Pos, 0);
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
procedure TProgressBar32.SetPosition(const Value: cardinal);
begin
  FPosition := Value;
//  if
  if Visible then DrawProgress;
end;


// Set progress maximum
procedure TProgressBar32.SetMaximum(const Value: cardinal);
begin
  FMaximum := Value;
  if Visible then DrawProgress;
end;


// On mouse down
procedure TProgressBar32.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pos: cardinal;
begin
  //
  if Button<>mbLeft then exit;

  pos:=(x*FMaximum) div FRuler.Width;
  // Если щелкнули НЕ на бегунке
  if (x<FThumbPosition )
  or (x>FThumbPosition+FThumbNormal.Width)
  then
   begin
    FPosition:=pos;
    if Visible then DrawProgress;
   end
  else
   // Если щелкнули НА бегунке
   begin
    FPressed:=true;
    if Visible then DrawProgress;
   end;

  inherited;

end;


// On mouse move
procedure TProgressBar32.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 pos: LongInt;
begin
  inherited;

  //
  if FPressed=true then
   begin
    pos:=(x*FMaximum) div FRuler.Width;
    if pos<=0 then pos:=0;
    if pos>=FMaximum
     then pos:=FMaximum;
    FThumbPosition:=pos;
    FPosition:=pos;
    if Visible then DrawProgress;
   end;
end;


// On mouse UP
procedure TProgressBar32.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  //
  if Button<>mbLeft then exit;
  if FPressed=true then
   begin
     FPressed:=false;
     if Visible then DrawProgress;
   end;

end;

end.
