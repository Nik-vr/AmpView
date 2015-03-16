unit Viewer;

interface

uses Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms,
     XPMan, Menus, ExtCtrls, ActnList, GRButton32, StdCtrls, MyDialogs,
     MyTools, ProgressBar32, GR32, BASSPlayerX, PlayListClass, xIni,
     GR32_Layers, PNGImage, ZlibMultiple, SkinTypes, HotKeyTools,
     Dynamic_BASS, GR32_Image, TrayTools;

type
  TAmpViewMainForm = class(TForm)
    MainImage: TImage32;
    TimerImage: TImage32;
    TrackCaptionImage: TImage32;
    ProgressBar: TProgressBar32;
    VolumeBar: TProgressBar32;
    MinBtn: TButton32;
    CloseBtn: TButton32;
    OpenBtn: TButton32;
    InfoBtn: TButton32;
    PlayListBtn: TButton32;
    PrevBtn: TButton32;
    NextBtn: TButton32;
    MuteBtn: TButton32;
    PlayBtn: TButton32;
    PauseBtn: TButton32;
    StopBtn: TButton32;
    MainPopupMenu: TPopupMenu;
    ItemAbout: TMenuItem;
    N2: TMenuItem;
    ItemControlMenu: TMenuItem;
    ItemPlay: TMenuItem;
    ItemPause: TMenuItem;
    ItemStop: TMenuItem;
    N12: TMenuItem;
    ItemPrevTrack: TMenuItem;
    ItemNextTrack: TMenuItem;
    ItemNextFile: TMenuItem;
    N10: TMenuItem;
    ItemVolumeUp: TMenuItem;
    ItemVolumeDown: TMenuItem;
    N4: TMenuItem;
    ItemOptions: TMenuItem;
    ItemTimeMode: TMenuItem;
    ItemTopMost: TMenuItem;
    N9: TMenuItem;
    ItemClose: TMenuItem;
    ActionList: TActionList;
    ActionClose: TAction;
    ActionAbout: TAction;
    ActionRewind: TAction;
    ActionForward: TAction;
    ActionVolumeUp: TAction;
    ActionVolumeDown: TAction;
    ActionFileInfo: TAction;
    ActionMute: TAction;
    ActionPlay: TAction;
    ActionStop: TAction;
    ActionPause: TAction;
    ActionOptions: TAction;
    ActionTimeLeftMode: TAction;
    ActionTopMost: TAction;
    ActionPlayList: TAction;
    ActionNextTrack: TAction;
    ActionPrevTrack: TAction;
    ActionGetNextFile: TAction;
    ActionOpen: TAction;
    ActionMinimizeToTray: TAction;
    ActionRestoreFromTray: TAction;
    ActionCaseWindow: TAction;
    XPManifest1: TXPManifest;
    WorkTimer: TTimer;
    TrayPopupMenu: TPopupMenu;
    TrayItemRestore: TMenuItem;
    N6: TMenuItem;
    TrayItemStop: TMenuItem;
    TrayItemPause: TMenuItem;
    TrayItemPlay: TMenuItem;
    N7: TMenuItem;
    TrayItemNextTrack: TMenuItem;
    TrayItemPreviousTtrack: TMenuItem;
    N1: TMenuItem;
    TrayItemOptions: TMenuItem;
    N5: TMenuItem;
    TrayItemClose: TMenuItem;
    N3: TMenuItem;
    ActionEQ: TAction;
    ActionOpenFolder: TAction;
    procedure OpenDialogShow(Sender: TObject);
    procedure OpenDialogClose(Sender: TObject);
    procedure ProgressBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure TrackCaptionImageDblClick(Sender: TObject);
    procedure TimerImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MainImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure MainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure VolumeBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure VolumeBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ProgressBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ProgressBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure TrackCaptionImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure CloseBtnClick(Sender: TObject);
    procedure MinBtnClick(Sender: TObject);
    procedure TimerImageDblClick(Sender: TObject);
    procedure WorkTimerTimer(Sender: TObject);
    procedure ActionCaseWindowExecute(Sender: TObject);
    procedure ActionRestoreFromTrayExecute(Sender: TObject);
    procedure ActionMinimizeToTrayExecute(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionGetNextFileExecute(Sender: TObject);
    procedure ActionPrevTrackExecute(Sender: TObject);
    procedure ActionNextTrackExecute(Sender: TObject);
    procedure ActionPlayListExecute(Sender: TObject);
    procedure ActionTopMostExecute(Sender: TObject);
    procedure ActionTimeLeftModeExecute(Sender: TObject);
    procedure ActionOptionsExecute(Sender: TObject);
    procedure ActionPauseExecute(Sender: TObject);
    procedure ActionStopExecute(Sender: TObject);
    procedure ActionPlayExecute(Sender: TObject);
    procedure ActionMuteExecute(Sender: TObject);
    procedure ActionFileInfoExecute(Sender: TObject);
    procedure ActionVolumeDownExecute(Sender: TObject);
    procedure ActionVolumeUpExecute(Sender: TObject);
    procedure ActionForwardExecute(Sender: TObject);
    procedure ActionRewindExecute(Sender: TObject);
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetPlayEnd(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ActionEQExecute(Sender: TObject);
    procedure ActionOpenFolderExecute(Sender: TObject);
  private
    DragMode: boolean;
    x0, y0: integer;
    ShownOnce: Boolean;
    procedure WMDeactivate(var Msg: TMessage); message WM_KILLFOCUS;
    procedure WMActivate(var Msg: TMessage); message WM_ACTIVATEAPP;
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    procedure WMTransfer(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure WMTRAYICONNOTIFY(var Msg: TMessage); message WM_NOTIFYTRAYICON;
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;
    //
    procedure DrawText(x, y: integer; text: string; Font: TFont; DrawShadow: boolean);
    procedure DrawTimer(value: string);
    procedure GetNextFile;
    procedure GetNextTrack;
    procedure GetPrevTrack;
    procedure SetVolume(VolumeLevel: integer);
    procedure ShowAmpView(show: boolean);
    { Private declarations }
  public
    procedure AddFile(const TrackFile: string; redraw: boolean);
    procedure AddFolder(const Path: string);
    procedure OpenTrack(const FileName: string);
    procedure SetButtonStates;
    procedure SetTopMost(TopMost: boolean);
    procedure LoadLang(const FileName: string);
    procedure LoadSkin(const FileName: string);
    procedure DrawCaption(offset: integer);
    procedure LoadHotKeys(const FileName: string);
    procedure DrawInfo;
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

const
 version='3.2 (beta 9)';

var
  AmpViewMainForm: TAmpViewMainForm;
  PlugDir: string;
  IniFile: string;
  KeysFile: string;
  Player: TBASSPlayerX;
  MyPlayList: TPlayList;
  CurTrack: integer;
  // Элементы скина
  OpenDialog: TMyOpenDialog;
  SkinText: TSkinTextAtributes; // Описания тектовых элементов
  MainPicture: TBitmap32;       // Основной рисунок
  CaptionOffset: integer;
  // Глобальные "горячие клавиши"
  PlayGlobal: integer;
  StopGlobal: integer;
  PauseGlobal: integer;
  RestoreGlobal: integer;
  VolumeUpGlobal: integer;
  VolumeDownGlobal: integer;
  MuteGlobal: integer;
  NextTrackGlobal: integer;
  PrevTrackGlobal: integer;


implementation

uses PlayList, Options, Equal;

{$R *.dfm}

procedure TAmpViewMainForm.FormCreate(Sender: TObject);
var
 ConfigName: string;
begin
 OpenDialog:=TMyOpenDialog.Create(AmpViewMainForm);
 OpenDialog.Filter:='Popular media files|*mp3;*.ogg;*.mp1;*.mp2;*.wma;*.wav|Midi-files|*.mid;*.midi;*.rmi;*.kar|Module trakers|*.mod;*.it;*.xm|CD Audio tracks|*.cda|Playlists|*.m3u';
 OpenDialog.Options:=OpenDialog.Options+[ofAllowMultiSelect];

  DragMode:=false;
  ShownOnce := False;

  Width:=0;
  Height:=0;
  //
  PlugDir:=ExtractFileDir( Application.ExeName );
  CreateDir(PlugDir+'\Config');

  // Если включена опция "Общий файл конфигурации для всех пользователей"
  if GetIniBool('main', 'OnlyDefaultConfig', false, PlugDir+'\Config\default.ini')=true
   then ConfigName:='default'
   else ConfigName:=GetUserNameString;

  IniFile:=PlugDir+'\Config\'+ConfigName+'.ini';
  KeysFile:=PlugDir+'\Config\'+ConfigName+'.hk';
  WorkTimer.Enabled:=false;
  ProgressBar.Maximum:=0;

  // Инициализация проигрывателя
  Player:=TBASSPlayerX.Create(Application.Handle, PlugDir);
  Player.OnPlayEnd:=GetPlayEnd;

  MyPlayList:=TPlaylist.Create;
end;

procedure TAmpViewMainForm.FormShow(Sender: TObject);
var
 i: integer;
 ExtFile: string;
 NumOfExt: integer;
 FilterAdd: string;
begin

 PlayListForm.PlayList.Clear;

// Загрузка скина
 if FileExists(PlugDir+'\Skins\'+GetIniString('main', 'skin', 'Lister.avsz', IniFile))
  then LoadSkin(PlugDir+'\Skins\'+GetIniString('main', 'skin', 'Lister.avsz', IniFile))
  else LoadSkin(PlugDir+'\Skins\Lister.avsz');

 // Загрузка языка
 if FileExists(PlugDir+'\Language\'+GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile))
  then LoadLang(PlugDir+'\Language\'+GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile))
  else
   begin
    LoadLang(PlugDir+'\Language\'+GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng');
    SetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile);
   end;   
 LoadHotKeys(KeysFile);
                       
 // Опции
 left:=GetIniInt('Main', 'left', 25, -Width+10, Screen.Width-10, IniFile);
 top:=GetIniInt('Main', 'top', 25, -Width+10, Screen.Height-10, IniFile);
 SetWindowPos(PlayListForm.Handle, HWND_TOP, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 ItemTimeMode.Checked:=GetIniBool('main', 'timeleftmode', false, IniFile);

 // Уровень звука
 VolumeBar.Maximum:=100;
 VolumeBar.Position:=GetIniInt('main', 'volume', 90, 0, VolumeBar.Maximum, IniFile);

 // Эквалайзер
 EqForm.cbEqualizer.Checked:=GetIniBool('EQ', 'Enabled', false, IniFile);

 //
 if ParamCount=0 then
  begin
    AddFile((PlugDir+'\PlayLists\'+GetUserNameString+'.m3u'), true);
    CurTrack:=0;
  end;

 for i:=1 to ParamCount do
  begin
   // Открытие файла
   if FileExists( ParamStr(i) ) then
    begin
     AddFile(LowerCase(ParamStr(i)), true);
     CurTrack:=0;
    end
   else
    begin
    // Открытие папки
     if DirExists( ParamStr(i) ) then
      begin
       AddFolder(LowerCase(ParamStr(i)));
       CurTrack:=0;
      end
    end;
  end;

 if MyPlayList.Count>0 then
  begin
   OpenTrack(MyPlayList.GetFileName(CurTrack));
   Player.Play;
  end;

 SetButtonStates;

 PlayListForm.Visible:=not GetIniBool('PlayList', 'Visible', true, IniFile);
 PlayListBtn.Checked:=PlayListForm.Visible;
 ActionPlayList.Execute;

   // Построение фильтра
  ExtFile:=PlugDir+'\Extensions.lst';
 // ExtListBox.Clear;
  // Загрузка списка дополнительных расширений
  FilterAdd:='Plugins supported formats (';

  NumOfExt:=GetIniInt('ext', 'num', 0, 0, 1000, ExtFile);
  for i:=0 to NumOfExt do
   begin
     FilterAdd:=FilterAdd+GetIniString('ext', IntToStr(i), '', ExtFile);
     if i<>NumOfExt then FilterAdd:=FilterAdd+', ';
   end;

  FilterAdd:=FilterAdd+')|';
  for i:=0 to NumOfExt do
   begin
     FilterAdd:=FilterAdd+'*.'+GetIniString('ext', IntToStr(i), '', ExtFile)+';';
   end;

   OpenDialog.Filter:=OpenDialog.Filter+'|'+FilterAdd;

end;


// Загрузка скина
procedure TAmpViewMainForm.LoadSkin(const FileName: string);
const
 DF='#000000|Arial|8|nnnn';
var
 WindowRgn: HRGN;
 path: string;
 h,w: integer;
 FN: string;
 SF: boolean;
 rlr: string;
 tnrml: string;
 tprsd: string;
begin
 // Распаковка файлов скина
 FN:=FileName;
 if not FileExists(FN) then
  begin
   ActionClose.Execute;
  end;
 try
  DecompressFile(FN, GetTempDir+'AmpViewSkin', true);
  FN:=GetTempDir+'AmpViewSkin\Skin.ini';
 except
  ErrorMessage('Unable to load skin!');
  ActionClose.Execute;
 end;
 //
 try
 if NewFileExists(FN) then
  begin
   path:=ExtractFilePath(FN);
   SF:=SmallFonts;

   MainImage.Left:=0;
   MainImage.Top:=0;
   MainPicture:=TBitmap32.Create;
   MainPicture.LoadFromFile(Path+GetIniString('MainImage', 'pic', 'main.png', FN));
   MainImage.Bitmap:=MainPicture;

   SkinText.Name:=GetIniString('info', 'name', 'unknow', FN);
   SkinText.Description :=GetIniString('info', 'desc', 'none', FN);
   SkinText.Author:=GetIniString('info', 'author', 'unknow', FN);
   SkinText.Email:=GetIniString('info', 'email', '', FN);
   SkinText.HomePage:=GetIniString('info', 'homepage', '', FN);
  // iiei?aiea e ?acia?u ieia
   W:=MainImage.Bitmap.Width;
   H:=MainImage.Bitmap.Height;
   Width:=w;
   Height:=h;

   MainImage.AutoSize:=true;

  // I?ic?a?iinou
  SetWindowRgn(Handle, 0, True);
  if GetIniBool('MainImage', 'Transparent', false, FN) then
   begin
    TransparentColorValue:=HexToInt(GetIniString('MainImage', 'TransparentColor', '#FFFFFF', FN));
    if DetectWinVersion=wvXP
     then TransparentColor:=true
     else
      begin
       TransparentColor:=false;       
       windowRgn := BitmapToRgn(MainPicture, TransparentColorValue);
       SetWindowRgn(Handle, WindowRgn, True);
      end;
   end;

  // eiiiea Play
   PlayBtn.Visible:=GetIniBool('PlayButton', 'visible', false, FN);
   if PlayBtn.Visible=true then
    with PlayBtn do
     begin
      Left:=GetIniInt('PlayButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('PlayButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('PlayButton', 'InactiveImage', 'PlayBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('PlayButton', 'PushedImage', 'PlayBtnPushed.png', FN));
      LoadUsedButton(Path+GetIniString('PlayButton', 'UsedImage', 'PlayBtnUsed.png', FN));
      DrawButton;
     end;

   // eiiiea Pause
   PauseBtn.Visible:=GetIniBool('PauseButton', 'visible', false, FN);
   if PauseBtn.Visible=true then
    with PauseBtn do
     begin
      Left:=GetIniInt('PauseButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('PauseButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('PauseButton', 'InactiveImage', 'PauseBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('PauseButton', 'PushedImage', 'PauseBtnPushed.png', FN));
      LoadUsedButton(Path+GetIniString('PauseButton', 'UsedImage', 'PauseBtnUsed.png', FN));
      DrawButton;
     end;

(*
  SkinLayers:=TLayerCollection.Create(AmpViewMainForm);

  PB:=TBitmapLayer.Create(MainImage.Layers);
  PB.Tag:=0;

  PB.Bitmap.LoadFromFile(Path+GetIniString('PauseButton', 'InactiveImage', 'PauseBtnInactive.png', FN));

  PB.Location:=FloatRect(5, 5, 5+PauseBtn.Height, 5+PauseBtn.Width);
//  PB.Location.Right:=5+
*)

   // eiiiea Stop
   StopBtn.Visible:=GetIniBool('StopButton', 'visible', false, FN);
   if StopBtn.Visible=true then
    with StopBtn do
     begin
      Left:=GetIniInt('StopButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('StopButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('StopButton', 'InactiveImage', 'StopBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('StopButton', 'PushedImage', 'StopBtnPushed.png', FN));
      LoadUsedButton(Path+GetIniString('StopButton', 'UsedImage', 'StopBtnUsed.png', FN));
      DrawButton;
     end;

  // eiiiea Prev
   PrevBtn.Visible:=GetIniBool('PrevButton', 'visible', false, FN);
   if PrevBtn.Visible=true then
    with PrevBtn do
     begin
      Left:=GetIniInt('PrevButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('PrevButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('PrevButton', 'InactiveImage', 'PrevBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('PrevButton', 'PushedImage', 'PrevBtnPushed.png', FN));
      DrawButton;
     end;
  // eiiiea Next
   NextBtn.Visible:=GetIniBool('NextButton', 'visible', false, FN);
   if NextBtn.Visible=true then
    with NextBtn do
     begin
      Left:=GetIniInt('NextButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('NextButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('NextButton', 'InactiveImage', 'NextBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('NextButton', 'PushedImage', 'NextBtnPushed.png', FN));
      DrawButton;
     end;

  // eiiiea Mute
   MuteBtn.Visible:=GetIniBool('MuteButton', 'visible', false, FN);
   if MuteBtn.Visible=true then
    with MuteBtn do
     begin
      Left:=GetIniInt('MuteButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('MuteButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('MuteButton', 'InactiveImage', 'MuteBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('MuteButton', 'PushedImage', 'MuteBtnPushed.png', FN));
      LoadUsedButton(Path+GetIniString('MuteButton', 'UsedImage', 'MuteBtnUsed.png', FN));
      DrawButton;
    end;

  // Кнопка Close
   CloseBtn.Visible:=GetIniBool('CloseButton', 'visible', false, FN);
   if CloseBtn.Visible=true then
    with CloseBtn do
     begin
      Left:=GetIniInt('CloseButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('CloseButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('CloseButton', 'InactiveImage', 'CloseBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('CloseButton', 'PushedImage', 'CloseBtnPushed.png', FN));
      DrawButton;
     end;

  // eiiiea Minimize
   MinBtn.Visible:=GetIniBool('MinButton', 'visible', false, FN);
   if MinBtn.Visible=true then
    with MinBtn do
     begin
      Left:=GetIniInt('MinButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('MinButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('MinButton', 'InactiveImage', 'MinBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('MinButton', 'PushedImage', 'MinBtnPushed.png', FN));
      DrawButton;
     end;
  // eiiiea Open
   OpenBtn.Visible:=GetIniBool('OpenButton', 'visible', false, FN);
   if OpenBtn.Visible=true then
    with OpenBtn do
     begin
      Left:=GetIniInt('OpenButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('OpenButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('OpenButton', 'InactiveImage', 'OpenBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('OpenButton', 'PushedImage', 'OpenBtnPushed.png', FN));
      DrawButton;
    end;

  // eiiiea PlayList
   PlayListBtn.Visible:=GetIniBool('PlayListButton', 'visible', false, FN);
   if PlayListBtn.Visible=true then
    with PlayListBtn do
     begin
      Left:=GetIniInt('PlayListButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('PlayListButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('PlayListButton', 'InactiveImage', 'PlayListBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('PlayListButton', 'PushedImage', 'PlayListBtnPushed.png', FN));
      LoadUsedButton(Path+GetIniString('PlayListButton', 'UsedImage', 'PlayListBtnUsed.png', FN));
      DrawButton;
    end;

  // eiiiea Info
   InfoBtn.Visible:=GetIniBool('InfoButton', 'visible', false, FN);
   if InfoBtn.Visible=true then
    with InfoBtn do
     begin
      Left:=GetIniInt('InfoButton', 'left', 0,0,W, FN);
      Top:=GetIniInt('InfoButton', 'top', 0,0,H, FN);
      LoadInactiveButton(Path+GetIniString('InfoButton', 'InactiveImage', 'InfoBtnInactive.png', FN));
      LoadPushedButton(Path+GetIniString('InfoButton', 'PushedImage', 'InfoBtnPushed.png', FN));
      DrawButton;
    end;

  // Volume
   VolumeBar.Visible:=GetIniBool('Volume', 'visible', false, FN);
   if VolumeBar.Visible=true then
    with VolumeBar do
     begin
      Left:=GetIniInt('Volume', 'left', 0,0,W, FN);
      Top:=GetIniInt('Volume', 'top', 0,0,H, FN);
      rlr:=Path+GetIniString('Volume', 'RulerImage', 'VolumeRuler.png', FN);
      tnrml:=Path+GetIniString('Volume', 'ThumbNormal', 'VolumeThumbNormal.png', FN);
      tprsd:=Path+GetIniString('Volume', 'ThumbPressed', 'VolumeThumbPressed.png', FN);
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
     end;

  // ProgressBar
   ProgressBar.Visible:=GetIniBool('Progress', 'visible', false, FN);
   if ProgressBar.Visible=true then
    with ProgressBar do
     begin
      Left:=GetIniInt('Progress', 'left', 0,0,W, FN);
      Top:=GetIniInt('Progress', 'top', 0,0,H, FN);
      rlr:=Path+GetIniString('Progress', 'RulerImage', 'ScrollRuler.png', FN);
      tnrml:=Path+GetIniString('Progress', 'ThumbNormal', 'ScrollThumbNormal.png', FN);
      tprsd:=Path+GetIniString('Progress', 'ThumbPressed', 'ScrollThumbPressed.png', FN);
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Position:=Player.Position;
     end;

  // BitRate
   SkinText.BitRateVisible:=GetIniBool('BitRate', 'visible', false, FN);
   if SkinText.BitRateVisible=true then
    begin
     SkinText.BitRateFont:=TFont.Create;
     StrToFont( GetIniString('BitRate', 'Font', DF, FN), SkinText.BitRateFont);
     SkinText.BitRateLeft:=GetIniInt('BitRate', 'left', 0,0,W, FN);
     SkinText.BitRateTop:=GetIniInt('BitRate', 'top', 0,0,H, FN);
     SkinText.BitRateShadow:=GetIniBool('BitRate', 'shadow', false, FN);
     if not SF then SkinText.BitRateFont.Size:=(SkinText.BitRateFont.Size * 90) div 100;
    end;

  // SPS
   SkinText.SPSVisible:=GetIniBool('SPS', 'visible', false, FN);
   if SkinText.SPSVisible=true then
    begin
     SkinText.SPSFont:=TFont.Create;
     StrToFont( GetIniString('SPS', 'Font', DF, FN), SkinText.SPSFont);
     SkinText.SPSLeft:=GetIniInt('SPS', 'left', 0,0,W, FN);
     SkinText.SPSTop:=GetIniInt('SPS', 'top', 0,0,H, FN);
     SkinText.SPSShadow:=GetIniBool('SPS', 'shadow', false, FN);
     if not SF then SkinText.SPSFont.Size:=(SkinText.SPSFont.Size * 90) div 100;
    end;

  // Channel Mode
   SkinText.ChannelVisible:=GetIniBool('ChannelMode', 'visible', false, FN);
   if SkinText.ChannelVisible=true then
    begin
     SkinText.ChannelFont:=TFont.Create;
     StrToFont( GetIniString('ChannelMode', 'Font', DF, FN), SkinText.ChannelFont);
     SkinText.ChannelLeft:=GetIniInt('ChannelMode', 'left', 0,0,W, FN);
     SkinText.ChannelTop:=GetIniInt('ChannelMode', 'top', 0,0,H, FN);
     SkinText.ChannelShadow:=GetIniBool('ChannelMode', 'shadow', false, FN);
     if not SF then SkinText.ChannelFont.Size:=(SkinText.ChannelFont.Size * 90) div 100;
    end;

  // TrackCaption
   SkinText.TrackCaptionVisible:=GetIniBool('TrackCaption', 'visible', false, FN);
   TrackCaptionImage.Visible:=SkinText.TrackCaptionVisible;
   if SkinText.TrackCaptionVisible=true then
    begin
//     TrackCaptionImage.Visible:=true;
     StrToFont( GetIniString('TrackCaption', 'Font', DF, FN), TrackCaptionImage.Bitmap.Font );
     SkinText.TrackCaptionShadow:=GetIniBool('TrackCaption', 'shadow', false, FN);
     if not SF then TrackCaptionImage.Bitmap.Font.Size:=(TrackCaptionImage.Bitmap.Font.Size * 90) div 100;

     SkinText.TrackCaptionOffset:=0;
     TrackCaptionImage.Left:=GetIniInt('TrackCaption', 'left', 0,0,W, FN);
     TrackCaptionImage.Top:=GetIniInt('TrackCaption', 'top', 0,0,H, FN);
     TrackCaptionImage.Width:=GetIniInt('TrackCaption', 'width', 0,0,800, FN);
     TrackCaptionImage.Height:=GetIniInt('TrackCaption', 'height', 0,0,800, FN);
     TrackCaptionImage.SetupBitmap;
    end;

  // TimerScreen
   SkinText.TimerVisible:=GetIniBool('Timer', 'visible', false, FN);
   TimerImage.Visible:=SkinText.TimerVisible;
     if SkinText.TimerVisible=true then
    begin
     StrToFont( GetIniString('Timer', 'Font', DF, FN), TimerImage.Bitmap.Font );
     SkinText.TimerShadow:=GetIniBool('Timer', 'shadow', false, FN);

     TimerImage.Left:=GetIniInt('Timer', 'left', 0,0,W, FN);
     TimerImage.Top:=GetIniInt('Timer', 'top', 0,0,H, FN);
     TimerImage.Width:=GetIniInt('Timer', 'width', 0,0,800, FN);
     TimerImage.Height:=GetIniInt('Timer', 'height', 0,0,800, FN);
     TimerImage.SetupBitmap;

     if not SF then TimerImage.Bitmap.Font.Size:=(TimerImage.Bitmap.Font.Size * 80) div 100;

     if GetIniBool('main', 'timeleftmode', false, IniFile)=false
      then DrawTimer(' '+'00:00')
      else DrawTimer('-'+'00:00');
    end;

   Path:=ExtractFilePath(FN)+'\EQ\';    

 with EqForm do
  begin

   if FileExists(Path+GetIniString('EQ', 'EQBackImage', 'EQBackImage.png', FN))
    then
     begin
      EqBackImage.Bitmap.LoadFromFile(Path+GetIniString('EQ', 'EQBackImage', 'EQBackImage.png', FN));

    // Полосы эквалайзера
    with EQ1 do
     begin
      rlr:=Path+GetIniString('EQ', 'RulerImage', 'EQRuler.png', FN);
      tnrml:=Path+GetIniString('EQ', 'ThumbNormal', 'EQThumbNormal.png', FN);
      tprsd:=Path+GetIniString('EQ', 'ThumbPressed', 'EQThumbPressed.png', FN);
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      EQ1.Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ2 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ3 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ4 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ5 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ6 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ7 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ8 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ9 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ0 do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EchoSlider do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with ReverbSlider do
     begin
      CreateProgress;
      LoadImages(rlr, tnrml, tprsd);
      Maximum:=30;
     end;

  //
   SetWindowRgn(EqForm.Handle, 0, True);
   if GetIniBool('MainImage', 'Transparent', false, FN) then
    begin
     TransparentColorValue:=HexToInt(GetIniString('MainImage', 'TransparentColor', '#FFFFFF', FN));
     if DetectWinVersion=wvXP
      then TransparentColor:=true
      else
       begin
        TransparentColor:=false;
        windowRgn := BitmapToRgn(EqBackImage.Bitmap, TransparentColorValue);
        SetWindowRgn(EqForm.Handle, WindowRgn, True);
       end;
    end;
  end;
  end;

   // Ieii nienea o?aeia (PlayList)
   with PlayListForm do
    begin
     Path:=ExtractFilePath(FN)+'\PlayList\';
//     Path:=Path+'\PlayList\';
     // ?enoiee aey iino?iaiey ieia
     with PLImages do
      begin
       // eaaay iaiaeu
       LeftTopImage:=TBitmap32.Create;
       LeftImage:=TBitmap32.Create;
       LeftBottomImage:=TBitmap32.Create;
       LeftTopImage.LoadFromFile(Path+GetIniString('PlayList', 'LeftTop', 'LeftTop.png', FN));
       LeftImage.LoadFromFile(Path+GetIniString('PlayList', 'Left', 'Left.png', FN));
       LeftBottomImage.LoadFromFile(Path+GetIniString('PlayList', 'LeftBottom', 'LeftBottom.png', FN));
       // i?aaay iaiaeu
       RightTopImage:=TBitmap32.Create;
       RightImage:=TBitmap32.Create;
       RightBottomImage:=TBitmap32.Create;
       RightTopImage.LoadFromFile(Path+GetIniString('PlayList', 'RightTop', 'RightTop.png', FN));
       RightImage.LoadFromFile(Path+GetIniString('PlayList', 'Right', 'Right.png', FN));
       RightBottomImage.LoadFromFile(Path+GetIniString('PlayList', 'RightBottom', 'RightBottom.png', FN));
       // aa?oiyy iaiaeu
       TopImage:=TBitmap32.Create;
       TopImage.LoadFromFile(Path+GetIniString('PlayList', 'Top', 'Top.png', FN));
       // ie?iyy iaiaeu
       BottomImage:=TBitmap32.Create;
       BottomImage.LoadFromFile(Path+GetIniString('PlayList', 'Bottom', 'Bottom.png', FN));
       // Play-list
       LeftOffset:=GetIniInt('PlayList', 'LeftOffset', 5,1,100, FN);
       RightOffset:=GetIniInt('PlayList', 'RightOffset', 5,1,100, FN);
       TopOffset:=GetIniInt('PlayList', 'TopOffset', 5,1,100, FN);
       BottomOffset:=GetIniInt('PlayList', 'BottomOffset', 5,1,100, FN);
       // o?eoou
       ListOptions.Font:=TFont.Create;
       ListOptions.SelectedFont:=TFont.Create;
       ListOptions.PlayedFont:=TFont.Create;
       ListOptions.SelectedPlayedFont:=TFont.Create;
       StrToFont( GetIniString('PlayList', 'Font', DF, FN), ListOptions.Font );
       StrToFont( GetIniString('PlayList', 'SelFont', DF, FN), ListOptions.SelectedFont );
       StrToFont( GetIniString('PlayList', 'PlayFont', DF, FN), ListOptions.PlayedFont );
       StrToFont( GetIniString('PlayList', 'SelPlayFont', DF, FN), ListOptions.SelectedPlayedFont );
       // oaaoa
       ListOptions.BackColor1:=HexToInt(GetIniString('PlayList', 'BackColor', '0', FN));
       ListOptions.BackColor2:=HexToInt(GetIniString('PlayList', 'BackColor2', GetIniString('PlayList', 'BackColor', '0', FN), FN));
       ListOptions.SelectedBackColor:=HexToInt(GetIniString('PlayList', 'SelBackColor', '#FFFFFF', FN));
       ListOptions.SelectedPlayedBackColor:=HexToInt(GetIniString('PlayList', 'SelPlayBackColor', '#FFFFFF', FN));
       PlayList.Color:=ListOptions.BackColor1;

       // Кнопка Close
       PLCloseBtn.Visible:=GetIniBool('PLCloseButton', 'visible', false, FN);
       if PLCloseBtn.Visible=true then
       with PLCloseBtn do
       begin
        Tag:=GetIniInt('PLCloseButton', 'RightOffset', 0,0,W, FN);
        Top:=GetIniInt('PLCloseButton', 'TopOffset', 0,0,H, FN);
        LoadInactiveButton(Path+GetIniString('PLCloseButton', 'InactiveImage', 'CloseBtnInactive.png', FN));
        LoadPushedButton(Path+GetIniString('PLCloseButton', 'PushedImage', 'CloseBtnPushed.png', FN));
        DrawButton;
       end;

      end;
      // ia?a?eniaea
      PlayList.Repaint;
      RedrawPlayList;
    end;
   end;

 DrawInfo;
 SetButtonStates;
 PlayListForm.Left:=Left;
 PlayListForm.Top:=Top+Height;
 PlayListForm.DrawWindow;
 PlayListForm.RedrawPlayList;

 //
 RemoveDir( GetTempDir+'AmpViewSkin' );
 except
  ActionClose.Execute;
 end;
end;


// Загрузка языка из файла
procedure TAmpViewMainForm.LoadLang(const FileName: string);
begin
 try
  // Подсказки
  PlayBtn.Hint:=GetIniString('Hints', 'ButtonPlay', 'Play', FileName);
  PauseBtn.Hint:=GetIniString('Hints', 'ButtonPause', 'Pause', FileName);
  StopBtn.Hint:=GetIniString('Hints', 'ButtonStop', 'Stop', FileName);
  MuteBtn.Hint:=GetIniString('Hints', 'ButtonMute', 'Mute', FileName);
  MinBtn.Hint:=GetIniString('Hints', 'ButtonMinimize', 'Minimize', FileName);
  CloseBtn.Hint:=GetIniString('Hints', 'ButtonClose', 'Close', FileName);
  NextBtn.Hint:=GetIniString('Hints', 'ButtonNext', 'Nextr track', FileName);
  PrevBtn.Hint:=GetIniString('Hints', 'ButtonPrevious', 'Previous track', FileName);
  OpenBtn.Hint:=GetIniString('Hints', 'ButtonOpen', 'Open files', FileName);
  PlayListBtn.Hint:=GetIniString('Hints', 'ButtonPlayList', 'Show/Hide Playlist', FileName);
  InfoBtn.Hint:=GetIniString('Hints', 'ButtonInfo', 'File info', FileName);

  // Меню
  ItemAbout.Caption:=GetIniString('Menus', 'ItemAbout', 'About', FileName);
  ItemOptions.Caption:=GetIniString('Menus', 'ItemOptions', 'Options', FileName);
//  ItemOptionsMenu.Caption:=ItemOptions.Caption;
  ItemClose.Caption:=GetIniString('Menus', 'ItemClose', 'Close', FileName);
  ItemTopMost.Caption:=GetIniString('Menus', 'ItemTopMost', 'Stay on Top', FileName);
  ItemTimeMode.Caption:=GetIniString('Menus', 'ItemTimeMode', 'Time left mode', FileName);
  ItemControlMenu.Caption:=GetIniString('Menus', 'ItemControl', 'Control', FileName);
  ItemPlay.Caption:=PlayBtn.Hint;
  ItemPause.Caption:=PauseBtn.Hint;
  ItemStop.Caption:=StopBtn.Hint;
  ItemVolumeUp.Caption:=GetIniString('Menus', 'ItemVolumeUp', 'Volume Up', FileName);
  ItemVolumeDown.Caption:=GetIniString('Menus', 'ItemVolumeDown', 'Volume Down', FileName);
  ItemNextTrack.Caption:=NextBtn.Hint;
  ItemPrevTrack.Caption:=PrevBtn.Hint;
  ItemNextFile.Caption:=GetIniString('Menus', 'ItemNextFile', 'Next file from current folder', FileName);
  //
  with PlayListForm do
   begin
    ItemFileInfo.Caption:=GetIniString('Menus', 'ItemFileInfo', 'File info...', FileName);
    ItemView.Caption:=GetIniString('Menus', 'ItemView', 'View', FileName);

    ItemShuffle.Caption:=GetIniString('Menus', 'ItemShuffle', 'Shuffle', FileName);
    ItemDeleteTrack.Caption:=GetIniString('Menus', 'ItemDeleteTrack', 'Delete track', FileName);
    ItemDeleteFile.Caption:=GetIniString('Menus', 'ItemDeleteFile', 'Delete file', FileName);

    ItemSort.Caption:=GetIniString('Menus', 'ItemSort', 'Sort tracks', FileName);
    ItemSortByLength.Caption:=GetIniString('Menus', 'ItemSortByLength', 'by length', FileName);
    ItemSortByFileName.Caption:=GetIniString('Menus', 'ItemSortByFileName', 'by filename', FileName);
    ItemSortByTitle.Caption:=GetIniString('Menus', 'ItemSortByTitle', 'by title', FileName);

    ItemSavePlayList.Caption:=GetIniString('Menus', 'ItemSavePlayList', 'Save Playlist...', FileName);

    ShowFullNameItem.Caption:=GetIniString('Menus', 'ItemShowFullNames', 'Show full names', FileName);
    ShowFileNamesItem.Caption:=GetIniString('Menus', 'ItemShowFileNames', 'Show file-names', FileName);
    ShowTrackCaptionItem.Caption:=GetIniString('Menus', 'ItemTrackCaptions', 'Show track captions', FileName);
    ShowNumbersItem.Caption:=GetIniString('Menus', 'ItemShowNumbers', 'Show numbers', FileName);
    ShowTracksLength.Caption:=GetIniString('Menus', 'ItemShowTrackLength', 'Show track length', FileName);
    PLCloseBtn.Hint:=CloseBtn.Hint;
   end;
  // Меню в трее
  TrayItemClose.Caption:=ItemClose.Caption;
  TrayItemPlay.Caption:=PlayBtn.Hint;
  TrayItemPause.Caption:=PauseBtn.Hint;
  TrayItemStop.Caption:=StopBtn.Hint;
  TrayItemRestore.Caption:=GetIniString('Menus', 'ItemRestore', 'Restore window', FileName);
  TrayItemNextTrack.Caption:=GetIniString('Menus', 'ItemNextTrack', 'Next track', FileName);
  TrayItemPreviousTtrack.Caption:=GetIniString('Menus', 'ItemPrevTrack', 'Previous track', FileName);
  TrayItemOptions.Caption:=ItemOptions.Caption;
  // Окно опций
  with OptionsForm do
   begin
    // Заголовок
    OptionsForm.Caption:=ItemOptions.Caption;
    // Надписи
    TranslatorLabel.Caption:=GetIniString('Main', 'translator', '???', FileName);
    TranslatorEmailLabel.Caption:=GetIniString('Main', 'mail', '', FileName);
    // Группы (GroupBox)
    LanguageBox.Caption:=GetIniString('Options', 'BoxLanguage', 'Language', FileName);
    TranslatorBox.Caption:=GetIniString('Options', 'BoxTranslator', 'Translator', FileName);
    EffectsBox.Caption:=GetIniString('Options', 'BoxEffects', 'Effects', FileName);
    RewindStepBox.Caption:=GetIniString('Options', 'BoxRewindStep', 'Step of rewind (seconds)', FileName);
    InformationBox.Caption:=GetIniString('Options', 'BoxInformation', 'Information', FileName);
    SkinBox.Caption:=GetIniString('Options', 'BoxSkin', 'Skin', FileName);
    OnEndTrackBox.Caption:=GetIniString('Options', 'BoxOnEndTrack', 'On end of a track', FileName);
    PluginsBox.Caption:=GetIniString('Options', 'BoxPlugins', 'Available Plugins', FileName);
    FontBox.Caption:=GetIniString('Options', 'BoxFont', 'Font', FileName);
    SampleBox.Caption:=GetIniString('Options', 'BoxSample', 'Sample', FileName);
    HotKeyGroupBox.Caption:=GetIniString('Options', 'PageInternalHotKeys', 'Internal HotKeys', FileName);
    GlobalBox.Caption:=GetIniString('Options', 'PageGlobalHotKeys', 'Global HotKeys', FileName);
    PressKeyBox1.Caption:=GetIniString('Options', 'BoxPressKey', 'Press key or keys combination', FileName);
    PressKeyBox2.Caption:=PressKeyBox1.Caption;
    MouseBox.Caption:=GetIniString('Options', 'PageMouse', 'Mouse', FileName);
    FormatTrackBox.Caption:=GetIniString('Options', 'BoxFormatTrackCaption', 'Format of track''s captions', FileName);
    OtherGroupBox.Caption:=GetIniString('Options', 'TreeItemOther', 'Other', FileName);
    ExtGroupBox.Caption:=GetIniString('Options', 'BoxExtensions', 'Extensions', FileName);
    ConfigGroupBox.Caption:=GetIniString('Options', 'BoxConfig', 'Configuration', FileName);    
    // Надписи (Label)
    LabelSelectLanguage.Caption:=GetIniString('Options', 'LabelSelectLanguage', 'Select language from list:', FileName);
    // Флажки (CheckBox)
    UseShadows.Caption:=GetIniString('Options', 'CheckBoxUseShadows', 'To resolve display of shadows', FileName);
    UseAntiAliasing.Caption:=GetIniString('Options', 'CheckBoxUseAntiAliasing', 'To resolve use of AntiAliasing', FileName);
    IgnoreSkinFontCheckBox.Caption:=GetIniString('Options', 'CheckBoxIgnoreSkinFont', 'Ignore skin font', FileName);
    NotQVCheckBox.Caption:=GetIniString('Options', 'CheckBoxNotQV', 'Not use AmpView for QuickView', FileName)+'   [Ctrl+Q]';
    NotNVCheckBox.Caption:=GetIniString('Options', 'CheckBoxNotNV', 'Not use AmpView for Normal View', FileName)+'   [F3]';
    UseControl.Caption:=GetIniString('Options', 'CheckBoxUseControl', 'Change Volume with mouse well only if [Ctrl] key pressed', FileName);
    WarningCheckBox.Caption:=GetIniString('Options', 'CheckBoxWarning', 'Show warnings of the files deleting', FileName);
    DefaultConfigCheckBox.Caption:=GetIniString('Options', 'CheckBoxDefaultConfig', 'Use only default configuration file for all users', FileName);    
    // Дерево
    OptionsList.Items[0]:=GetIniString('Options', 'TreeItemInterface', 'Interface', FileName);
    OptionsList.Items[1]:=GetIniString('Options', 'TreeItemPlugins', 'Plugins', FileName);
    OptionsList.Items[2]:=GetIniString('Options', 'TreeItemSkins', 'Skins', FileName);
    OptionsList.Items[3]:=GetIniString('Options', 'TreeItemControl', 'Control', FileName);
    OptionsList.Items[4]:=OtherGroupBox.Caption;
    OptionsList.Items[5]:=GetIniString('Options', 'TreeItemPlayList', 'PlayList', FileName);
    // Кнопки (Buttons)
    CloseButton.Caption:=GetIniString('Options', 'ButtonClose', 'Close', FileName);
    AddBtn.Caption:=GetIniString('Options', 'ButtonAdd', 'Add', FileName);
    DeleteBtn.Caption:=GetIniString('Options', 'ButtonDelete', 'Delete', FileName);        
    // Список
    OnEndTrackBox.Items[0]:=GetIniString('Options', 'OnEndActionStop', 'Stop track', FileName);
    OnEndTrackBox.Items[1]:=GetIniString('Options', 'OnEndActionNext', 'Open next track from list', FileName);
    OnEndTrackBox.Items[2]:=GetIniString('Options', 'OnEndActionClose', 'Close AmpView', FileName);
    OnEndTrackBox.Items[3]:=GetIniString('Options', 'OnEndActionRestart', 'Restart current track', FileName);
    OnEndTrackBox.Items[4]:=GetIniString('Options', 'OnEndActionNextFile', 'Open next file from folder', FileName);
    // Страницы
    SkinPages.Pages[0].Caption:= OptionsList.Items[2];
    SkinPages.Pages[1].Caption:= GetIniString('Options', 'PagePlayList', 'PlayList', FileName);
    HotKeysPages.Pages[0].Caption:=HotKeyGroupBox.Caption;
    HotKeysPages.Pages[1].Caption:=GlobalBox.Caption;
    HotKeysPages.Pages[2].Caption:=MouseBox.Caption;
   end;
 except
 end;
end;


procedure TAmpViewMainForm.LoadHotKeys(const FileName: string);
var
  Modifiers, Key: Word;
  DefKey: integer;
begin
  // Play
  DefKey:=TextToHotKey('X', true);
  ActionPlay.ShortCut:=GetIniInt('main', 'Play', DefKey, 0, MaxInt, FileName);

  // Stop
  DefKey:=TextToHotKey('V', true);
  ActionStop.ShortCut:=GetIniInt('main', 'Stop', DefKey, 0, MaxInt, FileName);

  // Pause
  DefKey:=TextToHotKey('C', true);
  ActionPause.ShortCut:=GetIniInt('main', 'Pause', DefKey, 0, MaxInt, FileName);

  // Volume Up
  DefKey:=TextToHotKey('Num +', true);
  ActionVolumeUp.ShortCut:=GetIniInt('main', 'VolumeUp', DefKey, 0, MaxInt, FileName);

  // Volume Down
  DefKey:=TextToHotKey('Num -', true);
  ActionVolumeDown.ShortCut:=GetIniInt('main', 'VolumeDown', DefKey, 0, MaxInt, FileName);

  // Mute
  DefKey:=TextToHotKey('M', true);
  ActionMute.ShortCut:=GetIniInt('main', 'Mute', DefKey, 0, MaxInt, FileName);

  //-
//  ActionRewind.ShortCut:=GetIniInt('main', 'Rewind', 39, 0, MaxInt, FileName);
//  ActionForward.ShortCut:=GetIniInt('main', 'Forward', 41, 0, MaxInt, FileName);

  // Open
  DefKey:=TextToHotKey('O', true);
  ActionOpen.ShortCut:=GetIniInt('main', 'Open', DefKey, 0, MaxInt, KeysFile);

  // Open folder
  DefKey:=TextToHotKey('Ctrl+O', true);
  ActionOpenFolder.ShortCut:=GetIniInt('main', 'OpenFolder', DefKey, 0, MaxInt, KeysFile);

  // Next track
  DefKey:=TextToHotKey('B', true);
  ActionNextTrack.ShortCut:=GetIniInt('main', 'NextTrack', DefKey, 0, MaxInt, FileName);

  // Previous track
  DefKey:=TextToHotKey('Z', true);
  ActionPrevTrack.ShortCut:=GetIniInt('main', 'PrevTrack', DefKey, 0, MaxInt, FileName);

  // NextFile
  DefKey:=TextToHotKey('Ctrl+B', true);
  ActionGetNextFile.ShortCut:=GetIniInt('main', 'NextFile', DefKey, 0, MaxInt, FileName);

  // Left Time  Mode
  DefKey:=TextToHotKey('Ctrl+T', true);
  ActionTimeLeftMode.ShortCut:=GetIniInt('main', 'TimeLeftMode', DefKey, 0, MaxInt, FileName);

  // Top most
  DefKey:=TextToHotKey('Ctrl+E', true);
  ActionTopMost.ShortCut:=GetIniInt('main', 'TopMost', DefKey, 0, MaxInt, FileName);

  // Option
  DefKey:=TextToHotKey('Ctrl+P', true);
  ActionOptions.ShortCut:=GetIniInt('main', 'Options', DefKey, 0, MaxInt, FileName);

  // File info
  DefKey:=TextToHotKey('Alt+3', true);
  ActionFileInfo.ShortCut:=GetIniInt('main', 'FileInfo', DefKey, 0, MaxInt, FileName);

  // PlayList
  DefKey:=TextToHotKey('Alt+E', true);
  ActionPlayList.ShortCut:=GetIniInt('main', 'PlayList', DefKey, 0, MaxInt, FileName);

  // Minimize
  DefKey:=TextToHotKey('Alt+M', true);
  ActionMinimizeToTray.ShortCut:=GetIniInt('main', 'Minimize', DefKey, 0, MaxInt, FileName);


  // Глобальные горячие клавиши

  // "Play"
  SeparateHotKey(GetIniInt('global', 'Play', 0, 0, MaxInt, FileName), Modifiers, Key);
  PlayGlobal := GlobalAddAtom('PlayGlobal');
  RegisterHotKey(Handle, PlayGlobal, Modifiers, Key);
  TrayItemPlay.ShortCut:=GetIniInt('global', 'Play', 0, 0, MaxInt, FileName);

  // "Stop"
  SeparateHotKey(GetIniInt('global', 'Stop', 0, 0, 0, FileName), Modifiers, Key);
  StopGlobal := GlobalAddAtom('StopGlobal');
  RegisterHotKey(Handle, StopGlobal, Modifiers, Key);
  TrayItemStop.ShortCut:=GetIniInt('global', 'Stop', 0, 0, MaxInt, FileName);

  // "Pause"
  SeparateHotKey(GetIniInt('global', 'Pause', 0, 0, MaxInt, FileName), Modifiers, Key);
  PauseGlobal := GlobalAddAtom('PauseGlobal');
  RegisterHotKey(Handle, PauseGlobal, Modifiers, Key);
  TrayItemPause.ShortCut:=GetIniInt('global', 'Pause', 0, 0, MaxInt, FileName);

  // "Restore"
  SeparateHotKey(GetIniInt('global', 'Restore', 0, 0, MaxInt, FileName), Modifiers, Key);
  RestoreGlobal := GlobalAddAtom('RestoreGlobal');
  RegisterHotKey(Handle, RestoreGlobal, Modifiers, Key);
  TrayItemRestore.ShortCut:=GetIniInt('global', 'Restore', 0, 0, MaxInt, FileName);

  // "Mute"
  SeparateHotKey(GetIniInt('global', 'Mute', 0, 0, MaxInt, FileName), Modifiers, Key);
  MuteGlobal := GlobalAddAtom('MuteGlobal');
  RegisterHotKey(Handle, MuteGlobal, Modifiers, Key);
//  TrayItemMute.ShortCut:=GetIniInt('global', 'Mute', 32845, 0, MaxInt, FileName);

  // "VolumeUp"
  SeparateHotKey(GetIniInt('global', 'VolumeUp', 0, 0, MaxInt, FileName), Modifiers, Key);
  VolumeUpGlobal := GlobalAddAtom('VolumeUp');
  RegisterHotKey(Handle, VolumeUpGlobal, Modifiers, Key);

  // "VolumeDown"
  SeparateHotKey(GetIniInt('global', 'VolumeDown', 0, 0, MaxInt, FileName), Modifiers, Key);
  VolumeDownGlobal := GlobalAddAtom('VolumeDown');
  RegisterHotKey(Handle, VolumeDownGlobal, Modifiers, Key);

  // "NextTrack"
  SeparateHotKey(GetIniInt('global', 'NextTrack', 0, 0, MaxInt, FileName), Modifiers, Key);
  NextTrackGlobal := GlobalAddAtom('NextTrack');
  RegisterHotKey(Handle, NextTrackGlobal, Modifiers, Key);
  TrayItemNextTrack.ShortCut:=GetIniInt('global', 'NextTrack', 0, 0, MaxInt, FileName);

  // "PrevTrack"
  SeparateHotKey(GetIniInt('global', 'PrevTrack', 0, 0, MaxInt, FileName), Modifiers, Key);
  PrevTrackGlobal := GlobalAddAtom('PrevTrack');
  RegisterHotKey(Handle, PrevTrackGlobal, Modifiers, Key);
  TrayItemPreviousTtrack.ShortCut:=GetIniInt('global', 'PrevTrack', 0, 0, MaxInt, FileName);

end;


procedure TAmpViewMainForm.SetTopMost(TopMost: boolean);
begin
 if TopMost
  // iiaa?o anao
  then
   begin
    SetWindowPos(PlayListForm.Handle, HWND_TOPMOST, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    SetWindowPos(AmpViewMainForm.Handle, HWND_TOPMOST, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
   end
  // iau?iue ii?yaie
  else
   begin
    SetWindowPos(PlayListForm.Handle, HWND_NOTOPMOST, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    SetWindowPos(AmpViewMainForm.Handle, HWND_NOTOPMOST, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
   end;
 // oeaa a iai?oea
 ActionTopMost.Checked:=TopMost;
end;


// Добавление трека в список
procedure TAmpViewMainForm.AddFile(const TrackFile: string; redraw: boolean);
var
 ext: string[5];
 i: integer;
 temp: integer;
 exist: boolean;
 FS: string;
begin
 exist:=false;
  // I?iaa?ea iaee?ey oaeea a nienea
  for i:=0 to MyPlayList.Count-1 do
   begin
    // anee oaee o?a anou
    if TrackFile=MyPlayList.GetFileName(i)
     then
      begin
       exist:=true;
       CurTrack:=i;
       Break;
      end;
   end;

  if exist then exit;

  ext:=ExtractFileExt(TrackFile);
  FS:=GetIniString('main', 'FormatString', '%ARTI - %TITL', IniFile);

  if (ext='.m3u') or (ext='m3u8')
   then
    begin
     MyPlayList.LoadM3U(TrackFile, false);
     for i:=0 to MyPlayList.Count-1 do
      begin
        MyPlayList.SetLength(i, Player.GetTrackLength(MyPlayList.GetFileName(i)));
      end;
    end
    else
     if (ext='.pls')
      then MyPlayList.LoadPLS(TrackFile, false)
      else MyPlayList.Add(TrackFile, Player.GetTrackCaption(TrackFile, FS), Player.GetTrackLength(TrackFile));

   if redraw then
    begin
     PlayListForm.PlayList.Clear;
//     ClearGrid();
//     PlayListForm.PlayList.Clear;
     temp:=MyPlayList.Count-1;
     with PlayListForm do
      begin
       for i:=0 to temp do
        begin
         PlayList.Items.Add;
         PlayList.Items[PlayList.Items.Count-1].SubItems.Add('');
         PlayList.Items[PlayList.Items.Count-1].SubItems.Add('');
//         InsertRow(PlayList, PlayList.RowCount);
         PlayList.Items[PlayList.Items.Count-1].SubItems[1]:=MyPlayList.GetText(i);
//         PlayList.Cells[1, PlayList.RowCount]:=

         //       PlayListForm.PlayList.Items.Add(MyPlayList.GetText(i));
        end;
       PlayList.Repaint;
       RedrawPlayList;
      end;
    end;

  CurTrack:=MyPlayList.Count-1;
end;



// Ioe?uoea o?aea
procedure TAmpViewMainForm.OpenTrack(const FileName: string);
var
 len: integer;
 FS: string;
begin
  with Player do
   begin
    if Player<>nil then
    Destroy;

    Player:=TBASSPlayerX.Create(Application.Handle, PlugDir);
    Player.OnPlayEnd:=GetPlayEnd;

    OpenFile(FileName);
    // Eioi?iaoey
    ProgressBar.Maximum:=Player.TrackLength div 100;

    FS:=GetIniString('main', 'FormatString', '%ARTI - %TITL', IniFile);
    SkinText.TrackCaption:=Player.GetTrackCaption(FileName, FS);

    MyPlayList.SetText(CurTrack, SkinText.TrackCaption);
    MyPlayList.SetLength(CurTrack, Player.GetTrackLength(FileName));
//    PlayListForm.PlayList.Perform(LB_SETTOPINDEX, Pred(CurTrack), 0);    

    SkinText.TrackCaption:=SkinText.TrackCaption+' ('+Player.GetFullTime+')';

    SkinText.BitRateCaption:= FileInfo.BitRate;
    SkinText.SPSCaption:=FileInfo.SampleRate;

    SkinText.ChannelCaption:=FileInfo.ChannelMode;
   end;

  DrawInfo;

  len:=GetTextWidth(TrackCaptionImage.Canvas.Handle, SkinText.TrackCaption, false);
  CaptionOffset:=(TrackCaptionImage.Width-len) div 2;
  DrawCaption(CaptionOffset);

  SetNewTrayHint(AmpViewMainForm.handle, AmpViewMainForm.Icon.Handle, PChar(SkinText.TrackCaption));

  SetVolume(VolumeBar.Position);

  SetButtonStates;

  WorkTimer.Enabled:=true;

  SetIniString('main', 'LastFolder', ExtractFilePath(FileName), IniFile);
end;



// Io?eniaea eiiiie
procedure TAmpViewMainForm.SetButtonStates;
begin
  PlayBtn.Checked:=(Player.Mode=pmPlayed);
  PauseBtn.Checked:=(Player.Mode=pmPaused);
  StopBtn.Checked:=(Player.Mode=pmStoped);
end;


// Aini?iecaaaaiea


// Io?eniaea oaenoa ia iniiaiii ieia
procedure TAmpViewMainForm.DrawText(x,y: integer; text: string; Font: TFont; DrawShadow: boolean);
begin
  // iiaaioiaea o?eooa
  MainImage.Bitmap.Font:=Font;
//  MainImage.Bitmap.Font.Style:=
  MainImage.Bitmap.Canvas.Brush.Style := bsClear;
  MainImage.Bitmap.UpdateFont;
  // Anee ?ac?aoaii eniieuciaaiea oaie
  if GetIniBool('main', 'UseShadows', false, IniFile) then
   begin
    // Anee iaioiaeii ?eniaaou oaiu
    if DrawShadow=true then
     begin
      // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
      if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
       then MainImage.Bitmap.RenderTextW(x+1, y+1, text, 3, Color32(clBlack))
//       else MainImage.Bitmap.RenderTextW(x+1, y+1, text, 0, Color32(clBlack));
       else
        begin
         MainImage.Bitmap.Canvas.Brush.Color:=clBlack;
         MainImage.Bitmap.Textout(x+1, y+1, text);
        end;
     end;
   end;
  // io?eniaea iniiaiiai oaenoa
  // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
  if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
   then MainImage.Bitmap.RenderTextW(x, y, text, 3, Color32(Font.Color))
//   else MainImage.Bitmap.RenderTextW(x, y, text, 0, Color32(Font.Color));
   else
    begin
     MainImage.Bitmap.Canvas.Brush.Color:=Font.Color;
     MainImage.Bitmap.Textout(x+1, y+1, text);
    end;
end;


// Io?eniaea anao eioi?iaoeiiiuo iaaienae
procedure TAmpViewMainForm.DrawInfo;
begin
  MainImage.Bitmap:=MainPicture;
  with SkinText do
   begin
    // Caaieiaie o?aea
    DrawCaption(0);
    if BitRateVisible
     then DrawText(BitRateLeft, BitRateTop, BitRateCaption, BitRateFont, BitRateShadow);
    // ChannelMode
    if ChannelVisible
     then DrawText(ChannelLeft, ChannelTop, ChannelCaption, ChannelFont, ChannelShadow);
    // SampleRate
    if SPSVisible
     then DrawText(SPSLeft, SPSTop, SPSCaption, SPSFont, SPSShadow);
   end;
end;


// Io?eniaea no?iee caaieiaea o?aea
procedure TAmpViewMainForm.DrawCaption(offset: integer);
var
 p1, p2: TPoint;
begin
  p1.X:=TrackCaptionImage.Left;
  p1.Y:=TrackCaptionImage.Top;
  p2.X:=TrackCaptionImage.Left+TrackCaptionImage.Width;
  p2.Y:=TrackCaptionImage.Top+TrackCaptionImage.Height;

  TrackCaptionImage.Bitmap.Draw(0, 0, MakeRect(p1.x, p1.y, p2.x,p2.y), MainPicture);
  with SkinText do
   begin
  // Anee ?ac?aoaii eniieuciaaiea oaie
  if GetIniBool('main', 'UseShadows', false, IniFile) then
   begin
    // Anee iaioiaeii ?eniaaou oaiu
    if TrackCaptionShadow=true then
     begin
      // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
      if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
       then TrackCaptionImage.Bitmap.RenderTextW(offset, 0, TrackCaption, 3, clBlack32)
       else
        begin
//         TrackCaptionImage.Bitmap.RenderText(offset, 0, TrackCaption, 0, clBlack32);
         TrackCaptionImage.Bitmap.Canvas.Brush.Color:=clBlack;
         TrackCaptionImage.Bitmap.TextOut(offset, 0, TrackCaption);
        end; 
     end;
   end;
  // io?eniaea iniiaiiai oaenoa
  // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
  if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
   then TrackCaptionImage.Bitmap.RenderTextW(offset, 0, TrackCaption, 3, Color32(TrackCaptionImage.Bitmap.Font.Color))
//   else TrackCaptionImage.Bitmap.RenderText(offset, 0, TrackCaption, 0, Color32(TrackCaptionImage.Bitmap.Font.Color));
   else
    begin
     TrackCaptionImage.Bitmap.Canvas.Brush.Color:=TrackCaptionImage.Bitmap.Font.Color;
     TrackCaptionImage.Bitmap.TextOut(offset, 0, TrackCaption);
    end;
  end;
  // Caaieiaie ieia
  Caption:=SkinText.TrackCaption;
  TrackCaptionImage.Hint:=SkinText.TrackCaption;
end;


procedure TAmpViewMainForm.SetVolume(VolumeLevel: integer);
begin
  SetIniInt('main', 'volume', VolumeLevel, IniFile);
  VolumeBar.Position:=VolumeLevel;

  Player.Volume:=VolumeLevel;
  MuteBtn.Checked:=false;
end;



procedure TAmpViewMainForm.GetNextTrack;
begin
 // Anee a nienea anaai 1 o?ae, oi auoiaei
 if MyPlayList.Count=1 then
  begin
   ActionStop.Execute;
   exit;
  end;

 // Anee oaeouee o?ae - iineaaiee, oi eaai e ia?aiio
 if CurTrack>=MyPlayList.Count-1
  then CurTrack:=0
  // eia?a - e neaao?uaio
  else CurTrack:=CurTrack+1;

  // Ioe?uaaai o?ae
  Player.Stop;
  OpenTrack(MyPlayList.GetFileName(CurTrack));
  PlayListForm.PlayList.ItemIndex:=CurTrack;
  Player.Play;
  PlayListForm.PlayList.Repaint;
  PlayListForm.RedrawPlayList;
  SetButtonStates;
end;


procedure TAmpViewMainForm.GetPrevTrack;
begin
 // Anee a nienea anaai 1 o?ae, oi auoiaei
 if MyPlayList.Count=1 then
  begin
   ActionStop.Execute;
   exit;
  end;
 // Anee oaeouee o?ae - ia?aue, oi eaai e iineaaiaio
 if CurTrack<=0
  then CurTrack:=MyPlayList.Count-1
  // eia?a - e i?aauaouaio
  else CurTrack:=CurTrack-1;

  // Ioe?uaaai o?ae
  Player.Stop;
  OpenTrack(MyPlayList.GetFileName(CurTrack));
  PlayListForm.PlayList.ItemIndex:=CurTrack;
  Player.Play;
  PlayListForm.PlayList.Repaint;
  PlayListForm.RedrawPlayList;
  SetButtonStates;
end;



//
procedure TAmpViewMainForm.GetNextFile;
var
 i: integer;
 Dir: string;
 fn: string;
 FilesList: TStringList;
 n: integer;
 exists: boolean;
begin
 FilesList:=TStringList.Create;

 dir:=ExtractFilePath(MyPlayList.GetFileName(CurTrack));
 // Neaie?iaaiea iaiee
 ScanDir(dir, FilesList);

  // Auae?aai neaao?uee
  for i:=0 to FilesList.Count-1 do
   begin
    if FilesList[i]=ExtractFileName(MyPlayList.GetFileName(CurTrack))
     then
      begin
       if i=FilesList.Count-1
        then n:=0
        else n:=i+1;
       fn:=dir+FilesList[n];
       break;
      end;
   end;


  // Iiaaioiaea e ioe?uoe?
  exists:=false;

  // I?iaa?ea iaee?ey oaeea a nienea
  for i:=0 to MyPlayList.Count-1 do
   begin
    // anee oaee o?a anou
    if fn=MyPlayList.GetFileName(i)
     then
      begin
       CurTrack:=i;
       exists:=true;
      end;
   end;

  // Ioe?uoea oaeea
  if FileExists(fn) then
   begin
    if not exists then
     begin
      AddFile(fn, true);
      CurTrack:=MyPlayList.Count-1;
     end;
    Player.Stop;
    OpenTrack(MyPlayList.GetFileName(CurTrack));
    Player.Play;
    SetButtonStates;
   end;
end;


///
procedure TAmpViewMainForm.WMTransfer(var Msg: TWMCopyData);
var
 i: Integer;
 FileName: string;
 CData: TCopyDataStruct;
 len: integer;
begin
 // I?eai aaiiuo
 CData:=Msg.CopyDataStruct^;
 FileName:='';
 len:=CData.cbData;
 for i:=0 to len-1 do
  begin
   FileName:=FileName+(PChar(CData.lpData)+i)^;
  end;

 // I?iaa?ea iaee?ey oaeea
 if (not FileExists(FileName)) then Exit;

 // Ioe?uoea iiaiai oaeea
 WorkTimer.Enabled:=false;

 Player.Stop;
 AddFile(FileName, true);

 OpenTrack(MyPlayList.GetFileName(CurTrack));
 Player.Play;

 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 SetButtonStates;
end;

procedure TAmpViewMainForm.DrawTimer(value: string);
var
 p1, p2: TPoint;
begin
  p1.X:=TimerImage.Left;
  p1.Y:=TimerImage.Top;
  p2.X:=TimerImage.Left+TimerImage.Width;
  p2.Y:=TimerImage.Top+TimerImage.Height;

  TimerImage.Bitmap.Draw(0, 0, MakeRect(p1.x, p1.Y, p2.X,p2.y), MainPicture);
  // Anee ?ac?aoaii eniieuciaaiea oaie
  if GetIniBool('main', 'UseShadows', false, IniFile) then
   begin
    // Anee iaiaoiaeii ?eniaaou oaiu
    if SkinText.TimerShadow then
     begin
      // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
      if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
       then TimerImage.Bitmap.RenderTextW(1, 1, value, 3, Color32(clBlack))
//       else TimerImage.Bitmap.RenderTextW(1, 1, value, 0, Color32(clBlack));
       else
        begin
         TimerImage.Bitmap.Canvas.Brush.Color:=clBlack;
         TimerImage.Bitmap.TextOut(1, 1, value);
        end;
     end;
   end;
  // ?enoai oaeno
  // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
   if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
    then TimerImage.Bitmap.RenderTextW(0, 0, value, 3, Color32(TimerImage.Bitmap.Font.Color))
//    else TimerImage.Bitmap.RenderText(0, 0,  value, 0, Color32(TimerImage.Bitmap.Font.Color));
    else
     begin
      TimerImage.Bitmap.Canvas.Brush.Color:=TimerImage.Bitmap.Font.Color;
      TimerImage.Bitmap.TextOut(1, 1, value);
     end; 
  //
end;


// Aiaaaeaiea iaiee e nieneo
procedure TAmpViewMainForm.AddFolder(const Path: string);
var
 i: integer;
 FilesList: TStringList;
 temp: integer;
begin
 FilesList:=TStringList.Create;
 ScanDir(Path+'\', FilesList);

 for i:=0 to FilesList.Count-1 do
  begin
   AddFile(Path+'\'+FilesList[i], false);
  end;

  PlayListForm.PlayList.Clear;
//  ClearGrid(PlayListForm.PlayList);
  temp:=MyPlayList.Count-1;
  with PlayListForm do
   begin
    for i:=0 to temp do
     begin
        PlayList.Items.Add;
        PlayList.Items[PlayList.Items.Count-1].SubItems.Add('');
        PlayList.Items[PlayList.Items.Count-1].SubItems.Add('');
//         InsertRow(PlayList, PlayList.RowCount);
//         PlayList.Items[PlayList.Items.Count-1].SubItems[1]:=MyPlayList.GetText(i);

//      InsertRow(PlayList, PlayList.RowCount);
//      PlayList.Cells[1, PlayList.RowCount]:=MyPlayList.GetText(i);

//      PlayList.Items.Add(MyPlayList.GetText(i));
     end;
    PlayList.Repaint;
    PlayListForm.RedrawPlayList;
  end;
end;


procedure TAmpViewMainForm.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  if DetectWinVersion=wvXP
   then Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;


procedure TAmpViewMainForm.WMHotkey(var msg: TWMHotkey);
begin
 if msg.hotkey=PlayGlobal then ActionPlay.Execute;
 if msg.hotkey=StopGlobal then ActionStop.Execute;
 if msg.hotkey=PauseGlobal then ActionPause.Execute;
 if msg.hotkey=RestoreGlobal then ActionRestoreFromTray.Execute;
 if msg.hotkey=MuteGlobal then ActionMute.Execute;
 if msg.hotkey=VolumeUpGlobal then ActionVolumeUp.Execute;
 if msg.hotkey=VolumeDownGlobal then ActionVolumeDown.Execute;
 if msg.hotkey=PrevTrackGlobal then ActionPrevTrack.Execute;
 if msg.hotkey=NextTrackGlobal then ActionNextTrack.Execute;
end;


procedure TAmpViewMainForm.ActionCloseExecute(Sender: TObject);
begin
  MyPlayList.SaveM3U(PlugDir+'\PlayLists\'+GetUserNameString+'.m3u');
  Player.Destroy;
  Close;
end;

procedure TAmpViewMainForm.ActionAboutExecute(Sender: TObject);
begin
//  Application.CreateForm(TAboutForm, AboutForm);
//  AboutForm.ShowModal;
 if not (PlayListForm.Visible) then ActionPlayList.Execute;
 PlayListForm.ShowAbout;
end;

procedure TAmpViewMainForm.ActionRewindExecute(Sender: TObject);
var
 step: cardinal;
 pos: cardinal;
begin
  step:=GetIniInt('main', 'ScrollStep', 5, 1,100, IniFile);
  pos:=((Player.Position div 100)-step*1000)*100;
  Player.Position:=pos;
  ProgressBar.Position:=Player.Position div 100;
end;

procedure TAmpViewMainForm.ActionForwardExecute(Sender: TObject);
var
 step: cardinal;
 pos: cardinal;
begin
  step:=GetIniInt('main', 'ScrollStep', 5, 1,100, IniFile);
  pos:=((Player.Position div 100)+step*1000)*100;
  Player.Position:=pos;
  ProgressBar.Position:=Player.Position div 100;
end;

procedure TAmpViewMainForm.ActionVolumeUpExecute(Sender: TObject);
var
 pos: integer;
begin
  pos:=VolumeBar.Position+10;
  if pos>=VolumeBar.Maximum then pos:=VolumeBar.Maximum;
  SetVolume(pos);
end;

procedure TAmpViewMainForm.ActionVolumeDownExecute(Sender: TObject);
var
 pos: integer;
begin
  pos:=VolumeBar.Position-10;
  if pos<=0 then pos:=1;
  SetVolume(pos);
end;

procedure TAmpViewMainForm.ActionFileInfoExecute(Sender: TObject);
//var
// FileName: string;
begin
// if MyPlayList.Count<=0 then exit;

// with PlayListForm do
//  begin
//   if (PlayList.ItemIndex>=0) and (PlayList.Focused)
//    then FileName:=MyPlayList.GetFileName(PlayList.ItemIndex)
//    else FileName:=MyPlayList.GetFileName(CurTrack);
//  end;

end;

procedure TAmpViewMainForm.ActionMuteExecute(Sender: TObject);
begin
  if MuteBtn.Checked
   then
    begin
     Player.UnMute;
     MuteBtn.Checked:=false;
    end
   else
    begin
     Player.Mute;
     MuteBtn.Checked:=true;
    end;
end;

procedure TAmpViewMainForm.ActionPlayExecute(Sender: TObject);
begin
 if Player.Mode=pmWaiting
  then ActionOpen.Execute
  else
   begin
    Player.Play;
    SetButtonStates;
   end;
end;

procedure TAmpViewMainForm.ActionStopExecute(Sender: TObject);
begin
 Player.Stop;

 ProgressBar.Position:=0;
 SetButtonStates;
end;

procedure TAmpViewMainForm.ActionPauseExecute(Sender: TObject);
begin
 if Player.Mode<>pmPaused
  then Player.Pause
  else Player.Play;

 SetButtonStates;
end;

procedure TAmpViewMainForm.ActionOptionsExecute(Sender: TObject);
begin
// Application.CreateForm(TOptionsForm, OptionsForm);
 OptionsForm.ShowModal;
end;

procedure TAmpViewMainForm.ActionTimeLeftModeExecute(Sender: TObject);
begin
  if GetIniBool('main', 'timeleftmode', false, IniFile)=false
   then
    begin
     SetIniBool('main', 'timeleftmode', true, IniFile);
     DrawTimer('-'+LenToTime(ProgressBar.Maximum-ProgressBar.Position));
    end
   else
    begin
     SetIniBool('main', 'timeleftmode', false, IniFile);
     DrawTimer(' '+LenToTime(ProgressBar.Position));
    end;
  ItemTimeMode.Checked:=GetIniBool('main', 'timeleftmode', false, IniFile);
end;

procedure TAmpViewMainForm.ActionTopMostExecute(Sender: TObject);
var
 TopMost: boolean;
begin
 TopMost:=ActionTopMost.Checked;
 SetIniBool('main', 'TopMost', not TopMost, IniFile);
 SetTopMost(not TopMost);
end;

procedure TAmpViewMainForm.ActionPlayListExecute(Sender: TObject);
begin
  PlayListForm.Visible:=not PlayListForm.Visible;
  SetIniBool('PlayList', 'Visible', PlayListForm.Visible, IniFile);
  PlayListForm.DrawWindow;
  PlayListForm.Left:=Left;
  PlayListForm.Top:=Top+Height;
  PlayListBtn.Checked:=PlayListForm.Visible;
  if not PlayListForm.Visible then PlayListForm.InfoBox.Visible:=false;
end;

procedure TAmpViewMainForm.ActionNextTrackExecute(Sender: TObject);
begin
 // Anee a nienea anaai 1 o?ae (eee ionoi)
 if MyPlayList.Count<=1 then
  begin
   if MyPlayList.Count<=0 then ActionStop.Execute;
   exit;
  end;
 if CtrlDown
  then GetNextFile
  else GetNextTrack;
 SetButtonStates;
end;

procedure TAmpViewMainForm.ActionPrevTrackExecute(Sender: TObject);
begin
 if MyPlayList.Count<=1 then
  begin
   if MyPlayList.Count<=0 then ActionStop.Execute;
   exit;
  end;

 GetPrevTrack;
 SetButtonStates;
end;

procedure TAmpViewMainForm.ActionGetNextFileExecute(Sender: TObject);
begin
 GetNextFile;
end;

procedure TAmpViewMainForm.ActionOpenExecute(Sender: TObject);
var
 i: integer;
begin
    OpenDialog.Execute;
    if OpenDialog.Files.Count<=0
     then exit
     else
      begin
       for i:=0 to OpenDialog.Files.Count-1 do
        begin
         if FileExists(OpenDialog.Files[i])
         then AddFile(OpenDialog.Files[i], true);
        end;
      end;
    PlayListBtn.Repaint;

    // Ioe?uoea oaeea
    Player.Stop;
    OpenTrack(MyPlayList.GetFileName(CurTrack));
    Player.Play;
    SetButtonStates;


end;

procedure TAmpViewMainForm.ActionMinimizeToTrayExecute(Sender: TObject);
begin
// Application.Minimize;
 WorkTimer.Enabled:=false;
 //
 AddTrayIcon(AmpViewMainForm.Handle, Application.Icon.Handle, PChar(SkinText.TrackCaption));
 //
 ShowAmpView(false);
end;

procedure TAmpViewMainForm.ActionRestoreFromTrayExecute(Sender: TObject);
begin
 if Player.Mode=pmPlayed then
  begin
   WorkTimerTimer(self);
   WorkTimer.Enabled:=true;
  end; 
// Application.Restore;
 ShowAmpView(true);

 with AmpViewMainForm do SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
 if PlayListBtn.Checked
  then
   with PlayListForm do SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);


 AmpViewMainForm.SetFocus;

end;

procedure TAmpViewMainForm.ActionCaseWindowExecute(Sender: TObject);
begin
  if AmpViewMainForm.Focused
   then PlayListForm.PlayList.SetFocus
   else AmpViewMainForm.SetFocus;
end;

procedure TAmpViewMainForm.WorkTimerTimer(Sender: TObject);
var
 time: string[6];
 Len: integer;
begin

  if (not ProgressBar.Pressed)
   then ProgressBar.Position:=Player.Position div 100
   else exit;
  time:=Player.GetTrackTime(GetIniBool('main', 'timeleftmode', false, IniFile));
  DrawTimer(time);
  //

  len:=GetTextWidth(TrackCaptionImage.Canvas.Handle, SkinText.TrackCaption, false);

  // Прокрутка заголовка
  if len<=TrackCaptionImage.Width then exit;

  if CaptionOffset<=(-len)
   then CaptionOffset:=len
   else CaptionOffset:=CaptionOffset-3;

  DrawCaption(CaptionOffset);
end;

procedure TAmpViewMainForm.TimerImageDblClick(Sender: TObject);
begin
  SetIniBool('main', 'timeleftmode', not GetIniBool('main', 'timeleftmode', false, IniFile), IniFile);
  if GetIniBool('main', 'timeleftmode', false, IniFile)=false
   then DrawTimer(' '+'00:00')
   else DrawTimer('-'+'00:00');
end;

procedure TAmpViewMainForm.MinBtnClick(Sender: TObject);
begin
  ActionMinimizeToTray.Execute;
end;

procedure TAmpViewMainForm.CloseBtnClick(Sender: TObject);
begin
  ActionClose.Execute;
end;

procedure TAmpViewMainForm.TrackCaptionImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  if Button = mbRight then
   begin
     MainPopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
   end;
end;


// Индикатор прогресса
procedure TAmpViewMainForm.ProgressBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if ProgressBar.Pressed then exit;
 Player.Position:=ProgressBar.Position*100;
end;
procedure TAmpViewMainForm.ProgressBarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
// if not ProgressBar.Pressed then exit;
 Player.Position:=ProgressBar.Position*100;
end;


// Регулятор громкости
procedure TAmpViewMainForm.VolumeBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if VolumeBar.Pressed then exit;
 SetVolume(VolumeBar.Position);
end;

procedure TAmpViewMainForm.VolumeBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if not VolumeBar.Pressed then exit;
 SetVolume(VolumeBar.Position);
end;

procedure TAmpViewMainForm.MainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if (Layer<>nil) and (Layer.Tag=0) then ErrorMessage('!!!');

  if Button <> mbRight then
   begin
    // Aee??aiai ?a?ei ia?aoaneeaaiey
    DragMode := true;
    x0 := x;
    y0 := y;
   end
  else
   begin
     MainPopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
   end;

end;

procedure TAmpViewMainForm.MainImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
    // Ia?aiauaai oi?io
  if DragMode = true then
  begin
   AmpViewMainForm.Left:=AmpViewMainForm.Left + X - X0;
   AmpViewMainForm.top:=AmpViewMainForm.top + Y - Y0;
   PlayListForm.Left:=Left;
   PlayListForm.Top:=Top+Height;
   SetIniInt('main', 'left', Left, IniFile);
   SetIniInt('main', 'top', Top, IniFile);
  end;

end;

procedure TAmpViewMainForm.MainImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 // Ioee??aai ?a?ei ia?aoaneeaaiey
  DragMode := false;
end;

procedure TAmpViewMainForm.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 if GetIniBool('main', 'UseControl', true, IniFile) then
  begin
   if CtrlDown then ActionVolumeDown.Execute;
  end
 else ActionVolumeDown.Execute;
end;

procedure TAmpViewMainForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
 if GetIniBool('main', 'UseControl', true, IniFile) then
  begin
   if CtrlDown then ActionVolumeUp.Execute;
  end
 else ActionVolumeUp.Execute;
end;

procedure TAmpViewMainForm.TimerImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  if not (Button <> mbRight)
   then MainPopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TAmpViewMainForm.TrackCaptionImageDblClick(Sender: TObject);
begin
  ActionFileInfo.Execute;
  mouse_event(MOUSEEVENTF_LEFTUP, 0,0, 0,0);
end;

procedure TAmpViewMainForm.ProgressBarMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
 time: string[6];
 left: boolean;
 pos: cardinal;
begin
 if not ProgressBar.Pressed then exit;
 pos:=ProgressBar.Position*100;

 left:=GetIniBool('main', 'timeleftmode', false, IniFile);

  if left
   then time:='-'+Player.BassLenToTime(Player.TrackLength-Pos)
   else time:=' '+Player.BassLenToTime(Pos);

  DrawTimer(time);
end;

procedure TAmpViewMainForm.OpenDialogClose(Sender: TObject);
begin
 if OpenDialog.Files.Count<=0 then exit;
end;

procedure TAmpViewMainForm.OpenDialogShow(Sender: TObject);
begin
 OpenDialog.InitialDir:=GetIniString('main', 'LastFolder', '', IniFile);
end;


procedure TAmpViewMainForm.GetPlayEnd;
begin
 case GetIniInt('main', 'OnEndAction', 1, 0, 4, IniFile) of
   0: ActionStop.Execute;
   1: GetNextTrack;
   2: ActionClose.Execute;
   3: ActionPlay.Execute;
   4: GetNextFile;
  end;
   SetButtonStates;
end;

procedure TAmpViewMainForm.WMTRAYICONNOTIFY(var Msg: TMessage);
begin
  case Msg.LParam of
//    WM_MOUSEMOVE:     s := 'Мышь сдвинута';
//    WM_MOUSEMOVE:  SetNewTrayHint(Handle, SkinText.TrackCaption );
//    WM_LBUTTONDOWN:   s := 'Левая кнопка нажата';
//    WM_LBUTTONUP:     s := 'Левая кнопка отпущена';
    WM_LBUTTONDBLCLK: ActionRestoreFromTray.Execute;
    WM_RBUTTONDOWN:   TrayPopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
//    WM_RBUTTONUP:     s := 'Правая кнопка отпущена';
//    WM_RBUTTONDBLCLK: s := 'Два раза нажата правая кнопка';
//    else              s := IntToStr(Msg.LParam);
  end;
//  ErrorMessage(s);
//  ListBox1.ItemIndex := ListBox1.Items.Count - 1;
end;

procedure TAmpViewMainForm.ShowAmpView(show: boolean);
var
 i, j: Integer;
begin
  if Show=false then
   begin
    Application.ShowMainForm := False;
    Application.Minimize;
    ShowWindow(Application.Handle, SW_HIDE);
    ShowWindow(Application.MainForm.Handle, SW_HIDE);
    ShowWindow(PlayListForm.Handle, SW_HIDE);
   end
  else
   begin
    Application.ShowMainForm := True;
    Application.Restore;
    ShowWindow(Application.Handle, SW_RESTORE);
    ShowWindow(Application.MainForm.Handle, SW_RESTORE);
    if GetIniBool('PlayList', 'Visible', true, IniFile)=true
     then ShowWindow(PlayListForm.Handle, SW_RESTORE);
    if not ShownOnce then
     begin
      for I := 0 to Application.MainForm.ComponentCount - 1 do
       if Application.MainForm.Components[I] is TWinControl then
        with Application.MainForm.Components[I] as TWinControl do
         if Visible then
          begin
           ShowWindow(Handle, SW_SHOWDEFAULT);
           for J := 0 to ComponentCount - 1 do
             if Components[J] is TWinControl then
               ShowWindow((Components[J] as TWinControl).Handle, SW_SHOWDEFAULT);
         end;
    ShownOnce := True;
  end;
 end;
end;


procedure TAmpViewMainForm.FormDestroy(Sender: TObject);
begin
  DeleteTrayIcon(AmpViewMainForm.Handle);
end;


// Установка поверх всех окон
procedure TAmpViewMainForm.WMDeactivate(var Msg: TMessage);
begin
 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
end;
procedure TAmpViewMainForm.WMActivate(var Msg: TMessage);
begin
 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
end;


procedure TAmpViewMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
 Application.Terminate; // ActionCloseExecute(self);
 Msg.Result:=1;
// inherited;
// ErrorMessage('Завершение работы');
//  Msg.Result := integer(not Memo1.Modified);
end;

procedure TAmpViewMainForm.FormPaint(Sender: TObject);
begin
 WorkTimer.Enabled:=true;
end;

procedure TAmpViewMainForm.ActionEQExecute(Sender: TObject);
begin
  EqForm.Parent:=AmpViewMainForm;
  EqForm.Left:=0;
  EqForm.Top:=MainImage.Height;
  EQForm.Visible:=not EQForm.Visible;
  SetIniBool('EQ', 'Visible', EQForm.Visible, IniFile);

  if EQForm.Visible
   then AmpViewMainForm.Height:=MainImage.Height+EqForm.Height
   else AmpViewMainForm.Height:=MainImage.Height;

   PlayListForm.Left:=Left;
   PlayListForm.Top:=Top+Height;
   
//  PlayListBtn.Checked:=PlayListForm.Visible;
end;


procedure TAmpViewMainForm.ActionOpenFolderExecute(Sender: TObject);
begin
  AddFolder(GetDir('Select directory:'));

  PlayListBtn.Repaint;

  // Ioe?uoea oaeea
  Player.Stop;
  OpenTrack(MyPlayList.GetFileName(CurTrack));
  Player.Play;
  SetButtonStates;
end;

end.
