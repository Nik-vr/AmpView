library AmpView;

{$R *.res}
{$MODE Delphi}

uses Windows, SysUtils, ShellAPI, classes;


type
  TMyThread = class(TThread) //MyThread - заданное нами имя потока.
  private
    { Private declarations }
    hListerHandle:HWND;
    hAmpViewHandle:HWND;
    hPlayListHandle:HWND;
    ParentHandle:HWND;
    hTApplicationHandle:HWND;
    IsQuickView:boolean;
    parent_class:pointer;
  protected
    constructor Create(suspended:boolean;parent_class:pointer);
    procedure Execute; override;
  end;

type TMyClass = class
  private
    ampviewhandlesbefore:array of HWND;
    MyThread:TMyThread;
  protected
    hListerHandle:HWND;
    hTotalCmdHandle:HWND;
    hContainerHandle:HWND;
    hAmpViewHandle:HWND;
    hPlayListHandle:HWND;
    hTApplicationHandle:HWND;
    FAppThreadID: Cardinal;
    IsQuickView: boolean;
    IsExternalApp:boolean;
    IsDetach:boolean;
    procedure GetAmpViewHandles;
    function GetNewAmpViewHandle:HWND;
    function GetNewPlayListHandle:HWND;
    procedure DoClose;
  end;

const
 PARSE_FUNCTION = 'MULTIMEDIA | EXT="MP3" | EXT="WAV" | EXT="WMA" |'+
                   'EXT="OGG" | EXT="CDA" | EXT="MO3" | EXT="IT" |'+
                   'EXT="XM" | EXT="S3M" | EXT="MOD" | EXT="M3U" |'+
                   'EXT="PLS" | EXT="MID"| EXT="MIDI" | EXT="KAR" |'+
                   'EXT="FLA" | EXT="FLAC" | EXT="MP4" | EXT="M4A" |'+
                   'EXT="MPC" | EXT="AAC" | EXT="AC3" | EXT="OPUS" |'+
                   'EXT="WEBM" | EXT="WV" | EXT="DSF" | EXT="APE"';

 NumOfBaseExt=35;
 BaseExt: array [0..NumOfBaseExt] of string = ('m3u', 'pls', 'mp3',
  'wav', 'wma', 'mp2', 'mp1', 'ogg', 'cda', 'mo3', 'it', 'xm', 's3m',
  'mtm', 'mod', 'umx', 'mid', 'midi', 'kar', 'rmi', 'mpa', 'aiff',
  'aif', 'aifc', 'fla', 'flac', 'mp4', 'm4a', 'mpc', 'aac', 'ac3', 'opus', 'webm', 'wv', 'dsf', 'ape');

var
  wc: TWndClass;
 // I: Integer = 0;
  Lister: Boolean;
  PlugDir: string;        // Папка программы
  CmdLine: string;
  MyClass:array of TMyClass;
  ListerSavedRect:TRect;
  preventloop:boolean;

procedure DebugMessage(Msg: string);
begin
  MessageBox(0, PChar(Msg), PChar('Debug'), MB_OK);
end;

procedure TMyClass.GetAmpViewHandles;
var prev,h:HWND;
begin
SetLength(ampviewhandlesbefore,0);
prev:=0;
  repeat
  h:=FindWindowEx(0,prev,'TAmpViewMainForm',nil);
  if h=0 then exit;
  if FindWindowEx(h,0,'TContainer',nil)>0 then  // form opened in delphi IDE
    begin
    prev:=h;
    continue;
    end;
  SetLength(ampviewhandlesbefore,length(ampviewhandlesbefore)+1);
  ampviewhandlesbefore[high(ampviewhandlesbefore)]:=h;
  prev:=h;
  until h=0;
end;

function TMyClass.GetNewAmpViewHandle:HWND;
var prev,h:HWND;
    found:boolean;
    a:integer;
begin
result:=0;
prev:=0;
found:=false;
  repeat
  h:=FindWindowEx(0,prev,'TAmpViewMainForm',nil);
  if h=0 then exit;
  if FindWindowEx(h,0,'TContainer',nil)>0 then  // form opened in delphi IDE
    begin
    prev:=h;
    continue;
    end;
  for a:=0 to length(ampviewhandlesbefore)-1 do
    begin
    if h=ampviewhandlesbefore[a] then found:=true;
    end;
  if not found then
    begin
    result:=h;
    end;
  prev:=h;
  until h=0;
end;

function TMyClass.GetNewPlayListHandle:HWND;
var prev,h:HWND;
    found:boolean;
    a:integer;
begin
result:=0;
prev:=0;
found:=false;
  repeat
  h:=FindWindowEx(0,prev,'TPlayListForm',nil);
  if h=0 then exit;
  if FindWindowEx(h,0,'TContainer',nil)>0 then  // form opened in delphi IDE
    begin
    prev:=h;
    continue;
    end;
  if GetWindowThreadProcessId(h, nil)=FAppThreadID then found:=true;
  if found then
    begin
    result:=h;
    end;
  prev:=h;
  until h=0;
end;

procedure TMyClass.DoClose;
begin
mythread.Terminate;
//mythread.waitfor; // can f reze
mythread.free;
if not IsExternalApp then
   SendMessage(hAmpViewHandle,$10{WM_CLOSE},0,0);
SendMessage(hContainerHandle,$10{WM_CLOSE},0,0);
// needed to restore window size on plugin change, but actually flickers when close
if (not IsQuickView) and (not IsDetach) then
   SetWindowPos(hListerHandle,0,ListerSavedRect.left,ListerSavedRect.top,ListerSavedRect.Width,ListerSavedRect.Height,SWP_NOZORDER{ or SWP_NOACTIVATE});
// does not work correctly after several plugin switches in lister
// destroy class, recalc array
end;

// Вспомогательные функции (работа с окном Lister)
function WindowProc(wnd:HWND; Msg : Integer; Wparam:Wparam; Lparam:Lparam):Lresult; stdcall;
var
 LW: HWND;
 idd: HWND;
 a:integer;
 threadid:HWND;
 windowstyle:hwnd;
 p:TPoint;
 hampwinRect,hPlayListFormRect:TRect;
 tempparm:longint;
begin
 LW:=GetParent(wnd);
 //PostMessage(LW, $0100, 27, 0); // don't shoot me, i'm a lister
 if (msg=WM_USER+101) then
    begin
    preventloop:=Wparam=1;
    end;
 if not preventloop then
   begin
   if (msg=WM_KEYDOWN) or (msg=WM_KEYUP) then
     begin
     for a:=0 to length(MyClass)-1 do
       begin
       if wnd<>MyClass[a].hContainerHandle then continue;
       PostMessage(MyClass[a].hAmpViewHandle,WM_USER + 101,1,0);
       PostMessage(MyClass[a].hAmpViewHandle,msg,wparam,lparam);
       PostMessage(MyClass[a].hAmpViewHandle,WM_USER + 101,0,0);
       end;
     end;
   end;
 if (msg=WM_ACTIVATE) then
   begin
   if wparam<>WA_INACTIVE then tempparm:=WA_INACTIVE else tempparm:=WA_ACTIVE;
     PostMessage(MyClass[a].hAmpViewHandle,msg,tempparm,lparam);
   end;
 {if (msg=WM_ACTIVATEAPP) then
   begin
   if wparam<>0 then tempparm:=0 else tempparm:=1;
     PostMessage(MyClass[a].hAmpViewHandle,msg,tempparm,lparam);
   end; }
 if (msg=WM_USER+112) then
    begin
    for a:=0 to length(MyClass)-1 do
      begin
      if wnd<>MyClass[a].hContainerHandle then continue;

      GetWindowRect(MyClass[a].hAmpViewHandle,hampwinRect);
      GetWindowRect(MyClass[a].hPlayListHandle,hPlayListFormRect);
      p.x:=0; p.y:=0;
      ClientToScreen(wnd,p);
      Windows.SetParent(MyClass[a].hTApplicationHandle,0);
      Windows.SetParent(MyClass[a].hAmpViewHandle,0);
      Windows.SetParent(MyClass[a].hPlayListHandle,0);
      {windowstyle:=GetWindowLong(MyClass[a].hTApplicationHandle,GWL_EXSTYLE);
      windowstyle:=windowstyle and not WS_EX_TOOLWINDOW;
      ShowWindow(MyClass[a].hTApplicationHandle,SW_HIDE);
      SetWindowLong(MyClass[a].hTApplicationHandle,GWL_EXSTYLE,windowstyle);
      ShowWindow(MyClass[a].hTApplicationHandle,SW_SHOW);   }
      SetWindowPos(MyClass[a].hAmpViewHandle,0,p.x,p.y,hampwinRect.Width,hampwinRect.Height,SWP_NOZORDER{ or SWP_NOACTIVATE});
      SetWindowPos(MyClass[a].hPlayListHandle,0,p.x,p.y+hampwinRect.Height,hPlayListFormRect.Width,hPlayListFormRect.Height,SWP_NOZORDER{ or SWP_NOACTIVATE});
      MyClass[a].IsExternalApp:=true;
      MyClass[a].IsDetach:=true;
      threadid := GetWindowThreadProcessId(MyClass[a].hAmpViewHandle, nil);
      AttachThreadInput(GetCurrentThreadId, threadid, false);
      PostMessage(MyClass[a].hAmpViewHandle,WM_USER + 112,0,0);
      end;
    end;
 Result := DefWindowProc(wnd,msg,wparam,lparam);
end;

function CallKiller(aListerWindow:HWND):HWND;
begin
 //result:=CreateWindowEx(WS_EX_CONTROLPARENT,'AMPVIEW_PLAYER','AMPVIEW_PLAYER',WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS,0,0,10,10,aListerWindow,0,Hinstance,nil);
end;

constructor TMyThread.Create(suspended:boolean;parent_class:pointer);
begin
inherited Create(suspended);
self.parent_class:=parent_class;
end;

procedure TMyThread.Execute;
var prev,h:HWND;
    found:boolean;
begin
  repeat
  if terminated then exit;
  if (ParentHandle=0) and (not IsQuickView) then ShowWindow(hListerHandle,SW_HIDE);
  Sleep(10);

  prev:=0;
  found:=false;
    repeat
    h:=FindWindowEx(ParentHandle,prev,'TAmpViewMainForm',nil);
    if h=0 then break;
    if FindWindowEx(h,0,'TContainer',nil)>0 then  // form opened in delphi IDE
      begin
      prev:=h;
      continue;
      end;
    found:=true;
    break;
    prev:=h;
    until h=0;

  if not found then
    begin
    {if ParentHandle<>0 then // check if detached
      begin                  // doesn't work for the second time
      prev:=0;
      found:=false;
        repeat
        h:=FindWindowEx(0,prev,'TAmpViewMainForm',nil);
        if h=0 then break;
        if FindWindowEx(h,0,'TContainer',nil)>0 then  // form opened in delphi IDE
          begin
          prev:=h;
          continue;
          end;
        found:=true;
        break;
        prev:=h;
        until h=0;
      if found then // detached
        begin
        TMyClass(parent_class^).IsExternalApp:=true;
        //terminate;
        end;
      end;}
    PostMessage(hListerHandle, $0100, 27, 0); // does not work if user holds a key
    //PostMessage(hListerHandle,$10{WM_CLOSE},0,0); // windows pos are not restored
    //terminate;
    //exit;
    end;
  if (ParentHandle<>0) then
    begin                                     // context menus are hiding. not hiding on main window
    if (GetForegroundWindow=hAmpViewHandle){ or (GetForegroundWindow=hPlayListHandle) } then
      begin
      //if IsQuickView then SetForegroundWindow(GetParent(hListerHandle))
      //               else SetForegroundWindow(hListerHandle);
      //SetForegroundWindow(ParentHandle);
      end;
    end;
  until terminated;
end;

procedure SendData(AppHandle, srcAppHandle: hwnd; FileName: string);
const
 WM_COPYDATA         = $004A;
var
 DataStruct: TCopyDataStruct;
 Wparam, LParam: integer;
begin
 // ГЏГ®Г¤ГЈГ®ГІГ®ГўГЄГ  Г±ГІГ°ГіГЄГІГіГ°Г»
 DataStruct.lpData:=PChar(FileName);
 DataStruct.cbData:=Length(FileName);
 DataStruct.dwData:=0;
 // ГЏГ Г°Г Г¬ГҐГІГ°Г» Г±Г®Г®ГЎГ№ГҐГ­ГЁГї
 WParam:=srcAppHandle;
 LParam:=Integer(@DataStruct);
 // ГЋГІГЇГ°Г ГўГЄГ  Г±Г®Г®ГЎГ№ГҐГ­ГЁГї Г± Г¤Г Г­Г­Г»Г¬ГЁ
 if AppHandle<>0 then SendMessage(AppHandle, WM_CopyData, WParam, LParam);
end;

// Выполняется при загрузке плагина в Lister
function ListLoad(ParentWin: HWND;  FileToLoad: pchar;  ShowFlags: integer): HWND; stdcall;
var
  PlayerExe: string;
  FileExt: string;
  st: DWORD;
  StartPlayer: byte;
  i: integer;
  windowstyle:integer;
  hampwinRect,hPlayListFormRect,hlisterclientrect,hlisterrect:TRect;
  tw,th:integer;
  listerstyle:longint;
  lister_has_menu:bool;
  hMutex:HWND;
  tmpqv:integer;
  cln:array[0..255] of char;
begin
 // Окно Lister'а
 Result:=0;
 StartPlayer:= 0;
 Lister:=GetParent(ParentWin)=0;

 // Исполнимый файл проигрывателя
 PlugDir:=ExtractFileDir( GetModuleName(hInstance));
 PlayerExe:=PlugDir+'\AmpView.exe';

 // Проверяем расширение файла
 FileExt:=ExtractFileExt(FileToLoad);
 FileExt:=Copy(FileExt, 2, Length(FileExt));
 if FileExt='' then exit; // если расширение не получено - сразу выходим

 // Проверка базовых расширений
 FileExt:=LowerCase(FileExt);
 for i:=0 to NumOfBaseExt do
  if (FileExt = BaseExt[i]) then
   begin
    StartPlayer:=1; break;
   end
   else StartPlayer:=0;

 //
 case StartPlayer of
 // Если передан "левый" файл - выходим, передав управление TC
 0: begin
     result:=0;
     exit;
    end;
 // Если расширение подходящее - запускаем плеер и передам путь к файлу
 1: begin
    //hAmpWin := 0;//сюда будет записывать дескриптор найденного окна
    setlength(MyClass,length(MyClass)+1);
    MyClass[high(MyClass)]:=TMyClass.Create;
    with MyClass[high(MyClass)] do
      begin
      IsQuickView:=not Lister;
      hListerHandle:=ParentWin;
      if not IsQuickView then
        if (ListerSavedRect.Width=0) or (ListerSavedRect.Height=0) then GetWindowRect(ParentWin,ListerSavedRect);
      hTotalCmdHandle:=GetParent(ParentWin);
      hContainerHandle:=CreateWindowEx(WS_EX_CONTROLPARENT,'AMPVIEW_PLAYER','AMPVIEW_PLAYER',WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS,0,0,0,0,ParentWin,0,Hinstance,nil);
      Result:=hContainerHandle;

      IsExternalApp:=false;
      IsDetach:=false;
      MyThread:=TMyThread.Create(true,MyClass);
      MyThread.FreeOnTerminate:=false;
      MyThread.hListerHandle:=hListerHandle;
      MyThread.IsQuickView:=IsQuickView;
      try
      hMutex:= CreateMutex(nil, true , 'AmpView_MediaPlayer');
      if GetLastError = ERROR_ALREADY_EXISTS then
        begin
        hAmpViewHandle:=GetNewAmpViewHandle;
        if hAmpViewHandle>0 then
          begin
          IsExternalApp:=true;
          if not IsQuickView then
            begin
            ShowWindow(hListerHandle,SW_HIDE);
            SetWindowPos(hListerHandle, 0, -100, -100, 0, 0, SWP_HIDEWINDOW);
            SetForegroundWindow(hAmpViewHandle);
            end;
          SendData(hAmpViewHandle,hListerHandle, FileToLoad);
            {end
          else
            begin
            exit;
            end;}
          MyThread.ParentHandle:=0;
          end;
        end;
      finally
      CloseHandle(hMutex);
      end;
      if not IsExternalApp then
        begin
        GetAmpViewHandles;
        ShellExecute(0, nil, PChar(PlayerExe), PChar('\n "'+FileToLoad+'"'), nil, SW_SHOW);// <> 0 then
        st:=GetTickCount();
        hAmpViewHandle:=0;
        while (GetTickCount() - st < 2000) and (hAmpViewHandle=0) do
          begin
          hAmpViewHandle:=GetNewAmpViewHandle;
          Sleep(1);
          end;
        //sleep(2000); // ждём, пока AmpView откроет файл
        if hAmpViewHandle>0 then
          begin
          MyThread.hAmpViewHandle:=hAmpViewHandle;
          hTApplicationHandle:=GetParent(hAmpViewHandle);
          Windows.SetParent(hTApplicationHandle,hContainerHandle);
          {windowstyle:=GetWindowLong(hTApplicationHandle,GWL_EXSTYLE);
          windowstyle:=windowstyle or WS_EX_TOOLWINDOW;
          ShowWindow(hTApplicationHandle,SW_HIDE);
          SetWindowLong(hTApplicationHandle,GWL_EXSTYLE,windowstyle); }
          // loses focus
          //SetForegroundWindow(hListerHandle);
          //hlistcontainer := CallKiller(ParentWin);

          /// Attach container app input thread to the running app input thread, so that
          ///  the running app receives user input.
          FAppThreadID := GetWindowThreadProcessId(hAmpViewHandle, nil);
          AttachThreadInput(GetCurrentThreadId, FAppThreadID, True);

          Windows.SetParent(hAmpViewHandle,hContainerHandle);

          GetWindowRect(hAmpViewHandle,hampwinRect);

          /// Make the running app to fill all the client area of the container
          SetWindowPos(hAmpViewHandle,0,0,0,hampwinRect.right-hampwinRect.left,hampwinRect.bottom-hampwinRect.top,SWP_NOZORDER{ or SWP_NOACTIVATE});

          GetWindowRect(hAmpViewHandle,hampwinRect);

          hPlayListHandle:=GetNewPlayListHandle;

          hPlayListFormRect:=rect(0,0,0,0);

          if hPlayListHandle>0 then
            begin
            Windows.SetParent(hPlayListHandle,hContainerHandle);
            GetWindowRect(hPlayListHandle,hPlayListFormRect);
            /// Make the running app to fill all the client area of the container
            //SetWindowPos(hPlayListForm, HWND_TOP, 0,  0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
            SetWindowPos(hPlayListHandle,0,0,hampwinRect.bottom-hampwinRect.top,hPlayListFormRect.right-hPlayListFormRect.left,hPlayListFormRect.bottom-hPlayListFormRect.top,SWP_NOZORDER{ or SWP_NOACTIVATE});

            GetWindowRect(hPlayListHandle,hPlayListFormRect);
            end;

          MyThread.hPlayListHandle:=hPlayListHandle;
          MyThread.ParentHandle:=hContainerHandle;

          listerstyle:=GetWindowLong(ParentWin,GWL_STYLE);
          lister_has_menu:=GetMenu(ParentWin)<>0;
          if not IsQuickView then
            begin
            GetClientRect(ParentWin,hlisterclientrect);
            tw:=hampwinRect.right-hampwinRect.left;
            th:=hampwinRect.bottom-hampwinRect.top + hPlayListFormRect.bottom-hPlayListFormRect.top;
            hlisterclientrect.Width:=tw;
            hlisterclientrect.Height:=th;
            AdjustWindowRect(hlisterclientrect,listerstyle,lister_has_menu);
            GetWindowRect(ParentWin,hlisterrect);
            SetWindowPos(ParentWin,0,hlisterrect.left,hlisterrect.top,hlisterclientrect.Right-hlisterclientrect.Left,hlisterclientrect.bottom-hlisterclientrect.top,SWP_NOZORDER{ or SWP_NOACTIVATE});
            end;

         tmpqv:=0;
         if IsQuickView then tmpqv:=1;
         PostMessage(hAmpViewHandle,WM_USER + 111,tmpqv,0);

         //GetClassName(getforegroundwindow,cln,255);
         //DebugMessage('foregr '+string(cln));


         {st:=GetTickCount();
         while (GetTickCount() - st < 1000) and (GetForegroundWindow<>hAmpViewHandle) and (GetForegroundWindow<>hPlayListHandle) do
           begin
           Sleep(1);
           end;  }
         //GetClassName(getforegroundwindow,cln,255);
         //DebugMessage('foregr '+string(cln));


         // loses focus
         if not IsQuickView then
           begin
           SetForegroundWindow(hContainerHandle);
           SetForegroundWindow(hListerHandle);
           SetActiveWindow(hContainerHandle);
           SetActiveWindow(hListerHandle);
           //SetFocus(hContainerHandle);
           //SetFocus(hListerHandle);
           end;
         if IsQuickView then
           begin
           SetForegroundWindow(hTotalCmdHandle);
           SetActiveWindow(hTotalCmdHandle);
           //SetFocus(hTotalCmdHandle);
           end;

         end; // hampviewhandle>0
        end; // alreadyexists

       /// Changing parent of the running app to our provided container control
       //SendMessage(hContainerHandle, WM_UPDATEUISTATE, UIS_INITIALIZE, 0);
       //UpdateWindow(hAmpViewHandle);
       //UpdateWindow(hPlayListHandle);

       /// This prevents the parent control to redraw on the area of its child windows (the running app)
       //  SetWindowLong(hlistcontainer, GWL_STYLE, GetWindowLong(hlistcontainer,GWL_STYLE) or WS_CLIPCHILDREN);

       //ShowWindow(ParentWin,SW_HIDE);
       //result:=hAmpWin;

       MyThread.Resume;

       end; // myclass
     if Result = 0 then Exit;
    end; // startplayer
 end; // case

end;


procedure ListCloseWindow(ListWin:HWND); stdcall;
var a:integer;
begin
for a:=0 to length(MyClass)-1 do
  begin
  if ListWin<>MyClass[a].hContainerHandle then continue;
  MyClass[a].DoClose;
  end;
end;

// Отправка Lister'у строки-определителя
// (указывает, файлы с какими расширениями нужно отдавать данному плагину).
// Строка-определитель задана константой PARSE_FUNCTION в начале этого модуля
procedure ListGetDetectString(DetectString: pchar; maxlen: integer); stdcall;
begin
 StrLCopy(DetectString, PChar(PARSE_FUNCTION), MaxLen);
end;


// Экспорт процедур
exports
 ListLoad,
 ListCloseWindow,
 ListGetDetectString;


// Создание окна Lister'а
begin
  WC.lpfnWndProc     := @WindowProc;
  WC.style           := CS_VREDRAW or CS_HREDRAW;
  WC.hInstance       := hInstance;
  WC.hIcon           := 0;
  WC.hCursor         := LoadCursor(0,IDC_ARROW);
  WC.hbrBackground   := CreateSolidBrush( COLOR_BTNFACE+1 );
  WC.lpszMenuName    := nil;
  WC.cbClsExtra      := 0;
  WC.cbWndExtra      := 0;
  wc.lpszClassName   := 'AMPVIEW_PLAYER';
  Windows.RegisterClass(wc);
end.


