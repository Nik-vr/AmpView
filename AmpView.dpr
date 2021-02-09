program AmpView;

uses
  Forms,
  Windows,
  SysUtils,
  Options in 'Options.pas' {OptionsForm},
  Viewer in 'Viewer.pas' {AmpViewMainForm},
  Grids in 'Components\Grids.pas',
  PlayList in 'PlayList.pas' {PlayListForm},
  PlayListClass in 'Components\PlayListClass.pas',
  Equal in 'Equal.pas' {EqForm},
  FileInfo in 'FileInfo.pas' {FileInfoForm};

{$R *.res}

var
  Handle1 : LongInt;
  hMutex: hwnd;
  style:LongInt;


procedure SendData(AppHandle: hwnd; FileName: string);
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
 WParam:=Application.Handle;
 LParam:=Integer(@DataStruct);
 // ГЋГІГЇГ°Г ГўГЄГ  Г±Г®Г®ГЎГ№ГҐГ­ГЁГї Г± Г¤Г Г­Г­Г»Г¬ГЁ
 if AppHandle<>0 then SendMessage(AppHandle, WM_CopyData, WParam, LParam);
end;

//цикл по всем окнам Windows
function EnumWindowsWnd(h: HWND; L: LPARAM): BOOL; stdcall;
var
   class1,title1 : array[0 .. 255] of Char;
begin
  result:=true;
   GetWindowText(h, title1, 256);//получаем заголовок окна
   GetClassName(h, class1, 256);

   //текст, который может содержаться в заголовке
   if class1='TAmpViewMainForm' then
   begin
     if FindWindowEx(h,0,'TContainer',nil)>0 then // form opened in delphi IDE
       begin
       result:=true;
       Exit;
       end;
     Handle1:=h;
     //Exit(false);//усё, кина не будет, цикл завершить, т.к. окно найдено
     result:=false;
     exit;
   end
   else
     begin
     result:=true;
     Exit;//переход к следующему окну
     end;
end;

begin
  hMutex:= CreateMutex(nil, true , 'AmpView_MediaPlayer');
  if GetLastError = ERROR_ALREADY_EXISTS then
   begin
    Handle1:=0;
    EnumWindows(@EnumWindowsWnd, 0);
    //Handle1 := FindWindow('TAmpViewMainForm',nil);
    // ГЂГЄГІГЁГўГЁГ§ГЁГ°ГіГҐГ¬ Г®ГЄГ­Г® ГЇГ°ГҐГ¤Г»Г¤ГіГ№ГҐГ© ГЄГ®ГЇГЁГЁ
    if ParamStr(1)='\n' then SetForegroundWindow(Handle1);
    // ГЋГІГЇГ°Г ГўГ«ГїГҐГ¬ ГЁГ¬Гї ГґГ Г©Г«Г  ГЇГ°ГҐГ¤Г»Г¤ГіГ№ГҐГ© ГЄГ®ГЇГЁГЁ
    SendData(Handle1, ParamStr(2));
    CloseHandle(hMutex);
    Application.Terminate;
//    MessageBox(0, 'Ошибка!', '', 0);
   end
  else
   begin
    Application.Initialize;
    Application.Title := 'AmpView';

    if ParamCount>0 then // an easy way to check if it's embedded, if not, return button on form show
      begin
      style := GetWindowLong(Application.Handle, GWL_EXSTYLE);
      SetWindowLong(Application.Handle, GWL_EXSTYLE, style OR WS_EX_TOOLWINDOW);
      end;

    Application.CreateForm(TAmpViewMainForm, AmpViewMainForm);
    AmpViewMainForm.hMutex:=hMutex;
  Application.CreateForm(TPlayListForm, PlayListForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(TEqForm, EqForm);
  Application.CreateForm(TFileInfoForm, FileInfoForm);
  Application.Run;
  end;

end.
