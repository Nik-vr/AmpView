{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit MyDialogs;

{$R-,T-,H+,X+}

interface

uses Windows, Messages, SysUtils, CommDlg, Classes, Graphics,
     Controls, Forms;

type

{ TCommonDialog }

  TCommonDialog = class(TComponent)
  private
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FTemplate: PChar;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure MainWndProc(var Message: TMessage);
  protected
    procedure DoClose; dynamic;
    procedure DoShow; dynamic;
    procedure WndProc(var Message: TMessage); virtual;
    function MessageHook(var Msg: TMessage): Boolean; virtual;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; virtual;
    property Template: PChar read FTemplate write FTemplate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; virtual; abstract;
    procedure DefaultHandler(var Message); override;
    property Handle: HWnd read FHandle;
  published
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

{ TOpenDialog }

  TOpenOption = (ofReadOnly, ofOverwritePrompt, ofHideReadOnly,
    ofNoChangeDir, ofShowHelp, ofNoValidate, ofAllowMultiSelect,
    ofExtensionDifferent, ofPathMustExist, ofFileMustExist,
    ofNoReadOnlyReturn, ofEnableIncludeNotify,
    ofEnableSizing, ofForceShowHidden);
  TOpenOptions = set of TOpenOption;

  TOpenOptionEx = (ofExNoPlacesBar);
  TOpenOptionsEx = set of TOpenOptionEx;

  TFileEditStyle = (fsEdit, fsComboBox);
  TOFNotifyEx = type CommDlg.TOFNotifyEx;
//  {$NODEFINE TOFNotifyEx}
  TIncludeItemEvent = procedure (const OFN: TOFNotifyEx; var Include: Boolean) of object;

  TMyOpenDialog = class(TCommonDialog)
  private
    FHistoryList: TStrings;
    FOptions: TOpenOptions;
    FFilter: string;
    FFilterIndex: Integer;
    FCurrentFilterIndex: Integer;
    FInitialDir: string;
    FTitle: string;
    FDefaultExt: string;
    FFileName: TFileName;
    FFiles: TStrings;
//    FFileEditStyle: TFileEditStyle;
    FOnSelectionChange: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FOnCanClose: TCloseQueryEvent;
//    FOnIncludeItem: TIncludeItemEvent;
    FOptionsEx: TOpenOptionsEx;
    function GetFileName: TFileName;
    function GetFilterIndex: Integer;
//    procedure ReadFileEditStyle(Reader: TReader);
    procedure SetHistoryList(Value: TStrings);
    procedure SetInitialDir(const Value: string);
  protected
    function CanClose(var OpenFileName: TOpenFileName): Boolean;
    function DoCanClose: Boolean; dynamic;
    function DoExecute(Func: Pointer): Bool;
    procedure DoSelectionChange; dynamic;
    procedure DoFolderChange; dynamic;
    procedure DoTypeChange; dynamic;
//    procedure DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean); dynamic;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetFileNames(var OpenFileName: TOpenFileName);
    function GetStaticRect: TRect; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
//    property FileEditStyle: TFileEditStyle read FFileEditStyle write FFileEditStyle;
    property Files: TStrings read FFiles;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property FileName: TFileName read GetFileName write FFileName;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default 1;
    property InitialDir: string read FInitialDir write SetInitialDir;
    property Options: TOpenOptions read FOptions write FOptions default [ofHideReadOnly, ofEnableSizing];
    property OptionsEx: TOpenOptionsEx read FOptionsEx write FOptionsEx default [];
    property Title: string read FTitle write FTitle;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
//    property OnIncludeItem: TIncludeItemEvent read FOnIncludeItem write FOnIncludeItem;
  end;

{ TSaveDialog }

  TMySaveDialog = class(TMyOpenDialog)
    function Execute: Boolean; override;
  end;

{ Win98 and Win2k will default to the "My Documents" folder if the InitialDir
  property is empty and no files of the filtered type are contained in the
  current directory. Set this flag to True to force TOpenDialog and descendents
  to always open in the current directory when InitialDir is empty. (Same
  behavior as setting InitialDir to '.') }
var
  ForceCurrentDirectory: Boolean = False;

implementation

uses
  ExtCtrls, Consts, Dlgs, Math;

{ Private globals }

var
  CreationControl: TCommonDialog = nil;
  HelpMsg: Cardinal;
  FindMsg: Cardinal;
  WndProcPtrAtom: TAtom = 0;

{ Center the given window on the screen }

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  GetWindowRect(Wnd, Rect);
  if Application.MainForm <> nil then
  begin
    if Assigned(Screen.ActiveForm) then
      Monitor := Screen.ActiveForm.Monitor
      else
        Monitor := Application.MainForm.Monitor;
  end
  else
    Monitor := Screen.Monitors[0];
  SetWindowPos(Wnd, 0,
    Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
    Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{ Generic dialog hook. Centers the dialog on the screen in response to
  the WM_INITDIALOG message }

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CenterWindow(Wnd);
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end;
end;

{ TCommonDialog }

constructor TCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FObjectInstance := Classes.MakeObjectInstance(MainWndProc);
end;

destructor TCommonDialog.Destroy;
begin
  if FObjectInstance <> nil then Classes.FreeObjectInstance(FObjectInstance);
  inherited Destroy;
end;

function TCommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Msg.Msg = HelpMsg) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
    Result := True;
  end;
end;

procedure TCommonDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

procedure TCommonDialog.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TCommonDialog.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TCommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  DoClose;
end;

procedure TCommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  { Called only by non-explorer style dialogs }
  DoShow;
  { Prevent any further processing }
  Message.Result := 0;
end;

procedure TCommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

function TCommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
  FPUControlWord: Word;
  FocusState: TFocusState;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  FocusState := SaveFocusState;
  try
    Application.HookMainWindow(MessageHook);
    asm
      // Avoid FPU control word change in NETRAP.dll, NETAPI32.dll, etc
      FNSTCW  FPUControlWord
    end;
    try
      CreationControl := Self;
      Result := TDialogFunc(DialogFunc)(DialogData);
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
      Application.UnhookMainWindow(MessageHook);
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
    RestoreFocusState(FocusState);
  end;
end;

procedure TCommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TCommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

{ Open and Save dialog routines }

function ExplorerHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end
  else if (Msg = WM_NOTIFY) and (POFNotify(LParam)^.hdr.code = CDN_INITDONE) then
    CenterWindow(GetWindowLong(Wnd, GWL_HWNDPARENT));
end;

{ TOpenDialog }

constructor TMyOpenDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHistoryList := TStringList.Create;
  FOptions := [ofHideReadOnly, ofEnableSizing];
  FOptionsEx := [];
  FFiles := TStringList.Create;
  FFilterIndex := 1;
//  FFileEditStyle := fsEdit;
end;

destructor TMyOpenDialog.Destroy;
begin
  FFiles.Free;
  FHistoryList.Free;
  inherited Destroy;
end;

function TMyOpenDialog.CanClose(var OpenFileName: TOpenFileName): Boolean;
begin
  GetFileNames(OpenFileName);
  Result := DoCanClose;
  FFiles.Clear;
end;

procedure TMyOpenDialog.WndProc(var Message: TMessage);
var
  Index: Integer;
  Include: Boolean;
begin
  Message.Result := 0;
  { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
  if (Message.Msg = WM_INITDIALOG) then Exit
  else if (Message.Msg = WM_NOTIFY) then
    case (POFNotify(Message.LParam)^.hdr.code) of
      CDN_FILEOK:
        if not CanClose(POFNotify(Message.LParam)^.lpOFN^) then
        begin
          Message.Result := 1;
          SetWindowLong(Handle, DWL_MSGRESULT, Message.Result);
          Exit;
        end;
      CDN_INITDONE: DoShow;
      CDN_SELCHANGE: DoSelectionChange;
      CDN_FOLDERCHANGE: DoFolderChange;
      CDN_TYPECHANGE:
        begin
          Index := POFNotify(Message.LParam)^.lpOFN^.nFilterIndex;
          if Index <> FCurrentFilterIndex then
          begin
            FCurrentFilterIndex := Index;
            DoTypeChange;
          end;
        end;
      CDN_INCLUDEITEM:
        if Message.LParam <> 0 then
        begin
          Include := True;
//          DoIncludeItem(TOFNotifyEx(POFNotifyEx(Message.LParam)^), Include);
          Message.Result := Byte(Include);
        end;
    end;
  inherited WndProc(Message);
end;

function TMyOpenDialog.DoCanClose: Boolean;
begin
  Result := True;
  if Assigned(FOnCanClose) then FOnCanClose(Self, Result);
end;

procedure TMyOpenDialog.DoSelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;

procedure TMyOpenDialog.DoFolderChange;
begin
  if Assigned(FOnFolderChange) then FOnFolderChange(Self);
end;

procedure TMyOpenDialog.DoTypeChange;
begin
  if Assigned(FOnTypeChange) then FOnTypeChange(Self);
end;


procedure TMyOpenDialog.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
//  Filer.DefineProperty('FileEditStyle', ReadFileEditStyle, nil, False);
end;


function FixFileName(const FileName: string): string;
begin
  Result := FileName;
end;


function TMyOpenDialog.DoExecute(Func: Pointer): Bool;
const
  MultiSelectBufferSize = High(Word) - 16;
  OpenOptions: array [TOpenOption] of DWORD = (
    OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
    OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
    OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
    OFN_NOREADONLYRETURN,
    OFN_ENABLEINCLUDENOTIFY, OFN_ENABLESIZING, OFN_FORCESHOWHIDDEN);

  OpenOptionsEx: array [TOpenOptionEx] of DWORD = (OFN_EX_NOPLACESBAR);
var
  Option: TOpenOption;
  OptionEx: TOpenOptionEx;
  OpenFilename: TOpenFilename;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
  begin
    Result := '';
    if S <> '' then
    begin
      Result := S + #0;  // double null terminators
      P := AnsiStrScan(PChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := AnsiStrScan(P, '|');
      end;
    end;
  end;

var
  TempFilter, TempFilename, TempExt: string;
begin
  FFiles.Clear;
  FillChar(OpenFileName, SizeOf(OpenFileName), 0);
  with OpenFilename do
  begin
    if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
    ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
      lStructSize := SizeOf(TOpenFilename)
    else
      lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer); { subtract size of added fields }

    hInstance := SysInit.HInstance;
    TempFilter := AllocFilterStr(FFilter);
    lpstrFilter := PChar(TempFilter);
    nFilterIndex := FFilterIndex;
    FCurrentFilterIndex := FFilterIndex;
    if ofAllowMultiSelect in FOptions then
      nMaxFile := MultiSelectBufferSize else
      nMaxFile := MAX_PATH;
    SetLength(TempFilename, nMaxFile + 2);
    lpstrFile := PChar(TempFilename);
    FillChar(lpstrFile^, nMaxFile + 2, 0);
    StrLCopy(lpstrFile, PChar(FFileName), nMaxFile);
    if (FInitialDir = '') and ForceCurrentDirectory then
      lpstrInitialDir := '.'
    else
      lpstrInitialDir := PChar(FInitialDir);
    lpstrTitle := PChar(FTitle);
    Flags := OFN_ENABLEHOOK;
    FlagsEx := 0;

    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or OpenOptions[Option];
    if NewStyleControls then
    begin
      Flags := Flags xor OFN_EXPLORER;
      if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
        for OptionEx := Low(OptionEx) to High(OptionEx) do
          if OptionEx in FOptionsEx then
            FlagsEx := FlagsEx or OpenOptionsEx[OptionEx]; 
    end
    else
      Flags := Flags and not OFN_EXPLORER;
    TempExt := FDefaultExt;
    if (TempExt = '') and (Flags and OFN_EXPLORER = 0) then
    begin
      TempExt := ExtractFileExt(FFilename);
      Delete(TempExt, 1, 1);
    end;
    if TempExt <> '' then lpstrDefExt := PChar(TempExt);

    lpfnHook := ExplorerHook;

    if Template <> nil then
    begin
      Flags := Flags or OFN_ENABLETEMPLATE;
      lpTemplateName := Template;
    end;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(Func, OpenFileName);
    if Result then
    begin
      GetFileNames(OpenFilename);
      if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
        Include(FOptions, ofExtensionDifferent) else
        Exclude(FOptions, ofExtensionDifferent);
      if (Flags and OFN_READONLY) <> 0 then
        Include(FOptions, ofReadOnly) else
        Exclude(FOptions, ofReadOnly);
      FFilterIndex := nFilterIndex;
    end;
  end;
end;

procedure TMyOpenDialog.GetFileNames(var OpenFileName: TOpenFileName);
var
  Separator: Char;

  function ExtractFileName(P: PChar; var S: TFilename): PChar;
  begin
    Result := AnsiStrScan(P, Separator);
    if Result = nil then
    begin
      S := P;
      Result := StrEnd(P);
    end
    else
    begin
      SetString(S, P, Result - P);
      Inc(Result);
    end;
  end;

  procedure ExtractFileNames(P: PChar);
  var
    DirName, FileName: TFilename;
  begin
    P := ExtractFileName(P, DirName);
    P := ExtractFileName(P, FileName);
    if FileName = '' then
      FFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;

begin
  Separator := #0;
  if (ofAllowMultiSelect in FOptions) and not NewStyleControls then
    Separator := ' ';
  with OpenFileName do
  begin
    if ofAllowMultiSelect in FOptions then
    begin
      ExtractFileNames(lpstrFile);
      FFileName := FFiles[0];
    end else
    begin
      ExtractFileName(lpstrFile, FFileName);
      FFiles.Add(FFileName);
    end;
  end;
end;

function TMyOpenDialog.GetStaticRect: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(GetDlgItem(FHandle, stc32), Result);
    MapWindowPoints(0, FHandle, Result, 2);
  end
  else Result := Rect(0,0,0,0);
end;

function TMyOpenDialog.GetFileName: TFileName;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if NewStyleControls and (FHandle <> 0) then
  begin
    SendMessage(GetParent(FHandle), CDM_GETFILEPATH, SizeOf(Path), Integer(@Path));
    Result := StrPas(Path);
  end
  else Result := FFileName;
end;

function TMyOpenDialog.GetFilterIndex: Integer;
begin
  if FHandle <> 0 then
    Result := FCurrentFilterIndex
  else
    Result := FFilterIndex;
end;

procedure TMyOpenDialog.SetHistoryList(Value: TStrings);
begin
  FHistoryList.Assign(Value);
end;

procedure TMyOpenDialog.SetInitialDir(const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  if (L > 1) and IsPathDelimiter(Value, L)
    and not IsDelimiter(':', Value, L - 1) then Dec(L);
  FInitialDir := Copy(Value, 1, L);
end;

function TMyOpenDialog.Execute: Boolean;
begin
  Result := DoExecute(@GetOpenFileName);
end;

{ TSaveDialog }

function TMySaveDialog.Execute: Boolean;
begin
  Result := DoExecute(@GetSaveFileName);
end;


{ Message dialog }

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

{ Initialization and cleanup }

procedure InitGlobals;
var
  AtomText: array[0..31] of Char;
begin
  HelpMsg := RegisterWindowMessage(HelpMsgString);
  FindMsg := RegisterWindowMessage(FindMsgString);
  WndProcPtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'WndProcPtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
end;

initialization
  InitGlobals;
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TCommonDialog, TControl);
finalization
  if WndProcPtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);
end.
