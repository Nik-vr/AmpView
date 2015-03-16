unit Caption;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
     GR32_Image, MyTools;

type
  TForm1 = class(TForm)
    AboutImage: TImage32;
    procedure FormShow(Sender: TObject);
  private
    procedure DrawWindow;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses PlayList, Viewer, SkinTypes;

{$R *.dfm}

procedure TForm1.DrawWindow;
var
 i: integer;
 WindowRgn: HRGN;
 temp: integer;
begin
  with PLImages do
   begin
    Height:=Font.Size*2;

 AboutImage.Top:=0;
 AboutImage.Left:=0;
 AboutImage.Width:=Width;
 AboutImage.Height:=Height;


    AboutImage.SetupBitmap;
    AboutImage.BeginUpdate;
    AboutImage.Bitmap.Clear(ListOptions.BackColor1);
//    LeftTopImage.DrawTo(AboutImage.Bitmap, 0,0);
//    //
//    temp:=AboutImage.Width div TopImage.Width;
//    for i:=0 to temp do
//     begin
//       TopImage.DrawTo(AboutImage.Bitmap, i*TopImage.Width,0);
//     end;
//    //
//    temp:=AboutImage.Width div BottomImage.Width;
//    for i:=0 to temp do
//     begin
//       BottomImage.DrawTo(AboutImage.Bitmap, i*BottomImage.Width, AboutImage.Height-BottomImage.Height);
//     end;
//    //
//    temp:=AboutImage.Height div LeftImage.Height;
//    for i:=0 to temp do
//     begin
//       LeftImage.DrawTo(AboutImage.Bitmap, 0, i*LeftImage.Height);
//     end;
//    //
//    temp:=AboutImage.Height div LeftImage.Height;
//    for i:=0 to temp do
//     begin
//       RightImage.DrawTo(AboutImage.Bitmap, AboutImage.Width-RightImage.Width, i*LeftImage.Height);
//     end;
//
//    LeftTopImage.DrawTo(AboutImage.Bitmap, 0,0);
//    RightTopImage.DrawTo(AboutImage.Bitmap, AboutImage.Width-RightTopImage.Width,0);
//    LeftBottomImage.DrawTo(AboutImage.Bitmap, 0, AboutImage.Height-BottomImage.Height);
//    RightBottomImage.DrawTo(AboutImage.Bitmap, AboutImage.Width-RightBottomImage.Width,AboutImage.Height-BottomImage.Height);
//
//
//    InfoBox.Left:=LeftOffset;
//    InfoBox.Top:=TopOffset;
//    InfoBox.Height:=AboutImage.Height-BottomOffset-TopOffset;
//    InfoBox.Width:=AboutImage.Width-RightOffset-LeftOffset;
   end;

   if AmpViewMainForm.TransparentColor then
    begin
     if DetectWinVersion<>wvXP then
      begin
       windowRgn := BitmapToRgn(AboutImage.Bitmap, AmpViewMainForm.TransparentColorValue);
       SetWindowRgn(Handle, WindowRgn, True);
      end
     else
      begin
        TransparentColorValue:=AmpViewMainForm.TransparentColorValue;
        TransparentColor:=true;
      end;
    end;

end;



procedure TForm1.FormShow(Sender: TObject);
begin
 DrawWindow;
end;


end.
