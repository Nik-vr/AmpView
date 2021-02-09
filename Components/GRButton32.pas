unit GRButton32;

interface

uses
 SysUtils, Classes, Controls, GR32_Image, GR32, Dialogs;

type
TButtonState=(bsInactive, bsPushed, bsUsed);

type
 TButton32 = class(TImage32)
 private
   FInactiveButton: TBitmap32;
   FPushedButton: TBitmap32;
   FUsedButton: TBitmap32;
   FState: TButtonState;
   FChecked: boolean;
   procedure SetPushedButton(const Value: TBitmap32);
   procedure SetInactiveButton(const Value: TBitmap32);
   procedure SetUsedButton(const Value: TBitmap32);
   procedure SetChecked(const Value: boolean);
 protected
   procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); overload; override;
   procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); overload; override;
 public
   { Public declarations }
   constructor Create;    
   // Set images
   property InactiveButton: TBitmap32 read FInactiveButton write SetInactiveButton;
   property PushedButton: TBitmap32 read FPushedButton write SetPushedButton;
   property UsedButton: TBitmap32 read FUsedButton write SetUsedButton;
   // Load images
   procedure LoadInactiveButton(FileName: string);
   procedure LoadPushedButton(FileName: string);
   procedure LoadUsedButton(FileName: string);
   //
   procedure DrawButton;
   property Checked: boolean read FChecked write SetChecked;    
 published
   { Published declarations }
 end;

procedure Register;

implementation

procedure Register;
begin
 RegisterComponents('Graphics32', [TButton32]);
end;

{ TButton33 }

procedure TButton32.LoadPushedButton(FileName: string);
var
tempImage: TBitmap32;
begin
tempImage:=TBitmap32.Create;
tempImage.LoadFromFile(FileName);
FPushedButton:=tempImage;
end;

procedure TButton32.LoadInactiveButton(FileName: string);
var
tempImage: TBitmap32;
begin
tempImage:=TBitmap32.Create;
tempImage.LoadFromFile(FileName);
FInactiveButton:=tempImage;
end;

procedure TButton32.LoadUsedButton(FileName: string);
var
tempImage: TBitmap32;
begin
tempImage:=TBitmap32.Create;
tempImage.LoadFromFile(FileName);
FUsedButton:=tempImage;
end;

procedure TButton32.SetPushedButton(const Value: TBitmap32);
begin
 FPushedButton := Value;
end;

procedure TButton32.SetInactiveButton(const Value: TBitmap32);
begin
 FInactiveButton := Value;
end;

procedure TButton32.SetUsedButton(const Value: TBitmap32);
begin
 FUsedButton := Value;
end;

procedure TButton32.DrawButton;
begin
case FState of
 bsInactive: Bitmap:=FInactiveButton;
 bsPushed: Bitmap:=FPushedButton;
 bsUsed: Bitmap:=FUsedButton;
end;

Height:=Bitmap.Height;
Width:=Bitmap.Width;      
end;

constructor TButton32.Create;
begin
 FState:=bsInactive;
end;

procedure TButton32.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
 Y: Integer);
begin
 inherited;
 if Button<>mbLeft then exit;
 FState:=bsPushed;
 DrawButton;
end;

procedure TButton32.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
 Y: Integer);
begin
 inherited;
 if Button<>mbLeft then exit;
 if FChecked
  then FState:=bsUsed
  else FState:=bsInactive;

//  FState:=bsInactive;
 DrawButton;
end;

procedure TButton32.SetChecked(const Value: boolean);
begin
 FChecked := Value;
 if FChecked
  then FState:=bsUsed
  else FState:=bsInactive;

 DrawButton;
end;

end.