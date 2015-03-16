unit About;

interface

uses Windows, Forms, GR32_Image, MyTools, xIni, GR32_Layers,
     Controls, StdCtrls, ActnList, Classes, GR32, Graphics;

type
  TAboutForm = class(TForm)
    AboutImage: TImage32;
    InfoBox: TListBox;
    ActionList1: TActionList;
    Action1: TAction;
    procedure FormShow(Sender: TObject);
    procedure InfoBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Action1Execute(Sender: TObject);
    procedure AboutImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure InfoBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
   procedure DrawWindow;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses Viewer, PlayList, Options, Equal;

{$R *.dfm}

// Отображение окна
procedure TAboutForm.FormShow(Sender: TObject);
const
 version='3.2 (beta 2)';
var
 temp: string;
begin
 DrawWindow;

 SetWindowPos(AboutForm.Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

 with InfoBox do
  begin
   Items.Clear;
   InfoBox.Color:=ListOptions.BackColor1;
   //
   temp:=AmpViewMainForm.ItemAbout.Caption;
   if temp[1]='&'
    then temp:=Copy(temp, 2, Length(temp));

//   AboutImage.Bitmap.RenderTextW(4, 1, temp, 3, Color32(clBlack));

   temp:='AmpView. '+version;
   AboutImage.Bitmap.RenderTextW(4, 1, temp, 3, Color32(SkinText.BitRateFont.Color));

   Items.Add('');
   if GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile)='Russian.lng'
    then Items.Add('Автор (c) 2004-2006 Николай Петроченко')
    else Items.Add('Author (c) 2004-2006 Nikolay Petrochenko');

   Items.Add('E-mail: Nik_vr@mail.ru');
   Items.Add('');
   Items.Add(OptionsForm.LanguageBox.Caption+': ' + GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile) );
   Items.Add(OptionsForm.TranslatorBox.Caption+': '+OptionsForm.TranslatorLabel.Caption);
   Items.Add('');
   Items.Add(OptionsForm.SkinBox.Caption);
   Items.Add(SkinText.Description);
   Items.Add(SkinText.Author);
  end;
end;


procedure TAboutForm.DrawWindow;
var
 i: integer;
 WindowRgn: HRGN;
 temp: integer;
begin
 AboutImage.Top:=0;
 AboutImage.Left:=0;
 AboutImage.Width:=Width;
 AboutImage.Height:=Height;

  with PLImages do
   begin
    AboutImage.SetupBitmap;
    AboutImage.BeginUpdate;
    LeftTopImage.DrawTo(AboutImage.Bitmap, 0,0);
    //
    temp:=AboutImage.Width div TopImage.Width;
    for i:=0 to temp do
     begin
       TopImage.DrawTo(AboutImage.Bitmap, i*TopImage.Width,0);
     end;
    //
    temp:=AboutImage.Width div BottomImage.Width;
    for i:=0 to temp do
     begin
       BottomImage.DrawTo(AboutImage.Bitmap, i*BottomImage.Width, AboutImage.Height-BottomImage.Height);
     end;
    //
    temp:=AboutImage.Height div LeftImage.Height;
    for i:=0 to temp do
     begin
       LeftImage.DrawTo(AboutImage.Bitmap, 0, i*LeftImage.Height);
     end;
    //
    temp:=AboutImage.Height div LeftImage.Height;
    for i:=0 to temp do
     begin
       RightImage.DrawTo(AboutImage.Bitmap, AboutImage.Width-RightImage.Width, i*LeftImage.Height);
     end;

    LeftTopImage.DrawTo(AboutImage.Bitmap, 0,0);
    RightTopImage.DrawTo(AboutImage.Bitmap, AboutImage.Width-RightTopImage.Width,0);
    LeftBottomImage.DrawTo(AboutImage.Bitmap, 0, AboutImage.Height-BottomImage.Height);
    RightBottomImage.DrawTo(AboutImage.Bitmap, AboutImage.Width-RightBottomImage.Width,AboutImage.Height-BottomImage.Height);

    InfoBox.Left:=LeftOffset;
    InfoBox.Top:=TopOffset;
    InfoBox.Height:=AboutImage.Height-BottomOffset-TopOffset;
    InfoBox.Width:=AboutImage.Width-RightOffset-LeftOffset;
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




procedure TAboutForm.InfoBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
 text: string;
begin
 // выбор цветов и отрисовка
  with Control as TListBox do
  begin
   Canvas.Brush.Color:=ListOptions.BackColor1;
   // Если курсор на файле
   if odSelected in State
    then
     begin
      Canvas.Font:=ListOptions.SelectedFont;
      Canvas.Brush.Color:=ListOptions.SelectedBackColor;
     end
    else
     begin
      Canvas.Font:=ListOptions.Font;
      if (Index mod 2)=0
       then Canvas.Brush.Color:=ListOptions.BackColor1
       else Canvas.Brush.Color:=ListOptions.BackColor2;
     end;

    Canvas.FillRect(Rect);
    text:=Items[index];
    Canvas.TextOut(Rect.Left + 2, Rect.Top, text);
    // Зарисовка рамки фокуса
    if odFocused in State then DrawFocusRect(Canvas.Handle, Rect);
  end;
end;

procedure TAboutForm.Action1Execute(Sender: TObject);
begin
 Close;
end;

procedure TAboutForm.AboutImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
 if Button=mbRight then Close;
end;

procedure TAboutForm.InfoBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then Close;
end;

end.
