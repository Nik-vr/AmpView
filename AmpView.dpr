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
 // Ïîäãîòîâêà ñòðóêòóðû
 DataStruct.lpData:=PChar(FileName);
 DataStruct.cbData:=Length(FileName);
 DataStruct.dwData:=0;
 // Ïàðàìåòðû ñîîáùåíèÿ
 WParam:=Application.Handle;
 LParam:=Integer(@DataStruct);
 // Îòïðàâêà ñîîáùåíèÿ ñ äàííûìè
 if AppHandle<>0 then SendMessage(AppHandle, WM_CopyData, WParam, LParam);
end;

//���� �� ���� ����� Windows
function EnumWindowsWnd(h: HWND; L: LPARAM): BOOL; stdcall;
var
   class1,title1 : array[0 .. 255] of Char;
begin
  result:=true;
   GetWindowText(h, title1, 256);//�������� ��������� ����
   GetClassName(h, class1, 256);

   //�����, ������� ����� ����������� � ���������
   if class1='TAmpViewMainForm' then
   begin
     if FindWindowEx(h,0,'TContainer',nil)>0 then // form opened in delphi IDE
       begin
       result:=true;
       Exit;
       end;
     Handle1:=h;
     //Exit(false);//��, ���� �� �����, ���� ���������, �.�. ���� �������
     result:=false;
     exit;
   end
   else
     begin
     result:=true;
     Exit;//������� � ���������� ����
     end;
end;

begin
  hMutex:= CreateMutex(nil, true , 'AmpView_MediaPlayer');
  if GetLastError = ERROR_ALREADY_EXISTS then
   begin
    Handle1:=0;
    EnumWindows(@EnumWindowsWnd, 0);
    //Handle1 := FindWindow('TAmpViewMainForm',nil);
    // Àêòèâèçèðóåì îêíî ïðåäûäóùåé êîïèè
    if ParamStr(1)='\n' then SetForegroundWindow(Handle1);
    // Îòïðàâëÿåì èìÿ ôàéëà ïðåäûäóùåé êîïèè
    SendData(Handle1, ParamStr(2));
    CloseHandle(hMutex);
    Application.Terminate;
//    MessageBox(0, '������!', '', 0);
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
