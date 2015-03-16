library AmpView;

{$MODE Delphi}

uses Windows, SysUtils;

const
 PARSE_FUNCTION = 'MULTIMEDIA | EXT="MP3" | EXT="WAV" | EXT="WMA" |'+
                   'EXT="OGG" | EXT="CDA" | EXT="MO3" | EXT="IT" |'+
                   'EXT="XM" | EXT="S3M" | EXT="MOD" | EXT="M3U" |'+
                   'EXT="PLS" | EXT="MID"| EXT="MIDI" | EXT="KAR"';

 NumOfBaseExt=19;
 BaseExt: array [0..NumOfBaseExt] of string = ('m3u', 'pls', 'mp3',
  'wav', 'wma', 'mp2', 'mp1', 'ogg', 'cda', 'mo3', 'it', 'xm', 's3m',
  'mtm', 'mod', 'umx', 'mid', 'midi', 'kar', 'rmi');

var
  wc: TWndClass;
 // I: Integer = 0;
  Lister: Boolean;
  PlugDir: string;        // Папка программы
  CmdLine: string;


procedure DebugMessage(Msg: string);
begin
  MessageBox(0, PChar(Msg), PChar('Debug'), MB_OK);
end;

// Вспомогательные функции (работа с окном Lister)
function WindowProc(wnd:HWND; Msg : Integer; Wparam:Wparam; Lparam:Lparam):Lresult; stdcall;
var
 LW: HWND;
begin
 LW:=GetParent(wnd);
 PostMessage(LW, $0100, 27, 0);
 Result := DefWindowProc(wnd,msg,wparam,lparam);
end;
function CallKiller(aListerWindow:HWND):HWND;
begin
 result:=CreateWindowEx(WS_EX_CONTROLPARENT,'AMPVIEW_PLAYER','AMPVIEW_PLAYER',WS_CHILD or WS_VISIBLE or WS_CLIPSIBLINGS,0,0,10,10,aListerWindow,0,Hinstance,nil);
end;


// Выполняется при загрузке плагина в Lister
function ListLoad(ParentWin: HWND;  FileToLoad: pchar;  ShowFlags: integer): HWND; stdcall;
var
  PlayerExe: string;
  FileExt: string;
  StartPlayer: byte = 0;
  i: integer;
begin
 // Окно Lister'а
 Result:=0;
 Lister:=GetParent(ParentWin)=0;

 // Исполнимый файл проигрывателя
 PlugDir:=ExtractFileDir( GetModuleName(hInstance));
 PlayerExe:=PlugDir+'\AmpView.exe';

 // Проверяем расширение файла
 FileExt:=ExtractFileExt(FileToLoad);
 FileExt:=Copy(FileExt, 2, Length(FileExt));
 if FileExt='' then exit; // если расширение не получено - сразу выходим

 // Проверка базовых расширений
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
     ShellExecute(0, nil, PChar(PlayerExe), PChar('\n "'+FileToLoad+'"'), nil, 5);// <> 0 then
     sleep(2000); // ждём, пока AmpView откроет файл
     SetWindowPos(ParentWin, 0, -100, -100, 0, 0, SWP_HIDEWINDOW);
     Result := CallKiller(ParentWin);
     if Result = 0 then Exit;

    end;
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


