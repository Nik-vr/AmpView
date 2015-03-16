program AmpView;

uses
  Forms,
  Windows,
  SysUtils,
  Options,
  Viewer in 'Viewer.pas' {AmpViewMainForm},
  Grids in 'Components\Grids.pas',
  PlayList in 'PlayList.pas' {PlayListForm},
  PlayListClass in 'Components\PlayListClass.pas',
  Equal in 'Equal.pas' {EqForm};

{$R *.res}

var
  Handle1 : LongInt;
  hMutex: hwnd;


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


begin
  hMutex:= CreateMutex(nil, true , 'AmpView_MediaPlayer');
  if GetLastError = ERROR_ALREADY_EXISTS then
   begin
    Handle1 := FindWindow('TAmpViewMainForm',nil);
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
    Application.CreateForm(TAmpViewMainForm, AmpViewMainForm);
  Application.CreateForm(TPlayListForm, PlayListForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(TEqForm, EqForm);
  Application.Run;
   end;

end.
