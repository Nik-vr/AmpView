unit Viewer;

{$IF CompilerVersion >= 24.0 }
  {$LEGACYIFEND ON}
{$IFEND}

interface

uses Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms,
     XPMan, Menus, ExtCtrls, ActnList, GRButton32, StdCtrls,
     {$IF CompilerVersion <24}
       MyDialogs,
     {$ELSE}
       Dialogs,
     {$IFEND}
     MyTools, ProgressBar32, GR32, BASSPlayerX, PlayListClass, xIni,
     GR32_Layers, System.Actions, GR32_Image,
     {$IF CompilerVersion >= 24.0 }
       Vcl.Imaging.PNGImage,
     {$ELSE}
       PNGImage,
     {$IFEND}
     ZlibMultiple, SkinTypes, HotKeyTools,
     Dynamic_BASS, TrayTools, ShellAPI,
  ComCtrls;

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
    ActionSelectAll: TAction;
    hwHintTimer: TTimer;
    ActionDetach: TAction;
    ItemDetach: TMenuItem;
    N8: TMenuItem;
    ItemOpen: TMenuItem;
    ItemOpenFolder: TMenuItem;
    DelayedExecutionTimer: TTimer;
    ItemShufflePlay: TMenuItem;
    ActionShufflePlay: TAction;
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
    function IsEmbedded:boolean;
    function IsEmbeddedActive:boolean;
    procedure DoDeactivate;
    procedure PostMsgParent(msg:TMessage);
    function GetParentHandle:HWND;
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
    procedure VolumeBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ActionSelectAllExecute(Sender: TObject);
    procedure hwHintTimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionDetachExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionShufflePlayExecute(Sender: TObject);
  private
    DragMode: boolean;
    x0, y0: integer;
    ShownOnce: Boolean;
    PreventLoop: Boolean;
    procedure WMDeactivate(var Msg: TMessage); message WM_KILLFOCUS;
    procedure WMActivateApp(var Msg: TMessage); message WM_ACTIVATEAPP;
    procedure WMActivate(var Msg: TMessage); message WM_ACTIVATE;
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    procedure WMTransfer(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure WMTRAYICONNOTIFY(var Msg: TMessage); message WM_NOTIFYTRAYICON;
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure WMPreventLoop(var Msg: TMessage); message WM_USER + 101;
    procedure WMAttached(var Msg: TMessage); message WM_USER + 111;
    procedure WMDetached(var Msg: TMessage); message WM_USER + 112;
    procedure WMKeyDown(var Msg: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TMessage); message WM_KEYUP;
    //
    procedure DrawText(x, y: integer; text: string; Font: TFont; DrawShadow: boolean);
    procedure DrawTimer(value: string);
    procedure GetNextFile;
    procedure GetNextTrack;
    procedure GetPrevTrack;
    procedure ShowCustomHint(str:string;x,y:integer;disappear:Boolean);
    procedure SetVolume(VolumeLevel: integer);
    procedure ShowAmpView(show: boolean);
    
    { Private declarations }
  public
    hMutex:hwnd;
    procedure AddFile(const TrackFile: string; redraw: boolean);
    procedure AddFolderRec(const Path: string;SL:TStrings);
    procedure AddFolder(const Path: string);
    function OpenTrack(const FileName: string):integer;
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
  version='3.5';

  OPENTRACK_OK=0;
  OPENTRACK_STOP=1;
  OPENTRACK_FILE_NOT_EXIST=2;
  OPENTRACK_ERROR=3;

var
  AmpViewMainForm: TAmpViewMainForm;
  PlugDir: string;
  IniFile: string;
  KeysFile: string;
  Player: TBASSPlayerX;
  MyPlayList: TPlayList;
  CurTrack: integer;
  // Элементы скина
  OpenDialog: {$IF CompilerVersion >= 24.0} TOpenDialog {$ELSE} TMyOpenDialog {$IFEND} ;
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
  LastVolUpd:Cardinal;
  LastScrollUpd:Cardinal;
  DefaultFormatString:string;
  hwHint:THintWindow;
  IsOpening:Boolean;
  FileFormats:string;
  FileFormatsSL:TStringList;
  UseHints:Boolean;
  accel:double;
  ShuffleHistory:TStringList;
  ShuffleHistoryPos:Integer;
  firsttime:boolean;

implementation

uses PlayList, Options, Equal,
  FileInfo ;

{$R *.dfm}

procedure TAmpViewMainForm.FormCreate(Sender: TObject);
var
 ConfigName: string;
 sfpath:string;
 ff_media_files,ff_midi_files,ff_tracker_files:string;
 ExtFile: string;
 NumOfExt: integer;
 FilterAdd: string;
 i:integer;
begin

 firsttime:=true;

 Randomize;
 ShuffleHistory:=TStringList.Create;
 ShuffleHistory.Clear;
 ShuffleHistoryPos:=0;

 ff_media_files:='*.mp3;*.ogg;*.mp1;*.mp2;*.wma;*.wav;*.flac;*.fla;*.mp4;*.m4a;*.mpc;*.aac;*.ac3;*.opus;*.webm;*.wv;*.dsf;*.ape';
 ff_midi_files:='*.mid;*.midi;*.rmi;*.kar';
 ff_tracker_files:='*.mod;*.it;*.xm';

 FileFormats:=ff_media_files+';'+ff_midi_files+';'+ff_tracker_files;
 FileFormatsSL:=TStringList.Create;
 FileFormatsSL.Delimiter:=';';
 FileFormatsSL.DelimitedText:=FileFormats;

 OpenDialog:={$IF CompilerVersion >= 24.0} TOpenDialog {$ELSE} TMyOpenDialog {$IFEND}.Create(AmpViewMainForm);
 OpenDialog.Filter:='Media files|'+ff_media_files+'|Midi files|'+ff_midi_files+'|Module trackers|'+ff_tracker_files+'|CD Audio tracks|*.cda|Playlists|*.m3u';
 OpenDialog.Options:=OpenDialog.Options+[ofAllowMultiSelect];

 DefaultFormatString:='%IFV1(%ARTI%TITL,%IFV2(%ARTI,%ARTI,<unknown artist>) - %IFV2(%TITL,%TITL,<untitled>))';
 hwHint:=THintWindow.Create(Self);
 hwHint.Color:=clInfoBk;


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

  // to prevent flickering
  left:=GetIniInt('Main', 'left', 25, -Width+10, Screen.Width-10, IniFile);
  top:=GetIniInt('Main', 'top', 25, -Width+10, Screen.Height-10, IniFile);


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

  // Инициализация проигрывателя
  sfpath:=GetIniString('main', 'soundfontpath', '', IniFile);
  Player:=TBASSPlayerX.Create(Application.Handle, PlugDir, sfpath);
  Player.OnPlayEnd:=GetPlayEnd;

  MyPlayList:=TPlaylist.Create;

end;

procedure TAmpViewMainForm.FormShow(Sender: TObject);
var
 i: integer;
 style:hwnd;
begin
 PlayListForm.PlayList.Clear;

// Загрузка скина
 if FileExists(PlugDir+'\Skins\'+GetIniString('main', 'skin', 'ListerExtended.avsz', IniFile))
  then LoadSkin(PlugDir+'\Skins\'+GetIniString('main', 'skin', 'ListerExtended.avsz', IniFile))
  else LoadSkin(PlugDir+'\Skins\ListerExtended.avsz');

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
 //left:=-1000;
 //top:=-1000;
 SetWindowPos(PlayListForm.Handle, HWND_TOP, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 ItemTimeMode.Checked:=GetIniBool('main', 'timeleftmode', false, IniFile);
 ItemShufflePlay.Checked:=GetIniBool('main', 'ShufflePlay', false, IniFile);
 UseHints:=GetIniBool('main', 'UseProgessBarHints', true, IniFile);

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
   if OpenTrack(MyPlayList.GetFileName(CurTrack))=OPENTRACK_OK then
     Player.Play;
  end;

 SetButtonStates;

 PlayListForm.Visible:=not GetIniBool('PlayList', 'Visible', true, IniFile);
 PlayListBtn.Checked:=PlayListForm.Visible;
 ActionPlayList.Execute;

  if not IsEmbedded then
    begin
    style := GetWindowLong(Application.Handle, GWL_EXSTYLE);
    SetWindowLong(Application.Handle, GWL_EXSTYLE, style and not WS_EX_TOOLWINDOW);
    end;
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
      VolumeBar.IsThumbCenter:=GetIniInt('Volume', 'ThumbCenter', 0, 0, 1, FN)=1;

      //CreateProgress;
      //LoadImages(rlr, tnrml, tprsd);
      VolumeBar.RulerImage:=rlr;
      VolumeBar.ThumbNormalImage:=tnrml;
      VolumeBar.ThumbPressedImage:=tprsd;
      VolumeBar.Create({True});
      {VolumeBar.LoadRuler(rlr);
      VolumeBar.LoadThumbNormal(tnrml);
      VolumeBar.LoadThumbPressed(tprsd);}
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
      ProgressBar.IsThumbCenter:=GetIniInt('Progress', 'ThumbCenter', 0, 0, 1, FN)=1;
      ProgressBar.RulerImage:=rlr;
      ProgressBar.ThumbNormalImage:=tnrml;
      ProgressBar.ThumbPressedImage:=tprsd;
      ProgressBar.Create;
      //CreateProgress;
      //LoadImages(rlr, tnrml, tprsd);
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
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd); }
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      EQ1.Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ2 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ3 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ4 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ5 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ6 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ7 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ8 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ9 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EQ0 do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with EchoSlider do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
      Maximum:=30;
     end;

    // Полосы эквалайзера
    with ReverbSlider do
     begin
      {CreateProgress;
      LoadImages(rlr, tnrml, tprsd);}
      RulerImage:=rlr;
      ThumbNormalImage:=tnrml;
      ThumbPressedImage:=tprsd;
      Create;
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
       PlayList.Canvas.Font:=ListOptions.SelectedPlayedFont;

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
   end
 else
   begin
   ErrorMessage('Could not decompress skin');
   exit;
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
  ItemOpen.Caption:=GetIniString('Menus', 'ItemOpen', 'Open...', FileName);
  ItemOpenFolder.Caption:=GetIniString('Menus', 'ItemOpenFolder', 'Open Folder...', FileName);
  ItemDetach.Caption:=GetIniString('Menus', 'ItemDetach', 'Detach', FileName);
  ItemClose.Caption:=GetIniString('Menus', 'ItemClose', 'Close', FileName);
  ItemTopMost.Caption:=GetIniString('Menus', 'ItemTopMost', 'Stay on Top', FileName);
  ItemTimeMode.Caption:=GetIniString('Menus', 'ItemTimeMode', 'Time left mode', FileName);
  ItemShufflePlay.Caption:=GetIniString('Menus', 'ItemShufflePlay', 'Shuffle play', FileName);
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

    ShowFullNameItem.Caption:=GetIniString('Menus', 'ItemShowFullNames', 'Full names', FileName);
    ShowFileNamesItem.Caption:=GetIniString('Menus', 'ItemShowFileNames', 'File names', FileName);
    ShowTrackCaptionItem.Caption:=GetIniString('Menus', 'ItemTrackCaptions', 'Track captions', FileName);
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
    RewindStepBox.Caption:=GetIniString('Options', 'BoxRewindStep', 'Fast forward step size (seconds)', FileName);
    InformationBox.Caption:=GetIniString('Options', 'BoxInformation', 'Information', FileName);
    SkinBox.Caption:=GetIniString('Options', 'BoxSkin', 'Skin', FileName);
    OnEndTrackBox.Caption:=GetIniString('Options', 'BoxOnEndTrack', 'On end of a track', FileName);
    PluginsBox.Caption:=GetIniString('Options', 'BoxPlugins', 'Available Plugins', FileName);
    FontBox.Caption:=GetIniString('Options', 'BoxFont', 'Font', FileName);
    SampleBox.Caption:=GetIniString('Options', 'BoxSample', 'Sample', FileName);
    HotKeyGroupBox.Caption:=GetIniString('Options', 'PageInternalHotKeys', 'Internal HotKeys', FileName);
    GlobalBox.Caption:=GetIniString('Options', 'PageGlobalHotKeys', 'Global HotKeys', FileName);
    PressKeyBox1.Caption:=GetIniString('Options', 'BoxPressKey', 'Press a key or a keys combination', FileName);
    PressKeyBox2.Caption:=PressKeyBox1.Caption;
    MouseBox.Caption:=GetIniString('Options', 'PageMouse', 'Mouse', FileName);
    FormatTrackBox.Caption:=GetIniString('Options', 'BoxFormatTrackCaption', 'Format of track captions', FileName);
    OtherGroupBox.Caption:=GetIniString('Options', 'TreeItemOther', 'Other', FileName);
    ExtGroupBox.Caption:=GetIniString('Options', 'BoxExtensions', 'Extensions', FileName);
    ConfigGroupBox.Caption:=GetIniString('Options', 'BoxConfig', 'Configuration', FileName);    
    // Надписи (Label)
    LabelSelectLanguage.Caption:=GetIniString('Options', 'LabelSelectLanguage', 'Select language from list:', FileName);
    // Флажки (CheckBox)
    UseShadows.Caption:=GetIniString('Options', 'CheckBoxUseShadows', 'Allow use of shadows', FileName);
    UseAntiAliasing.Caption:=GetIniString('Options', 'CheckBoxUseAntiAliasing', 'Allow use of antialiasing', FileName);
    ProgressBarHintsCheckBox.Caption:=GetIniString('Options', 'CheckBoxProgessBarHints', 'Show time/volume hints', FileName);
    IgnoreSkinFontCheckBox.Caption:=GetIniString('Options', 'CheckBoxIgnoreSkinFont', 'Ignore skin font', FileName);
    NotQVCheckBox.Caption:=GetIniString('Options', 'CheckBoxNotQV', 'Do not use AmpView in QuickView mode', FileName)+'   [Ctrl+Q]';
    NotNVCheckBox.Caption:=GetIniString('Options', 'CheckBoxNotNV', 'Do not use AmpView in Normal View', FileName)+'   [F3]';
    UseControl.Caption:=GetIniString('Options', 'CheckBoxUseControl', 'Change Volume with mouse wheel only if [Ctrl] key is pressed', FileName);
    UseRelativePathsCheckBox.Caption:=GetIniString('Options', 'CheckBoxUseRelativePaths', 'Use relative paths', FileName);
    TrackWarningCheckBox.Caption:=GetIniString('Options', 'CheckBoxWarningDelTracks', 'Show warnings when deleting tracks', FileName);
    FileWarningCheckBox.Caption:=GetIniString('Options', 'CheckBoxWarningDelFiles', 'Show warnings when deleting files', FileName);
    DefaultConfigCheckBox.Caption:=GetIniString('Options', 'CheckBoxDefaultConfig', 'Use one configuration file for all users', FileName);
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
 with FileInfoForm do
   begin
    TabSheetMetadata.Caption:=GetIniString('FileInfo', 'FI_TabMetadata', 'Metadata', FileName);
    ListView1.Columns[0].Caption:=GetIniString('FileInfo', 'FI_MetadataName', 'Name', FileName);
    ListView1.Columns[1].Caption:=GetIniString('FileInfo', 'FI_MetadataValue', 'Value', FileName);
    TabSheetProperties.Caption:=GetIniString('FileInfo', 'FI_TabProperties', 'Properties', FileName);
    TypeLabel.Caption:=GetIniString('FileInfo', 'FI_Type', 'Type:', FileName);
    DurationLabel.Caption:=GetIniString('FileInfo', 'FI_Duration', 'Duration:', FileName);
    FileSizeLabel.Caption:=GetIniString('FileInfo', 'FI_FileSize', 'File size:', FileName);
    BitrateLabel.Caption:=GetIniString('FileInfo', 'FI_Bitrate', 'Bitrate:', FileName);
    ChannelModeLabel.Caption:=GetIniString('FileInfo', 'FI_ChannelMode', 'Channel Mode:', FileName);
    SampleRateLabel.Caption:=GetIniString('FileInfo', 'FI_SampleRate', 'Sample Rate:', FileName);
    LastModifiedLabel.Caption:=GetIniString('FileInfo', 'FI_LastModified', 'Last Modified:', FileName);
    CloseButton.Caption:=GetIniString('FileInfo', 'FI_CloseButton', 'Close', FileName);
    ActionCopy.Caption:=GetIniString('FileInfo', 'FI_Copy', 'Copy', FileName);
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

  // Select all
  DefKey:=TextToHotKey('Ctrl+A', true);
  ActionSelectAll.ShortCut:=GetIniInt('main', 'SelectAll', DefKey, 0, MaxInt, FileName);

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
  UnregisterHotKey(Handle, PlayGlobal);
  RegisterHotKey(Handle, PlayGlobal, Modifiers, Key);
  TrayItemPlay.ShortCut:=GetIniInt('global', 'Play', 0, 0, MaxInt, FileName);

  // "Stop"
  SeparateHotKey(GetIniInt('global', 'Stop', 0, 0, 0, FileName), Modifiers, Key);
  StopGlobal := GlobalAddAtom('StopGlobal');
  UnregisterHotKey(Handle, StopGlobal);
  RegisterHotKey(Handle, StopGlobal, Modifiers, Key);
  TrayItemStop.ShortCut:=GetIniInt('global', 'Stop', 0, 0, MaxInt, FileName);

  // "Pause"
  SeparateHotKey(GetIniInt('global', 'Pause', 0, 0, MaxInt, FileName), Modifiers, Key);
  PauseGlobal := GlobalAddAtom('PauseGlobal');
  UnregisterHotKey(Handle, PauseGlobal);
  RegisterHotKey(Handle, PauseGlobal, Modifiers, Key);
  TrayItemPause.ShortCut:=GetIniInt('global', 'Pause', 0, 0, MaxInt, FileName);

  // "Restore"
  SeparateHotKey(GetIniInt('global', 'Restore', 0, 0, MaxInt, FileName), Modifiers, Key);
  RestoreGlobal := GlobalAddAtom('RestoreGlobal');
  UnregisterHotKey(Handle, RestoreGlobal);
  RegisterHotKey(Handle, RestoreGlobal, Modifiers, Key);
  TrayItemRestore.ShortCut:=GetIniInt('global', 'Restore', 0, 0, MaxInt, FileName);

  // "Mute"
  SeparateHotKey(GetIniInt('global', 'Mute', 0, 0, MaxInt, FileName), Modifiers, Key);
  MuteGlobal := GlobalAddAtom('MuteGlobal');
  UnregisterHotKey(Handle, MuteGlobal);
  RegisterHotKey(Handle, MuteGlobal, Modifiers, Key);
//  TrayItemMute.ShortCut:=GetIniInt('global', 'Mute', 32845, 0, MaxInt, FileName);

  // "VolumeUp"
  SeparateHotKey(GetIniInt('global', 'VolumeUp', 0, 0, MaxInt, FileName), Modifiers, Key);
  VolumeUpGlobal := GlobalAddAtom('VolumeUp');
  UnregisterHotKey(Handle, VolumeUpGlobal);
  RegisterHotKey(Handle, VolumeUpGlobal, Modifiers, Key);

  // "VolumeDown"
  SeparateHotKey(GetIniInt('global', 'VolumeDown', 0, 0, MaxInt, FileName), Modifiers, Key);
  VolumeDownGlobal := GlobalAddAtom('VolumeDown');
  UnregisterHotKey(Handle, VolumeDownGlobal);
  RegisterHotKey(Handle, VolumeDownGlobal, Modifiers, Key);

  // "NextTrack"
  SeparateHotKey(GetIniInt('global', 'NextTrack', 0, 0, MaxInt, FileName), Modifiers, Key);
  NextTrackGlobal := GlobalAddAtom('NextTrack');
  UnregisterHotKey(Handle, NextTrackGlobal);
  RegisterHotKey(Handle, NextTrackGlobal, Modifiers, Key);
  TrayItemNextTrack.ShortCut:=GetIniInt('global', 'NextTrack', 0, 0, MaxInt, FileName);

  // "PrevTrack"
  SeparateHotKey(GetIniInt('global', 'PrevTrack', 0, 0, MaxInt, FileName), Modifiers, Key);
  PrevTrackGlobal := GlobalAddAtom('PrevTrack');
  UnregisterHotKey(Handle, PrevTrackGlobal);
  RegisterHotKey(Handle, PrevTrackGlobal, Modifiers, Key);
  TrayItemPreviousTtrack.ShortCut:=GetIniInt('global', 'PrevTrack', 0, 0, MaxInt, FileName);

end;


procedure TAmpViewMainForm.SetTopMost(TopMost: boolean);
begin
 if IsEmbedded then Exit;
 if not Assigned(PlayListForm) then Exit;
 if not Assigned(AmpViewMainForm) then Exit;
 if PlayListForm=nil then Exit;
 if AmpViewMainForm=nil then Exit;
 // dumb way of catching bug. playlistform is destroyed, but assigned and not nil
 if not Assigned(PlayListForm.PlayList) then Exit;

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
 top_item,bottom_item:integer;
begin
 exist:=false;
  // I?iaa?ea iaee?ey oaeea a nienea
  for i:=0 to MyPlayList.Count-1 do
   begin
    // anee oaee o?a anou
    if LowerCase(TrackFile)=lowercase(MyPlayList.GetFileName(i))
     then
      begin
       exist:=true;
       //CurTrack:=i;   // when drag, don't set to current track
       Break;
      end;
   end;

  if exist then exit;

  ext:=ExtractFileExt(TrackFile);
  //FS:=GetIniString('main', 'FormatString', '%ARTI - %TITL', IniFile);
  FS:=GetIniString('main', 'FormatString', DefaultFormatString, IniFile);

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
    top_item:=0; bottom_item:=0;
    if PlayListForm.PlayList.Items.Count>0 then
      begin
      top_item:=PlayListForm.PlayList.TopItem.Index;
      bottom_item:=top_item+PlayListForm.PlayList.VisibleRowCount-1;
      end;
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
       if bottom_item>PlayList.Items.Count-1 then bottom_item:=PlayList.Items.Count-1;
       if bottom_item>=0 then
         begin
         PlayList.Items[top_item].MakeVisible(False);
         PlayList.Items[bottom_item].MakeVisible(False);
         end;
      end;
    end;

  //CurTrack:=MyPlayList.Count-1;
end;



// Ioe?uoea o?aea
function TAmpViewMainForm.OpenTrack(const FileName: string):integer;
var
 len: integer;
 FS: string;
 sfpath:string;
begin
  result:=OPENTRACK_OK;
  with Player do
   begin
    if Player<>nil then
    Destroy;

    sfpath:=GetIniString('main', 'soundfontpath', '', IniFile);
    Player:=TBASSPlayerX.Create(Application.Handle, PlugDir, sfpath);
    Player.OnPlayEnd:=GetPlayEnd;

    if not FileExists(filename) then
      begin
      MyPlayList.SetLength(CurTrack,-1);
      if CurTrack=MyPlayList.Count-1 then // prevent looping in an empty list
        begin
        ActionStop.Execute;
        result:=OPENTRACK_STOP;
        exit;
        end;
      //ActionNextTrack.Execute;
      result:=OPENTRACK_FILE_NOT_EXIST;
      Exit;
      end;
    if not OpenFile(FileName) then
      begin
      ErrorMessage('Could not open '+FileName);
      result:=OPENTRACK_ERROR;
      Exit;
      end;
    // Eioi?iaoey
    ProgressBar.Maximum:=Player.TrackLength div 100;

    FS:=GetIniString('main', 'FormatString', DefaultFormatString, IniFile);
    SkinText.TrackCaption:=Player.GetTrackCaption(FileName, FS);

    MyPlayList.SetText(CurTrack, SkinText.TrackCaption);
    if MyPlayList.GetLength(CurTrack)=-1 then
      begin
      MyPlayList.SetLength(CurTrack, Player.GetTrackLength(FileName));
      PlayListForm.RedrawPlayList; // redraw only if -1
      end;
    MyPlayList.SetLength(CurTrack, Player.GetTrackLength(FileName));
//    PlayListForm.PlayList.Perform(LB_SETTOPINDEX, Pred(CurTrack), 0);

    SkinText.TrackCaption:=SkinText.TrackCaption+' ('+Player.GetFullTime+')';

    SkinText.BitRateCaption:= FileInfo.BitRate;
    SkinText.SPSCaption:=FileInfo.SampleRate;

    SkinText.ChannelCaption:=FileInfo.ChannelMode;
   end;

  DrawInfo;

  len:=GetTextWidth(TrackCaptionImage.Bitmap.Canvas.Handle, SkinText.TrackCaption, false);
  CaptionOffset:=(TrackCaptionImage.Width-len) div 2;
  DrawCaption(CaptionOffset);

  if (ParamCount=0) or (not firsttime) then
    begin
    if not IsEmbedded then // isembedded is not determined on first open
      SetNewTrayHint(AmpViewMainForm.handle, AmpViewMainForm.Icon.Handle, PChar(SkinText.TrackCaption));
    end;
  firsttime:=false;

  IsOpening:=true;
  SetVolume(VolumeBar.Position);
  IsOpening:=False;

  SetButtonStates;

  //ProgressBar.ShowHint:=True;

  WorkTimer.Enabled:=true;

  SetIniString('main', 'LastFolder', ExtractFilePath(FileName), IniFile);

  result:=OPENTRACK_OK;
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
   then MainImage.Bitmap.RenderTextW(x+1, y+1, text, 3, Color32(Font.Color))
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

procedure TAmpViewMainForm.ShowCustomHint(str:string;x,y:integer;disappear:Boolean);
var hwRect:TRect;
begin
  if ((not IsEmbedded) and (Application.Active)) or
     ((IsEmbedded and IsEmbeddedActive)) then
    begin
    hwRect := hwHint.CalcHintRect(Screen.Width, str, nil); { вычисляем размер }

    OffsetRect(hwRect, -(hwRect.Right-hwRect.Left) div 2, hwRect.Top-hwRect.Bottom);

    //with control.Parent.ClientToScreen(VolumeBar.BoundsRect.TopLeft) do
    //  OffsetRect(hwRect, x, Y-5); { смещаем в нужную точку }
    OffsetRect(hwRect, x, y);

    hwHint.ActivateHint(hwRect, str); { Перемещай этим методом }
    hwHintTimer.Enabled:=false;
    hwHintTimer.Enabled:=disappear;
    end;
end;

procedure TAmpViewMainForm.SetVolume(VolumeLevel: integer);
var vol:string;
    p:TPoint;
begin
  SetIniInt('main', 'volume', VolumeLevel, IniFile);

  VolumeBar.Position:=VolumeLevel;
  vol:=IntToStr(VolumeBar.Position)+'%';
                      // why active is false?
  if (UseHints) and {(AmpViewMainForm.Active) and} (VolumeBar.Visible) and not (IsOpening) then
    begin
    p.x:=volumebar.left+VolumeBar.ThumbPos;
    p.y:=volumebar.top-5;
    p:=VolumeBar.Parent.ClientToScreen(p);
    ShowCustomHint(vol,p.x,p.y,True);
    end;
  if not UseHints then DrawTimer(vol);
  LastVolUpd:=GetTickCount;

  Player.Volume:=VolumeLevel;
  MuteBtn.Checked:=false;
end;

procedure TAmpViewMainForm.GetNextTrack;
var fnd:Boolean;
    i:integer;
    res:Integer;
begin
 // Anee a nienea anaai 1 o?ae, oi auoiaei
 if MyPlayList.Count=1 then
  begin
   ActionStop.Execute;
   exit;
  end;

 // Anee oaeouee o?ae - iineaaiee, oi eaai e ia?aiio
  if GetIniBool('main', 'ShufflePlay', false, IniFile)=false then
  begin
   if CurTrack>=MyPlayList.Count-1
    then CurTrack:=0
    // eia?a - e neaao?uaio
    else CurTrack:=CurTrack+1;
  end;

  if GetIniBool('main', 'ShufflePlay', false, IniFile)=true then
    begin
    Inc(ShuffleHistoryPos);
    if ShuffleHistoryPos>ShuffleHistory.Count-1 then
      begin
      CurTrack:=Random(MyPlayList.Count);
      ShuffleHistory.Add(MyPlayList.GetFileName(CurTrack));
      end
    else
      begin
      fnd:=false;
      for i:=0 to MyPlayList.Count-1 do
        begin
        // anee oaee o?a anou
        if LowerCase(ShuffleHistory.Strings[ShuffleHistoryPos])=LowerCase(MyPlayList.GetFileName(i)) then
          begin
          fnd:=True;
          CurTrack:=i;
          Break;
          end;
        end;
      if not fnd then
        begin
        CurTrack:=Random(MyPlayList.Count);
        ShuffleHistory.Add(MyPlayList.GetFileName(CurTrack));
        ShuffleHistoryPos:=ShuffleHistory.Count-1;
        end;
      end;
    end; // shuffle

  // Ioe?uaaai o?ae
  Player.Stop;
  res:=OpenTrack(MyPlayList.GetFileName(CurTrack));
  if res=OPENTRACK_FILE_NOT_EXIST then
    begin
    GetNextTrack;
    exit;
    end;
  if res=OPENTRACK_OK then
    Player.Play;
  PlayListForm.PlayList.Repaint;
  PlayListForm.RedrawPlayList;
  PlayListForm.PlayList.ItemIndex:=CurTrack;
  PlayListForm.PlayList.ItemFocused:=PlayListForm.PlayList.Items[PlayListForm.PlayList.ItemIndex];
  PlayListForm.PlayList.Selected.MakeVisible(false);
  SetButtonStates;
end;


procedure TAmpViewMainForm.GetPrevTrack;
var i:integer;
    res:integer;
begin
 // Anee a nienea anaai 1 o?ae, oi auoiaei
 if MyPlayList.Count=1 then
  begin
   ActionStop.Execute;
   exit;
  end;
 // Anee oaeouee o?ae - ia?aue, oi eaai e iineaaiaio
  if GetIniBool('main', 'ShufflePlay', false, IniFile)=false then
    begin
   if CurTrack<=0
    then CurTrack:=MyPlayList.Count-1
    // eia?a - e i?aauaouaio
    else CurTrack:=CurTrack-1;
    end;

  if GetIniBool('main', 'ShufflePlay', false, IniFile)=true then
    begin
    if ShuffleHistory.Count<=0 then Exit;
    if ShuffleHistoryPos<=0 then exit;
    Dec(ShuffleHistoryPos);
    if ShuffleHistoryPos>ShuffleHistory.Count-1 then ShuffleHistoryPos:=ShuffleHistory.Count-1;
    for i:=0 to MyPlayList.Count-1 do
      begin
      // anee oaee o?a anou
      if LowerCase(ShuffleHistory.Strings[ShuffleHistoryPos])=LowerCase(MyPlayList.GetFileName(i)) then
        begin
        if i=CurTrack then Exit; // to prevent restarting playing song
        CurTrack:=i;
        Break;
        end;
      end;
    end; // shuffle

  // Ioe?uaaai o?ae
  Player.Stop;
  res:=OpenTrack(MyPlayList.GetFileName(CurTrack));
  if res=OPENTRACK_FILE_NOT_EXIST then
    begin
    GetPrevTrack;
    exit;
    end;
  if res=OPENTRACK_OK then
    Player.Play;
  PlayListForm.PlayList.Repaint;
  PlayListForm.RedrawPlayList;
  PlayListForm.PlayList.ItemIndex:=CurTrack;
  PlayListForm.PlayList.ItemFocused:=PlayListForm.PlayList.Items[PlayListForm.PlayList.ItemIndex];
  PlayListForm.PlayList.Selected.MakeVisible(false);
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
 FilesList.Clear;

 dir:=ExtractFilePath(MyPlayList.GetFileName(CurTrack));
 // Neaie?iaaiea iaiee
 ScanDir(dir, FilesList);

  // Auae?aai neaao?uee
  for i:=0 to FilesList.Count-1 do
   begin
    if LowerCase(FilesList[i])=LowerCase(ExtractFileName(MyPlayList.GetFileName(CurTrack)))
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
    if LowerCase(fn)=LowerCase(MyPlayList.GetFileName(i))
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
    if OpenTrack(MyPlayList.GetFileName(CurTrack))=OPENTRACK_OK then
      Player.Play;
    PlayListForm.PlayList.Repaint;
    PlayListForm.RedrawPlayList;
    PlayListForm.PlayList.ItemIndex:=CurTrack;
    PlayListForm.PlayList.ItemFocused:=PlayListForm.PlayList.Items[PlayListForm.PlayList.ItemIndex];
    PlayListForm.PlayList.Selected.MakeVisible(false);
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
   FileName:=FileName+(PAnsiChar(CData.lpData)+i)^;
  end;

 // I?iaa?ea iaee?ey oaeea
 if (not FileExists(FileName)) then Exit;

 // Ioe?uoea iiaiai oaeea
 WorkTimer.Enabled:=false;

 Player.Stop;
 AddFile(FileName, true);

 for i:=0 to MyPlayList.Count-1 do
   begin
    // anee oaee o?a anou
    if LowerCase(FileName)=LowerCase(MyPlayList.GetFileName(i))
     then
      begin
       CurTrack:=i;
       Break;
      end;
   end;

 if OpenTrack(MyPlayList.GetFileName(CurTrack))=OPENTRACK_OK then
   Player.Play;
 PlayListForm.PlayList.Repaint;
 PlayListForm.RedrawPlayList;
 PlayListForm.PlayList.ItemIndex:=CurTrack;
 PlayListForm.PlayList.ItemFocused:=PlayListForm.PlayList.Items[PlayListForm.PlayList.ItemIndex];
 PlayListForm.PlayList.Selected.MakeVisible(false);

 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 SetButtonStates;
end;

procedure TAmpViewMainForm.DrawTimer(value: string);
var
 p1, p2: TPoint;
 left1:integer;
begin
  p1.X:=TimerImage.Left;
  p1.Y:=TimerImage.Top;
  p2.X:=TimerImage.Left+TimerImage.Width;
  p2.Y:=TimerImage.Top+TimerImage.Height;

  TimerImage.Bitmap.Draw(0, 0, MakeRect(p1.x, p1.Y, p2.X,p2.y), MainPicture);

  left1:=(TimerImage.Width-TimerImage.Bitmap.TextWidth(value)) div 2;

  // Anee ?ac?aoaii eniieuciaaiea oaie
  if GetIniBool('main', 'UseShadows', false, IniFile) then
   begin
    // Anee iaiaoiaeii ?eniaaou oaiu
    if SkinText.TimerShadow then
     begin
      // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
      if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
       then TimerImage.Bitmap.RenderTextW(left1, 1, value, 3, Color32(clBlack))
//       else TimerImage.Bitmap.RenderTextW(1, 1, value, 0, Color32(clBlack));
       else
        begin
         TimerImage.Bitmap.Canvas.Brush.Color:=clBlack;
         TimerImage.Bitmap.TextOut(left1, 1, value);
        end;
     end;
   end;
  // ?enoai oaeno
  // Anee ?ac?aoaii eniieuciaaiea naea?eaaiey
   if GetIniBool('main', 'UseAntiAliasing', false, IniFile)
    then TimerImage.Bitmap.RenderTextW(left1, 0, value, 3, Color32(TimerImage.Bitmap.Font.Color))
//    else TimerImage.Bitmap.RenderText(0, 0,  value, 0, Color32(TimerImage.Bitmap.Font.Color));
    else
     begin
      TimerImage.Bitmap.Canvas.Brush.Color:=TimerImage.Bitmap.Font.Color;
      TimerImage.Bitmap.TextOut(left1, 1, value);
     end;
  //
end;

procedure TAmpViewMainForm.AddFolderRec(const Path: string;SL:TStrings);
var SR:TSearchRec;
    a:integer;
    fnd:Boolean;
begin
 if FindFirst(Path+'\*.*', faAnyFile, SR)=0 then
   repeat
   if sr.Name='.' then continue;
   if sr.Name='..' then continue;
   if sr.Attr and faDirectory=faDirectory then
     begin
     AddFolderRec(Path+'\'+sr.Name,SL);
     continue;
     end;
   fnd:=false;
   for a:=0 to FileFormatsSL.Count-1 do
     begin
     if lowercase(ExtractFileExt(sr.Name))=lowercase(ExtractFileExt(FileFormatsSL.Strings[a])) then
       begin
       fnd:=true;
       break;
       end;
     end;
   if fnd then
     begin
     SL.Add(Path+'\'+SR.Name);
     end;
   until FindNext(sr)<>0;
 FindClose(SR);
end;

// Aiaaaeaiea iaiee e nieneo
procedure TAmpViewMainForm.AddFolder(const Path: string);
var
 i: integer;
 FilesList: TStringList;
 temp: integer;
 top_item,bottom_item:integer;
begin
 FilesList:=TStringList.Create;
 FilesList.Clear;

 AddFolderRec(Path,FilesList);

 {ScanDir(Path+'\', FilesList);}

 for i:=0 to FilesList.Count-1 do
  begin
   AddFile({Path+'\'+}FilesList[i], false);
  end;
  top_item:=0; bottom_item:=0;
  if PlayListForm.PlayList.Items.Count>0 then
    begin
    top_item:=PlayListForm.PlayList.TopItem.Index;
    bottom_item:=top_item+PlayListForm.PlayList.VisibleRowCount-1;
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
    if bottom_item>PlayList.Items.Count-1 then bottom_item:=PlayList.Items.Count-1;
    if bottom_item>=0 then
      begin
      PlayList.Items[top_item].MakeVisible(False);
      PlayList.Items[bottom_item].MakeVisible(False);
      end;
  end;
end;


procedure TAmpViewMainForm.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  //if DetectWinVersion=wvXP   // shadow from main form on a playlist form is not that good
  // then Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;


procedure TAmpViewMainForm.WMHotkey(var msg: TWMHotkey);
begin
 if OptionsForm.Visible then Exit;
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
  Player.Stop;
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
 pos1:double;
begin
  step:=GetIniInt('main', 'ScrollStep', 3, 1,100, IniFile);
  //pos:=((Player.Position div 100)-step*1000)*100;
  //Player.Position:=pos;
  pos1:=Player.PositionSeconds;
  Player.PositionSeconds:=pos1-step*accel;
  ProgressBar.Position:=Player.Position div 100;
  WorkTimerTimer(Self);
end;

procedure TAmpViewMainForm.ActionForwardExecute(Sender: TObject);
var
 step: cardinal;
 pos: cardinal;
 pos1:double;
begin
  step:=GetIniInt('main', 'ScrollStep', 3, 1,100, IniFile);
  //pos:=((Player.Position div 100)+step*1000)*100;
  //Player.Position:=pos;
  pos1:=Player.PositionSeconds;
  Player.PositionSeconds:=pos1+step*accel;
  ProgressBar.Position:=Player.Position div 100;
  WorkTimerTimer(Self);
end;

procedure TAmpViewMainForm.ActionVolumeUpExecute(Sender: TObject);
var
 pos: integer;
 //vol:string;
begin
  pos:=VolumeBar.Position+10;
  if pos>=VolumeBar.Maximum then pos:=VolumeBar.Maximum;
  SetVolume(pos);
  //vol:=IntToStr(VolumeBar.Position)+'%';
  //DrawTimer(vol);
  //LastVolUpd:=GetTickCount;
end;

procedure TAmpViewMainForm.ActionVolumeDownExecute(Sender: TObject);
var
 pos: integer;
 //vol:string;
begin
  pos:=VolumeBar.Position-10;
  if pos<=0 then pos:=0;
  SetVolume(pos);
  //vol:=IntToStr(VolumeBar.Position)+'%';
  //DrawTimer(vol);
  //LastVolUpd:=GetTickCount;
end;

procedure GetFileIcon(ext:string;var Icon:TIcon;var Desc:string);
var
  iCount : integer;
  Extension : string;
  FileInfo : SHFILEINFO;
begin

  try
  // Loop through all stored extensions and retrieve relevant info
    Extension := '*.'+ext;

    // Get description type
    SHGetFileInfo(PChar(Extension),
                  FILE_ATTRIBUTE_NORMAL,
                  FileInfo,
                  SizeOf(FileInfo),
                  SHGFI_TYPENAME or SHGFI_USEFILEATTRIBUTES
                  );
    Desc:=FileInfo.szTypeName;

    // Get icon and copy into ImageList
    SHGetFileInfo(PChar(Extension),
                  FILE_ATTRIBUTE_NORMAL,
                  FileInfo,
                  SizeOf(FileInfo),
                  SHGFI_ICON {or SHGFI_SMALLICON }or
                  SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES
                  );
    Icon.Handle := FileInfo.hIcon;
  finally

  end;
end;

function ReportTime(const Name: string; const FileTime: TFileTime):string;
var
  SystemTime, LocalTime: TSystemTime;
begin
  if not FileTimeToSystemTime(FileTime, SystemTime) then
    RaiseLastOSError;
  if not SystemTimeToTzSpecificLocalTime(nil, SystemTime, LocalTime) then
    RaiseLastOSError;
  result:=DateTimeToStr(SystemTimeToDateTime(LocalTime));
end;

procedure TAmpViewMainForm.ActionFileInfoExecute(Sender: TObject);
var
 FileName: string;
 br:string;
 fad: TWin32FileAttributeData;
 sizestring,sizebytes:string;
 s:integer;
 FI:TFileInfo;
 Icon:TIcon;
 icondesc:string;
 LI:TListItem;
 SL:TStringList;
 a:integer;
 lf:string;
begin
 if MyPlayList.Count<=0 then exit;
 FileName:='';
 with PlayListForm do
  begin
   if (PlayList.ItemIndex>=0) and (PlayList.Focused)
    then
      begin
      FileName:=MyPlayList.GetFileName(PlayList.ItemIndex);
      FileInfoForm.caption:=MyPlayList.GetText(PlayList.ItemIndex);
      end
    else
      begin
      FileName:=MyPlayList.GetFileName(CurTrack);
      FileInfoForm.caption:=MyPlayList.GetText(CurTrack);
      end;
  end;
if not fileexists(FileName) then
  begin
  ErrorMessage('File not found: '+FileName);
  exit;
  end;
Icon:=TIcon.Create;
GetFileIcon(ExtractFileExt(FileName),Icon,icondesc);
FileInfoForm.FileIconImage.Picture.Assign(Icon);
FileInfoForm.FileIconImage.Hint:=icondesc;
FileInfoForm.FileIconImage.ShowHint:=True;
Icon.Free;

 lf:=PlugDir+'\Language\'+GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile);

FileInfoForm.FileNameEdit.Text:={ExtractFileName(}FileName{)};
FileInfoForm.FileNameEdit.Hint:=FileName;
FileInfoForm.FileNameEdit.ShowHint:=True;
FI:=Player.GetFileInfo(FileName);
sizestring:='';
s:=FI.FileSize;
sizebytes:=IntToStr(s)+' '+GetIniString('FileInfo', 'FI_bytes', 'bytes', lf);
if s>1024*1024*1024 then sizestring:=floattostrf(s/1024/1024/1024,ffFixed,7,2)+' GB ('+sizebytes+')' else
if s>1024*1024 then sizestring:=floattostrf(s/1024/1024,ffFixed,7,2)+' MB ('+sizebytes+')' else
if s>1024 then sizestring:=floattostrf(s/1024,ffFixed,7,2)+' kB ('+sizebytes+')'
else sizestring:=sizebytes;
FileInfoForm.FileSizeEdit.Text:=sizestring;
  if not GetFileAttributesEx(PChar(FileName), GetFileExInfoStandard, @fad) then
    RaiseLastOSError;
FileInfoForm.LastModifiedEdit.Text:=ReportTime(FileName,fad.ftLastWriteTime);
FileInfoForm.TypeEdit.Text:=FI.Format;
FileInfoForm.DurationEdit.Text:=FI.Duration;
FileInfoForm.BitRateEdit.Text:=FI.BitRate;
FileInfoForm.SampleRateEdit.Text:=FI.SampleRate;
FileInfoForm.ChannelModeEdit.Text:=FI.ChannelMode;

FileInfoForm.ListView1.Clear;
if FI.Tags.Artist<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Artist', 'Artist', lf);
  LI.SubItems.Add(FI.Tags.Artist);
  end;
if FI.Tags.Title<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Title', 'Title', lf);
  LI.SubItems.Add(FI.Tags.Title);
  end;
if FI.Tags.Album<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Album', 'Album', lf);
  LI.SubItems.Add(FI.Tags.Album);
  end;
if FI.Tags.Genre<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Genre', 'Genre', lf);
  LI.SubItems.Add(FI.Tags.Genre);
  end;
if FI.Tags.Year<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Year', 'Year', lf);
  LI.SubItems.Add(FI.Tags.Year);
  end;
if FI.Tags.Track<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Track', 'Track', lf);
  LI.SubItems.Add(FI.Tags.Track);
  end;
if FI.Tags.Composer<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Composer', 'Composer', lf);
  LI.SubItems.Add(FI.Tags.Composer);
  end;
if FI.Tags.Copyright<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Copyright', 'Copyright', lf);
  LI.SubItems.Add(FI.Tags.Copyright);
  end;
if FI.Tags.Subtitle<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Subtitle', 'Subtitle', lf);
  LI.SubItems.Add(FI.Tags.Subtitle);
  end;
if FI.Tags.AlbumArtist<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_AlbumArtist', 'AlbumArtist', lf);
  LI.SubItems.Add(FI.Tags.AlbumArtist);
  end;
if FI.Tags.DiscNumber<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_DiscNumber', 'DiscNumber', lf);
  LI.SubItems.Add(FI.Tags.DiscNumber);
  end;
if FI.Tags.Publisher<>'' then
  begin
  LI:=FileInfoForm.ListView1.Items.Add;
  LI.Caption:=GetIniString('FileInfo', 'FI_tag_Publisher', 'Publisher', lf);
  LI.SubItems.Add(FI.Tags.Publisher);
  end;
if FI.Tags.Comment<>'' then
  begin
  SL:=TStringList.Create;
  SL.Clear;
  SL.Text:=FI.Tags.Comment;
  for a:=0 to SL.Count-1 do
    begin
    LI:=FileInfoForm.ListView1.Items.Add;
    if a=0 then LI.Caption:=GetIniString('FileInfo', 'FI_tag_Comment', 'Comment', lf);
    LI.SubItems.Add(SL.Strings[a]);
    end;
  SL.Free;
  end;

FileInfoForm.ShowModal;
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
 if IsEmbedded then exit;
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
    if OpenTrack(MyPlayList.GetFileName(CurTrack))=OPENTRACK_OK then
      Player.Play;
    SetButtonStates;


end;

procedure TAmpViewMainForm.ActionMinimizeToTrayExecute(Sender: TObject);
begin
 if IsEmbedded then exit;
// Application.Minimize;
 WorkTimer.Enabled:=false;
 //
 AddTrayIcon(AmpViewMainForm.Handle, Application.Icon.Handle, PChar(SkinText.TrackCaption));
 //
 ShowAmpView(false);
end;

procedure TAmpViewMainForm.ActionRestoreFromTrayExecute(Sender: TObject);
begin
 if IsEmbedded then exit;
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
   then
     begin
     if not PlayListForm.Visible then Exit;
     if not PlayListForm.PlayList.Visible then Exit;
     PlayListForm.PlayList.SetFocus;
     end
   else AmpViewMainForm.SetFocus;
end;

procedure TAmpViewMainForm.WorkTimerTimer(Sender: TObject);
var
 time: string[9];
 Len: integer;
begin

  if (not ProgressBar.Pressed)
   then ProgressBar.Position:=Player.Position div 100;
   //else exit; // actually not exit
  UseHints:=GetIniBool('main', 'UseProgessBarHints', true, IniFile);
  time:=Player.GetTrackTime(GetIniBool('main', 'timeleftmode', false, IniFile));
  if LastVolUpd>GetTickCount then LastVolUpd:=GetTickCount; // not needed actually. only if wrong value/overflow
  if ((not UseHints) and (not VolumeBar.Pressed) and (not ProgressBar.Pressed) and (GetTickCount-LastVolUpd>500))
  or (UseHints) then
    begin
    DrawTimer(time);
    LastVolUpd:=GetTickCount;
    end;
  //

  if LastScrollUpd>GetTickCount then LastScrollUpd:=GetTickCount;

  if GetTickCount-LastScrollUpd>WorkTimer.Interval then
    begin
    len:=GetTextWidth(TrackCaptionImage.Bitmap.Canvas.Handle, SkinText.TrackCaption, false);

    // Прокрутка заголовка
    if len<=TrackCaptionImage.Width then exit;

    if CaptionOffset<(-len)
     then
     CaptionOffset:=TrackCaptionImage.Width
     else CaptionOffset:=CaptionOffset-3;

    DrawCaption(CaptionOffset);

    LastScrollUpd:=GetTickCount;
    end;
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
  if IsEmbedded then Exit;
  ActionMinimizeToTray.Execute;
end;

procedure TAmpViewMainForm.CloseBtnClick(Sender: TObject);
begin
  if IsEmbedded then Exit;
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
var
 time: string[9];
 left: boolean;
 pos: cardinal;
begin
{ if ProgressBar.Pressed then exit;
// in this implementation, the next line will be never executed
 Player.Position:=ProgressBar.Position*100;}

 if not UseHints then
   begin
   pos:=ProgressBar.Position*100;

   left:=GetIniBool('main', 'timeleftmode', false, IniFile);

    if left
     then time:='-'+Player.BassLenToTime(Player.TrackLength-Pos)
     else time:=' '+Player.BassLenToTime(Pos);

    DrawTimer(time);
   end;

end;

procedure TAmpViewMainForm.ProgressBarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
// if not ProgressBar.Pressed then exit;
 Player.Position:=ProgressBar.Position*100;
end;


procedure TAmpViewMainForm.ProgressBarMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
 time: string[9];
 left: boolean;
 pos: cardinal;
 hhint:string;
 p:TPoint;
begin

  hhint:=Player.BassLenToTime(ProgressBar.MouseOverPos*100);
  //ProgressBar.Hint:=hhint;
  //Application.ActivateHint(ProgressBar.ClientToScreen(Point(x,y)));

  if UseHints then
    begin
    p.x:=ProgressBar.left+x+5;
    p.y:=ProgressBar.top-10;
    p:=ProgressBar.Parent.ClientToScreen(p);

    if Player.TrackFile<>'' then
      ShowCustomHint(hhint,p.x,p.y,false);
    end;

 if not ProgressBar.Pressed then exit;

 if not UseHints then
   begin
   pos:=ProgressBar.Position*100;

   left:=GetIniBool('main', 'timeleftmode', false, IniFile);

    if left
     then time:='-'+Player.BassLenToTime(Player.TrackLength-Pos)
     else time:=' '+Player.BassLenToTime(Pos);

    DrawTimer(time);
   end;
   
end;

// Регулятор громкости
procedure TAmpViewMainForm.VolumeBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
//var vol:string;
begin
 //if VolumeBar.Pressed then exit;

 SetVolume(VolumeBar.Position);
//vol:=IntToStr(VolumeBar.Position)+'%';
//DrawTimer(vol);
end;

procedure TAmpViewMainForm.VolumeBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
//var vol:string;
begin
 if not VolumeBar.Pressed then exit;
//vol:=IntToStr(VolumeBar.Position)+'%';
//DrawTimer(vol);
 SetVolume(VolumeBar.Position);
end;

function TAmpViewMainForm.IsEmbedded:boolean;
var
   class1 : array[0 .. 255] of Char;
   p:HWND;
begin
result:=false;
p:=GetAncestor(Handle,GA_PARENT);
if p>0 then
  begin
  GetClassName(p, class1, 256);
  if string(class1)='AMPVIEW_PLAYER' then result:=True;
  end;
end;

function TAmpViewMainForm.IsEmbeddedActive:boolean;
var
   class1 : array[0 .. 255] of Char;
   p,pp,ppp:HWND;
   aw:HWND;
begin
result:=false;
p:=GetAncestor(Handle,GA_PARENT);
if p>0 then
  begin
  GetClassName(p, class1, 256);
  if string(class1)<>'AMPVIEW_PLAYER' then p:=0;
  end;
if p=0 then Exit;
pp:=GetAncestor(p,GA_PARENT);
if pp>0 then
  begin
  GetClassName(pp, class1, 256);
  if string(class1)<>'TLister' then pp:=0;
  end;
if pp=0 then exit;
ppp:=GetAncestor(pp,GA_PARENT);
if ppp>0 then
  begin
  GetClassName(ppp, class1, 256);
  if string(class1)<>'TTOTAL_CMD' then ppp:=0;
  end;
aw:=GetActiveWindow;
if (aw=Handle) or (aw=PlayListForm.Handle) or (aw=p) or (aw=pp) or (aw=ppp) then result:=True;
end;

procedure TAmpViewMainForm.DoDeactivate;
var
   class1 , str1 : array[0 .. 255] of Char;
   p,res,win:HWND;
   a:integer;
begin
{win:=Handle;
GetClassName(win, class1, 256);
GetWindowText(win, str1, 256);
Memo1.Lines.Add('handle: '+IntToStr(win));
Memo1.Lines.Add('class: '+string(class1));
Memo1.Lines.Add('str: '+string(str1));
Memo1.Lines.Add('');
for a:=1 to 5 do
begin
p:=GetParent(win);
Memo1.Lines.Add('parent handle: '+IntToStr(p));
if p=0 then break;
GetClassName(p, class1, 256);
GetWindowText(p, str1, 256);
Memo1.Lines.Add('class: '+string(class1));
Memo1.Lines.Add('str: '+string(str1));
win:=p;
end;
Memo1.Lines.Add('');
win:=Handle;
for a:=1 to 5 do
begin
p:=GetAncestor(win,GA_PARENT);
Memo1.Lines.Add('ancestor handle: '+IntToStr(p));
if p=0 then break;
GetClassName(p, class1, 256);
GetWindowText(p, str1, 256);
Memo1.Lines.Add('class: '+string(class1));
Memo1.Lines.Add('str: '+string(str1));
win:=p;
end;

Memo1.Lines.Add('');
win:=Handle;
for a:=1 to 5 do
begin
p:=GetWindow(win,GW_OWNER);
Memo1.Lines.Add('owner handle: '+IntToStr(p));
if p=0 then break;
GetClassName(p, class1, 256);
GetWindowText(p, str1, 256);
Memo1.Lines.Add('class: '+string(class1));
Memo1.Lines.Add('str: '+string(str1));
win:=p;
end;

Memo1.Lines.Add('');
win:=GetActiveWindow;
GetClassName(win, class1, 256);
GetWindowText(win, str1, 256);
Memo1.Lines.Add('active window: '+IntToStr(win));
Memo1.Lines.Add('class: '+string(class1));
Memo1.Lines.Add('str: '+string(str1));

Memo1.Lines.Add('');
win:=GetForegroundWindow;
GetClassName(win, class1, 256);
GetWindowText(win, str1, 256);
Memo1.Lines.Add('foreground window: '+IntToStr(win));
Memo1.Lines.Add('class: '+string(class1));
Memo1.Lines.Add('str: '+string(str1));

Memo1.Lines.Add('');
win:=GetFocus;
GetClassName(win, class1, 256);
GetWindowText(win, str1, 256);
Memo1.Lines.Add('focus window: '+IntToStr(win));
Memo1.Lines.Add('class: '+string(class1));
//Memo1.Lines.Add('str: '+string(str1));   }

{p:=GetAncestor(Handle,GA_PARENT);
if p>0 then
  begin
  GetClassName(p, class1, 256);
  if string(class1)='AMPVIEW_PLAYER' then
    begin
    //SendMessage(p, WM_SYSCOMMAND, SC_RESTORE, 0);
    //ShowWindow(p,SW_SHOW);
    //AttachThreadInput(GetCurrentThreadId, GetWindowThreadProcessId(p, nil), True);
    SetForegroundWindow(p);
    SetActiveWindow(p);
    res:=Windows.SetFocus(p);
    end;
  end;   }
end;

procedure TAmpViewMainForm.PostMsgParent(msg:TMessage);
var
   class1 : array[0 .. 255] of Char;
   p,res:HWND;
begin
p:=GetAncestor(Handle,GA_PARENT);
if p>0 then
  begin
  GetClassName(p, class1, 256);
  if string(class1)='AMPVIEW_PLAYER' then
    begin
    SendMessage(p, msg.Msg, msg.WParam, msg.LParam);
    end;
  end;
end;

function TAmpViewMainForm.GetParentHandle:HWND;
var
   class1 : array[0 .. 255] of Char;
   p,res:HWND;
begin
result:=0;
p:=GetAncestor(Handle,GA_PARENT);
if p>0 then
  begin
  GetClassName(p, class1, 256);
  if string(class1)='AMPVIEW_PLAYER' then
    begin
    result:=p;
    end;
  end;
end;

procedure TAmpViewMainForm.MainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if (Layer<>nil) and (Layer.Tag=0) then ErrorMessage('!!!');

  if Button <> mbRight then
   begin
    // Aee??aiai ?a?ei ia?aoaneeaaiey
    if IsEmbedded then exit;
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
var
  MyPoint : TPoint;
begin
MyPoint := ProgressBar.ScreenToClient(Mouse.CursorPos);
  if PtInRect(ProgressBar.ClientRect, MyPoint) then
  begin
    // Mouse is inside the control, do something here
  end else
    begin
    if not (ssCtrl in Shift) then
      hwHint.ReleaseHandle;;
    end;

  if not (ssLeft in Shift) and not (ssMiddle in Shift) then dragmode:=false;
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
  FileFormatsSL.Free;
  hwHint.Free;
  DeleteTrayIcon(AmpViewMainForm.Handle);
end;


// Установка поверх всех окон
procedure TAmpViewMainForm.WMDeactivate(var Msg: TMessage);
begin

 //exit; // actually bugs when deactivates
 hwHint.ReleaseHandle;
 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 inherited;
end;

procedure TAmpViewMainForm.WMActivateApp(var Msg: TMessage);
begin
{if IsEmbedded then
  if msg.WParam<>0 then DoDeactivate; }
 //exit; // actually bugs when deactivates
 if msg.WParam=0 then hwHint.ReleaseHandle; // does not work
 SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 inherited;
end;

procedure TAmpViewMainForm.WMActivate(var Msg: TMessage);
begin
if msg.WParam=0 then hwHint.ReleaseHandle; // does not work
inherited;
end;

procedure TAmpViewMainForm.WMPreventLoop(var Msg: TMessage);
begin
PreventLoop:=Msg.WParam=1;
end;

procedure TAmpViewMainForm.WMAttached(var Msg: TMessage);
begin
if IsEmbedded then
  begin
  DeleteTrayIcon(AmpViewMainForm.Handle);
  if hMutex<>0 then
    begin
    CloseHandle(hMutex);
    hMutex:=0;
    ActionClose.ShortCut:=0;
    ActionClose.SecondaryShortCuts.Clear;
    ActionClose.Visible:=false;
    if msg.WParam=0 then // quickview
      begin
      ActionDetach.Enabled:=True;
      ActionDetach.Visible:=True;
      end;
    ActionTopMost.Enabled:=false;
    ActionTopMost.Visible:=false;
    CloseBtn.Visible:=false;
    MinBtn.Visible:=false;
    end;
  end;
end;

procedure TAmpViewMainForm.WMDetached(var Msg: TMessage);
begin
hMutex:= CreateMutex(nil, true , 'AmpView_MediaPlayer');
ActionClose.ShortCut:=TextToHotKey('Esc',true);
ActionClose.SecondaryShortCuts.Add('Alt+F4');
ActionClose.Visible:=true;
ActionDetach.Enabled:=false;
ActionDetach.Visible:=false;
ActionTopMost.Enabled:=true;
ActionTopMost.Visible:=true;
CloseBtn.Visible:=true;
MinBtn.Visible:=true;
SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
end;


procedure TAmpViewMainForm.WMKeyDown(var Msg: TMessage);
var prmsg:TMessage;
begin

if (msg.WParam=VK_UP) then
  begin
  if not PlayListForm.Visible then Exit;
  if not PlayListForm.PlayList.Visible then Exit;
  PlayListForm.SetFocus;
  PlayListForm.PlayList.SetFocus;
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYDOWN,VK_UP,0);
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYUP,VK_UP,0);
  Exit;
  end;
if (msg.WParam=VK_DOWN) then
  begin
  if not PlayListForm.Visible then Exit;
  if not PlayListForm.PlayList.Visible then Exit;
  PlayListForm.SetFocus;
  PlayListForm.PlayList.SetFocus;
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYDOWN,VK_DOWN,0);
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYUP,VK_DOWN,0);
  exit;
  end;
if (msg.WParam=VK_LEFT) or (msg.WParam=VK_RIGHT) then
  begin
  if accel=0 then accel:=1;
  if (msg.lparam and $40000000)=0 then accel:=1 else accel:=accel+0.1;
  if (msg.WParam=VK_RIGHT) then ActionForward.Execute;
  if (msg.WParam=VK_LEFT) then ActionRewind.Execute;
  Exit;
  end;

inherited;

if PreventLoop then exit;
if IsEmbedded then
  begin
  prmsg.Msg:=WM_USER + 101;
  prmsg.WParam:=1;
  prmsg.LParam:=0;
  PostMsgParent(prmsg);
  PostMsgParent(msg);
  prmsg.Msg:=WM_USER + 101;
  prmsg.WParam:=0;
  prmsg.LParam:=0;
  PostMsgParent(prmsg);
  end;

end;

procedure TAmpViewMainForm.WMKeyUp(var Msg: TMessage);
var prmsg:TMessage;
begin
if (msg.WParam=VK_LEFT) or (msg.WParam=VK_RIGHT) then
  begin

  end;

if PreventLoop then exit;
if IsEmbedded then
  begin
  prmsg.Msg:=WM_USER + 101;
  prmsg.WParam:=1;
  prmsg.LParam:=0;
  PostMsgParent(prmsg);
  PostMsgParent(msg);
  prmsg.Msg:=WM_USER + 101;
  prmsg.WParam:=0;
  prmsg.LParam:=0;
  PostMsgParent(prmsg);
  end;
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
var dir:string;
begin
  dir:=GetDir('Select directory:');
  if dir='' then exit;

  Screen.Cursor:=crHourGlass;

  AddFolder(dir);

  Screen.Cursor:=crDefault;

  PlayListBtn.Repaint;

  // Ioe?uoea oaeea
  Player.Stop;
  if OpenTrack(MyPlayList.GetFileName(CurTrack))=OPENTRACK_OK then
    Player.Play;
  SetButtonStates;
end;

procedure TAmpViewMainForm.VolumeBarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
SetVolume(VolumeBar.Position);
end;

procedure TAmpViewMainForm.ActionSelectAllExecute(Sender: TObject);
begin
if not PlayListForm.Visible then Exit;
if not PlayListForm.PlayList.Visible then Exit;
PlayListForm.PlayList.SelectAll;
PlayListForm.SetFocus;
end;

procedure TAmpViewMainForm.hwHintTimerTimer(Sender: TObject);
begin
hwHint.ReleaseHandle;
hwHintTimer.Enabled:=false;
end;

procedure TAmpViewMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 step: cardinal;
 pos: cardinal;
begin
// actually does not work when wm_keydown present
exit;
if (Key=VK_UP) and (Shift=[]) then
  begin
  if not PlayListForm.Visible then Exit;
  if not PlayListForm.PlayList.Visible then Exit;
  PlayListForm.SetFocus;
  PlayListForm.PlayList.SetFocus;
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYDOWN,VK_UP,0);
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYUP,VK_UP,0);
  end;
if (Key=VK_DOWN) and (Shift=[]) then
  begin
  if not PlayListForm.Visible then Exit;
  if not PlayListForm.PlayList.Visible then Exit;
  PlayListForm.SetFocus;
  PlayListForm.PlayList.SetFocus;
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYDOWN,VK_DOWN,0);
  SendMessage(PlayListForm.PlayList.Handle,WM_KEYUP,VK_DOWN,0);
  end;
{if (Key=VK_RIGHT) and (Shift=[]) then
  begin
  ActionForward.Execute;
  end;
if (Key=VK_LEFT) and (Shift=[]) then
  begin
  ActionRewind.Execute;
  end;          }
end;

procedure TAmpViewMainForm.ActionDetachExecute(Sender: TObject);
var msg:TMessage;
begin
if not IsEmbedded then exit;
msg.Msg:=WM_USER+112;
msg.WParam:=0;
msg.LParam:=0;
PostMsgParent(msg);
end;

procedure TAmpViewMainForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
DeleteTrayIcon(AmpViewMainForm.Handle);
end;

procedure TAmpViewMainForm.ActionShufflePlayExecute(Sender: TObject);
var prev:Boolean;
begin
prev:=GetIniBool('main', 'ShufflePlay', false, IniFile);
SetIniBool('main', 'ShufflePlay', not prev, IniFile);
ItemShufflePlay.Checked:=GetIniBool('main', 'ShufflePlay', false, IniFile);
end;

end.



