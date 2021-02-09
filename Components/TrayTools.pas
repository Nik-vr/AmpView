unit TrayTools;

//  Функции для работы с иконкой в трее

{$B-,R-}

interface

uses Windows, ShellAPI, Messages, SysUtils;


const
  WM_NOTIFYTRAYICON = WM_USER + 1111;

procedure AddTrayIcon(AppHandle: Hwnd; Icon: HIcon; Hint: PChar);
procedure DeleteTrayIcon(AppHandle: HWND);
procedure SetNewTrayHint(AppHandle: HWND; Icon: HIcon; NewHint: string);

//var
// TrIcon: hIcon;

implementation

uses Viewer;

// Добавление значка в трей
procedure AddTrayIcon(AppHandle: Hwnd; Icon: HIcon; Hint: PChar);
var
  no: TNotifyIconData;
  temp: string;
begin
  //Помещение иконки в Tray Bar
  with no do
  begin
    cbSize := {$IF CompilerVersion >= 24.0}System.{$IFEND}SizeOf(TNotifyIconData);
    Wnd := AppHandle;
    uID := 0;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallBackMessage := WM_NOTIFYTRAYICON;
    hIcon := Icon;
//    TrIcon:=hIcon;
    temp:= Hint;
    if Length( temp ) > 62 then
     temp := Copy(temp,1,62);
    StrPCopy(szTip, temp);
  end;
  Shell_NotifyIcon(NIM_ADD, Addr(no));
end;



// Удалание значка из трея
procedure DeleteTrayIcon(AppHandle: HWND);
var
  no: TNotifyIconData;
begin
  //Удаление иконки
  with no do
  begin
    cbSize := {$IF CompilerVersion >= 24.0}System.{$IFEND}SizeOf(TNotifyIconData);
    Wnd := AppHandle;
    uID := 0;
  end;
  Shell_NotifyIcon(NIM_Delete, Addr(no));
end;


// Обновление подсказки в трее
procedure SetNewTrayHint(AppHandle: HWND; Icon: HIcon; NewHint: string);
//var
//  no: TNotifyIconData;
///  i: byte;
//  temp: string;
begin
 if AmpViewMainForm.IsEmbedded then exit;
 DeleteTrayIcon(AppHandle);
 AddTrayIcon(AppHandle, Icon, PChar(NewHint));
(*  //Удаление иконки
  with no do
  begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd := AppHandle;
    uID := 0;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallBackMessage := WM_NOTIFYTRAYICON;
    temp:= NewHint;
     if Length( temp ) > 62 then
      temp := Copy(temp,1,62);
    StrPCopy(szTip, temp);
  end;
  Shell_NotifyIcon(NIM_MODIFY, Addr(no));
*)
end;

end.
