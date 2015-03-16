unit Equal;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
     ComCtrls, StdCtrls, BassPlayerX, GR32_Image, ProgressBar32, xIni,
     GR32_Layers;

type
  TEqForm = class(TForm)
    EqBackImage: TImage32;
    EQ1: TProgressBar32;
    cbEqualizer: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    EQ2: TProgressBar32;
    EQ3: TProgressBar32;
    EQ4: TProgressBar32;
    EQ5: TProgressBar32;
    EQ6: TProgressBar32;
    EQ7: TProgressBar32;
    EQ0: TProgressBar32;
    EQ9: TProgressBar32;
    EQ8: TProgressBar32;
    ReverbSlider: TProgressBar32;
    EchoSlider: TProgressBar32;
    procedure FormCreate(Sender: TObject);
    procedure EQ1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EQ1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EqForm: TEqForm;
  EQGains: TEQGains;

implementation

uses Viewer, MyTools;

{$R *.dfm}


// Создание окна
procedure TEqForm.FormCreate(Sender: TObject);
begin
   EQGains[0] := EQ0.Position - 15.0;
   EQGains[1] := EQ1.Position - 15.0;
   EQGains[2] := EQ2.Position - 15.0;
   EQGains[3] := EQ3.Position - 15.0;
   EQGains[4] := EQ4.Position - 15.0;
   EQGains[5] := EQ5.Position - 15.0;
   EQGains[6] := EQ6.Position - 15.0;
   EQGains[7] := EQ7.Position - 15.0;
   EQGains[8] := EQ8.Position - 15.0;
   EQGains[9] := EQ9.Position - 15.0;

//   EchoSlider.Position := Player.EchoLevel;
//   ReverbSlider.Position := Player.ReverbLevel;
end;


// Изменение эквалайзера 
procedure TEqForm.EQ1Change(Sender: TObject);
var
   BandNum : integer;
begin
 if not cbEqualizer.Checked then exit;
 BandNum := (Sender as TProgressBar32).Tag - 1;
 EQGains[BandNum] := (Sender as TProgressBar32).Position - 15.0;
 Player.SetAEQGain(BandNum, EQGains[BandNum]);
end;


// Отображение окна
procedure TEqForm.FormShow(Sender: TObject);
begin
 EqBackImage.AutoSize:=true;
 Width:=EqBackImage.Width;
 Height:=EqBackImage.Height;
end;



procedure TEqForm.EQ1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
var
   BandNum : integer;
begin
   if not cbEqualizer.Checked then exit;

   BandNum := (Sender as TProgressBar32).Tag - 1;
   EQGains[BandNum] := (Sender as TProgressBar32).Position - 15.0;

   SetIniInt('EQ', 'EQ'+IntToStr(BandNum), (Sender as TProgressBar32).Position, IniFile);

   Player.SetAEQGain(BandNum, EQGains[BandNum]);  // * Changed at Ver 1.6
end;


end.

