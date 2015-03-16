unit Options;

interface

uses Windows, SysUtils, Forms, StdCtrls, ComCtrls, ActnList, Classes,
     Controls, xIni, ShellAPI, ExtCtrls, HotKeyTools, Graphics;

type
  TOptionsForm = class(TForm)
    CloseButton: TButton;
    ActionList1: TActionList;
    ActionCancel: TAction;
    OptionsPages: TPageControl;
    PageInterface: TTabSheet;
    PagePlugins: TTabSheet;
    PageSkins: TTabSheet;
    LanguageBox: TGroupBox;
    LabelSelectLanguage: TLabel;
    LangComboBox: TComboBox;
    EffectsBox: TGroupBox;
    UseShadows: TCheckBox;
    UseAntiAliasing: TCheckBox;
    TranslatorBox: TGroupBox;
    TranslatorLabel: TLabel;
    TranslatorEmailLabel: TLabel;
    OptionsList: TListBox;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    RewindStepBox: TGroupBox;
    StepEdit: TEdit;
    ScrollStep: TUpDown;
    SkinPages: TPageControl;
    TabSheet1: TTabSheet;
    SkinBox: TGroupBox;
    SkinList: TListBox;
    InformationBox: TGroupBox;
    SkinAutorLabel: TLabel;
    SkinEmailLabel: TLabel;
    SkinDescLabel: TLabel;
    SkinHomePageLabel: TLabel;
    TabSheet7: TTabSheet;
    FontBox: TGroupBox;
    IgnoreSkinFontCheckBox: TCheckBox;
    SampleBox: TGroupBox;
    SampleLabel: TLabel;
    FontComboBox: TComboBox;
    FontSizeComboBox: TComboBox;
    ListerGroupBox: TGroupBox;
    NotQVCheckBox: TCheckBox;
    NotNVCheckBox: TCheckBox;
    HotKeysPages: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    HotKeyGroupBox: TGroupBox;
    GlobalBox: TGroupBox;
    PressKeyBox1: TGroupBox;
    HotKeyEdit: THotKey;
    PressKeyBox2: TGroupBox;
    GlobalHotKeyEdit: THotKey;
    TabSheet10: TTabSheet;
    MouseBox: TGroupBox;
    UseControl: TCheckBox;
    TabSheet5: TTabSheet;
    OnEndTrackBox: TRadioGroup;
    FormatTrackBox: TGroupBox;
    FSEdit: TEdit;
    OtherGroupBox: TGroupBox;
    WarningCheckBox: TCheckBox;
    PluginsBox: TGroupBox;
    PluginsList: TListBox;
    ExtGroupBox: TGroupBox;
    ExtListBox: TListBox;
    ExtEdit: TEdit;
    DeleteBtn: TButton;
    AddBtn: TButton;
    HotKeysBox: TListView;
    GlobalKeysBox: TListView;
    HotKeyList: TListBox;
    GHotKeysList: TListBox;
    ConfigGroupBox: TGroupBox;
    DefaultConfigCheckBox: TCheckBox;
    ScrollBox1: TScrollBox;
    procedure WarningCheckBoxClick(Sender: TObject);
    procedure LangComboBoxChange(Sender: TObject);
    procedure ActionCancelExecute(Sender: TObject);
    procedure SkinListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TranslatorEmailLabelClick(Sender: TObject);
    procedure UseShadowsClick(Sender: TObject);
    procedure UseAntiAliasingClick(Sender: TObject);
    procedure ScrollStepUpDownChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure SkinEmailLabelClick(Sender: TObject);
    procedure SkinHomePageLabelClick(Sender: TObject);
    procedure OptionsListClick(Sender: TObject);
    procedure OnEndTrackBoxClick(Sender: TObject);
    procedure FontComboBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure IgnoreSkinFontCheckBoxClick(Sender: TObject);
    procedure FontComboBoxChange(Sender: TObject);
    procedure FontSizeComboBoxChange(Sender: TObject);
    procedure NotQVCheckBoxClick(Sender: TObject);
    procedure NotNVCheckBoxClick(Sender: TObject);
    procedure HotKeyEditChange(Sender: TObject);
    procedure GlobalHotKeyEditChange(Sender: TObject);
    procedure UseControlClick(Sender: TObject);
    procedure FSEditChange(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ExtListBoxClick(Sender: TObject);
    procedure HotKeysBoxSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure GlobalKeysBoxSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TabSheet8Show(Sender: TObject);
    procedure DefaultConfigCheckBoxClick(Sender: TObject);
  private
    procedure GetSkinsList;
    procedure EnableFontControls(enable: boolean);
    function GetActionText(aName: string): string;
    procedure GetExtList;
    procedure SaveExtList;
    procedure DrawHKList;
    procedure DrawGHKList;
  public
  end;

var
  OptionsForm: TOptionsForm;
  LangFiles: TStringList;
  SkinFiles: TStringList;
  InPlugins: TStringList;
  OutPlugins: TStringList;
  ExtList: TStringList;
  HKItem: integer;

implementation

uses MyTools, Viewer, SkinTypes, Menus, PlayList, ProgressBar32;

{$R *.dfm}

// Отображение окна опций
procedure TOptionsForm.FormShow(Sender: TObject);
var
 i, x: integer;
 SR: TSearchRec;
 temp: string;
begin
 //
 SetWindowPos(OptionsForm.Handle, HWND_TOP, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

 SkinPages.ActivePageIndex:=0;

 // Список языков
 LangComboBox.Clear;
 LangFiles:=TStringList.Create;
 i := FindFirst(PlugDir+'\Language\*.lng', faAnyFile, SR);
  while i = 0 do
   begin
    LangFiles.Add(PlugDir+'\Language\'+SR.Name);
    LangComboBox.Items.Add(Copy(SR.Name, 1, Length(SR.Name)-4));
    i := FindNext(SR);
   end;
  FindClose(SR);
  LangComboBox.ItemIndex:=0;

  // Список шкурок
  SkinFiles:=TStringList.Create;
  i := FindFirst(PlugDir+'\Skins\*.avsz', faAnyFile, SR);
  while i = 0 do
   begin
    temp:=PlugDir+'\Skins\'+SR.Name;
    SkinFiles.Add(temp);
    i := FindNext(SR);
   end;
  FindClose(SR);
  GetSkinsList;

  //
  PluginsList.Clear;
  i := FindFirst(PlugDir+'\Formats\bass*.dll', faAnyFile, sR);
  while i = 0 do
  begin
    PluginsList.Items.Add(SR.Name);
    i := FindNext(sR);
  end;
  FindClose(sR);

  // Шрифты
  x:=Screen.Fonts.Count-1;
  for i:=0 to x do
   begin
    FontComboBox.Items.Add(Screen.Fonts[i]);
   end;

  GetExtList;

  // Окно
  SetWindowPos(Handle, HWND_TOPMOST, Left,  Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  x:=OptionsPages.PageCount-1;
  for i:=0 to x do OptionsPages.Pages[i].TabVisible:=false;
  OptionsList.ItemIndex:=GetIniInt('main', 'OptionsPage', 0, 0, 4, IniFile);
  OptionsPages.ActivePageIndex:=OptionsList.ItemIndex;

  OptionsPages.Width:=425;
  Width:=10+OptionsList.Width+5+OptionsPages.Width+10;
  CloseButton.Left:=Width-CloseButton.Width-20;

 // Язык
  x:=LangFiles.Count-1;
  for i:=0 to x do
   if LowerCase( GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile) )=LowerCase( ExtractFileName( LangFiles[i] ) )
    then LangComboBox.ItemIndex:=i;
  if LangFiles.Count>0
   then SetIniString('main', 'language', ExtractFileName(LangFiles[LangComboBox.ItemIndex]), IniFile);
  if LangFiles.Count<=0 then LangComboBox.Enabled:=false;

  // Опции
  ScrollStep.Position:=GetIniInt('main', 'ScrollStep', 5, 1, 50, IniFile);
  UseShadows.Checked:=GetIniBool('main', 'UseShadows', false, IniFile);
  UseAntiAliasing.Checked:=GetIniBool('main', 'UseAntiAliasing', false, IniFile);
  OnEndTrackBox.ItemIndex:=GetIniInt('main', 'OnEndAction', 1, 0, 4, IniFile);
  UseControl.Checked:=GetIniBool('main', 'UseControl', true, IniFile);

  FSEdit.Text:=GetIniString('main', 'FormatString', '%ARTI - %TITL', IniFile);

  //
  case GetIniInt('main', 'LiteMode', 0, 0, 2, IniFile) of
   0: begin
       NotQVCheckBox.Checked:=false;
       NotQVCheckBox.Enabled:=true;
       NotNVCheckBox.Checked:=false;
       NotNVCheckBox.Enabled:=true;
      end;
   1: begin
       NotQVCheckBox.Checked:=true;
       NotQVCheckBox.Enabled:=true;
       NotNVCheckBox.Checked:=false;
       NotNVCheckBox.Enabled:=false;
      end;
   2:  begin
       NotQVCheckBox.Checked:=false;
       NotQVCheckBox.Enabled:=false;
       NotNVCheckBox.Checked:=true;
       NotNVCheckBox.Enabled:=true;
      end;
  end;
   
  // шкурка
  SkinList.ItemIndex:=0;
  x:=SkinList.Items.Count-1;
  for i:=0 to x do
   begin
    if LowerCase( GetIniString('main', 'skin', 'Lister.avsz', IniFile))=LowerCase( SkinList.Items[i]+'.avsz' )
     then SkinList.ItemIndex:=i;
   end;

  SkinDescLabel.Caption:=SkinText.Description;
  SkinAutorLabel.Caption:=SkinText.Author;
  SkinEmailLabel.Caption:=SkinText.Email;
  SkinHomePageLabel.Caption:=SkinText.HomePage;

  // Шрифты
  x:=Screen.Fonts.Count-1;
  for i:=0 to x do
   begin
    if GetIniString('main', 'PLFontName', 'Arial', IniFile)=Screen.Fonts[i]
     then FontComboBox.ItemIndex:=i;
   end;
  SampleLabel.Font.Name:=FontComboBox.Items[FontComboBox.ItemIndex];
  IgnoreSkinFontCheckBox.Checked:=GetIniBool('main', 'IgnorePLFont', false, IniFile);

  x:=FontSizeComboBox.Items.Count-1;
  for i:=0 to x do
   begin
    if GetIniInt('main', 'PLFontSize', 10, 6, 22, IniFile)=StrToInt(FontSizeComboBox.Items[i])
     then FontSizeComboBox.ItemIndex:=i;
   end;

  SampleLabel.Font.Size:=GetIniInt('main', 'PLFontSize', 10, 6, 22, IniFile);
  EnableFontControls(IgnoreSkinFontCheckBox.Checked);

 DrawHKList;
 DrawGHKList;

end;


// Выбор языка из списка
procedure TOptionsForm.LangComboBoxChange(Sender: TObject);
begin
  SetIniString('main', 'language', ExtractFileName( LangFiles[LangComboBox.ItemIndex] ), IniFile);
  AmpViewMainForm.LoadLang(PlugDir+'\Language\'+GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile));
end;


// Закрытие окна
procedure TOptionsForm.ActionCancelExecute(Sender: TObject);
begin
  Close;
end;


// Навигация по дереву опций
procedure TOptionsForm.OptionsListClick(Sender: TObject);
begin
 if OptionsList.ItemIndex>=0 then
  if OptionsList.ItemIndex<=OptionsPages.PageCount then
  OptionsPages.ActivePageIndex:=OptionsList.ItemIndex;
end;


// Составление списка шкурок
procedure TOptionsForm.GetSkinsList;
var
 i: integer;
 temp: string;
 x: integer;
begin
 SkinList.Clear;
 x:=SkinFiles.Count-1;
 for i:=0 to x do
  begin
   temp:=ExtractFileName(SkinFiles[i]);
   SkinList.Items.Add(Copy(temp, 1, Length(temp)-5));
  end;
end;

procedure TOptionsForm.SkinListClick(Sender: TObject);
var
 len: integer;
 temp_pos: integer;
begin
 // Запись нового значения в файл настройки
 if SkinList.Count>=0
  then SetIniString('main', 'skin', ExtractFileName(SkinFiles[SkinList.ItemIndex]), IniFile);

 // Загрузка шкурки
 with AmpViewMainForm do
  begin
   temp_pos:=ProgressBar.Position;
   LoadSkin(SkinFiles[SkinList.ItemIndex]);
   VolumeBar.Position:=VolumeBar.Position;
   ProgressBar.Position:=temp_pos;
   len:=GetTextWidth(TrackCaptionImage.Canvas.Handle, SkinText.TrackCaption, false);
   CaptionOffset:=(TrackCaptionImage.Width-len) div 2;
   DrawCaption(CaptionOffset);
  end;

 PlayListForm.Width:=PlayListForm.Width+1;
 PlayListForm.Width:=PlayListForm.Width-1;

 // Информация о шкурке SkinDescLabel.Caption:=SkinText.Description;
 SkinAutorLabel.Caption:=SkinText.Author;

 SkinEmailLabel.Caption:=SkinText.Email;
 SkinHomePageLabel.Caption:=SkinText.HomePage;
end;


procedure TOptionsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetIniInt('main', 'OptionsPage', OptionsPages.ActivePageIndex, IniFile);
  SetIniInt('main', 'ScrollStep', ScrollStep.Position, IniFile);
  //
  ModalResult:=mrCancel;
  BringwindowToTop(AmpViewMainForm.Handle);
  AmpViewMainForm.LoadHotKeys(KeysFile);
  AmpViewMainForm.SetFocus;
  AmpViewMainForm.ActionList.State:=asNormal;
end;

procedure TOptionsForm.TranslatorEmailLabelClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('mailto:'+TranslatorEmailLabel.Caption), nil, nil, SW_SHOW);
end;

procedure TOptionsForm.UseShadowsClick(Sender: TObject);
var
 len: integer;
begin
 SetIniBool('main', 'UseShadows', UseShadows.Checked, IniFile);

 // Загрузка шкурки
 with AmpViewMainForm do
  begin
   DrawInfo;  
   len:=GetTextWidth(TrackCaptionImage.Canvas.Handle, SkinText.TrackCaption, false);
   CaptionOffset:=(TrackCaptionImage.Width-len) div 2;
   DrawCaption(CaptionOffset);
  end;

end;

procedure TOptionsForm.UseAntiAliasingClick(Sender: TObject);
var
 len: integer;
begin
 SetIniBool('main', 'UseAntiAliasing', UseAntiAliasing.Checked, IniFile);

 // Загрузка шкурки
 with AmpViewMainForm do
  begin
   DrawInfo;  
   len:=GetTextWidth(TrackCaptionImage.Canvas.Handle, SkinText.TrackCaption, false);
   CaptionOffset:=(TrackCaptionImage.Width-len) div 2;
   DrawCaption(CaptionOffset);
  end;

end;

procedure TOptionsForm.ScrollStepUpDownChanging(Sender: TObject; var AllowChange: Boolean);
begin
  SetIniInt('main', 'ScrollStep', ScrollStep.Position, IniFile);
end;

procedure TOptionsForm.SkinEmailLabelClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('mailto:'+TranslatorEmailLabel.Caption), nil, nil, SW_SHOW);
end;

procedure TOptionsForm.SkinHomePageLabelClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(SkinHomePageLabel.Caption), nil, nil, SW_SHOW);
end;


procedure TOptionsForm.OnEndTrackBoxClick(Sender: TObject);
begin
 SetIniInt('main', 'OnEndAction', OnEndTrackBox.ItemIndex, IniFile);
end;

procedure TOptionsForm.FontComboBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with FontComboBox.Canvas do
  begin
    FillRect(Rect);
    Font.Name:=FontComboBox.Items[index];
    Font.Size:=8;
    TextOut(Rect.Left+2, Rect.Top, FontComboBox.Items[index]);
  end;
end;

procedure TOptionsForm.IgnoreSkinFontCheckBoxClick(Sender: TObject);
begin
 EnableFontControls(IgnoreSkinFontCheckBox.Checked);
 SetIniBool('main', 'IgnorePLFont', IgnoreSkinFontCheckBox.Checked, IniFile);
 PlayListForm.DrawWindow;
 PlayListForm.PlayList.Repaint;
 PlayListForm.RedrawPlayList;
end;

procedure TOptionsForm.EnableFontControls(enable: boolean);
begin
 FontComboBox.Enabled:=enable;
 FontSizeComboBox.Enabled:=enable;
 SampleBox.Enabled:=enable;
 SampleLabel.Enabled:=enable;
end;

procedure TOptionsForm.FontComboBoxChange(Sender: TObject);
begin
  SampleLabel.Font.Name:=FontComboBox.Items[FontComboBox.ItemIndex];
  SetIniString('main', 'PLFontName', FontComboBox.Items[FontComboBox.ItemIndex], IniFile);
 PlayListForm.DrawWindow;
 PlayListForm.PlayList.Repaint;
 PlayListForm.RedrawPlayList;
end;

procedure TOptionsForm.FontSizeComboBoxChange(Sender: TObject);
begin
  SampleLabel.Font.Size:=StrToInt( FontSizeComboBox.Items[FontSizeComboBox.ItemIndex] );
  SetIniInt('main', 'PLFontSize', StrToInt( FontSizeComboBox.Items[FontSizeComboBox.ItemIndex] ), IniFile);
 PlayListForm.DrawWindow;
 PlayListForm.PlayList.Repaint;
 PlayListForm.RedrawPlayList;
end;


procedure TOptionsForm.NotQVCheckBoxClick(Sender: TObject);
begin
  if NotQVCheckBox.Checked then
   begin
    SetIniInt('main', 'LiteMode', 1, IniFile);
    NotNVCheckBox.Checked:=false;
    NotNVCheckBox.Enabled:=false;
   end
  else
   begin
    SetIniInt('main', 'LiteMode', 0, IniFile);
    NotNVCheckBox.Enabled:=true;
   end;
end;

procedure TOptionsForm.NotNVCheckBoxClick(Sender: TObject);
begin
  if NotNVCheckBox.Checked then
   begin
    SetIniInt('main', 'LiteMode', 2, IniFile);
    NotQVCheckBox.Checked:=false;
    NotQVCheckBox.Enabled:=false;
   end
  else
   begin
    SetIniInt('main', 'LiteMode', 0, IniFile);
    NotQVCheckBox.Enabled:=true;
   end;
end;


// Изменение горячей клавиши
procedure TOptionsForm.HotKeyEditChange(Sender: TObject);
var
 i, num: integer;
begin

  if HotKeysBox.ItemIndex<0 then exit;

  // Проверка
  num:=HotKeysBox.Items.Count-1;
  for i:=0 to num do
   begin
    if GetIniInt('main', HotKeysBox.Items[i].SubItems[1], 0, 0, MaxInt, KeysFile)=HotKeyEdit.HotKey
     then
      begin
        MessageBeep(0);
        HotKeyEdit.HotKey:=0;
        exit;
      end;
   end;

  SetIniInt('main', HotKeysBox.Items[HotKeysBox.ItemIndex].SubItems[1], HotKeyEdit.HotKey, KeysFile);

  HotKeysBox.Items[HotKeysBox.ItemIndex].SubItems[0]:=HotKeyToText(HotKeyEdit.HotKey, true);

//  HotKeysBox.Items[HotKeysBox.ItemIndex].SubItems[1]:= HotKeyEdit.HotKey;

//  DrawHKList;


end;


// Отображение комбинации клавиш в поле редактирования
// Функция выполняется при выборе пунктаиз списка  
procedure TOptionsForm.HotKeysBoxSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
 aName: string;
begin
 if not Selected then exit;
 try
 aName:=HotKeysBox.Items[HotKeysBox.ItemIndex].SubItems[1];
 if HotKeysBox.Items[HotKeysBox.ItemIndex].Caption<>'-'
  then
   begin
    HotKeyEdit.HotKey:=TextToHotKey(HotKeysBox.Items[HotKeysBox.ItemIndex].SubItems[0], true);
    HotKeyEdit.Enabled:=true;
   end
  else HotKeyEdit.Enabled:=false;
 except
 end;
end;


// Для глобальных горячих клавиш
procedure TOptionsForm.GlobalHotKeyEditChange(Sender: TObject);
var
 i, num: integer;
begin

  if GlobalKeysBox.ItemIndex<0 then exit;

  // Проверка
  num:=GlobalKeysBox.Items.Count-1;
  for i:=0 to num do
   begin
    if GetIniInt('global', GlobalKeysBox.Items[i].SubItems[1], 0, 0, MaxInt, KeysFile)=GlobalHotKeyEdit.HotKey
     then
      begin
        MessageBeep(0);
        GlobalHotKeyEdit.HotKey:=0;
        exit;
      end;
   end;

  SetIniInt('global', GlobalKeysBox.Items[GlobalKeysBox.ItemIndex].SubItems[1], GlobalHotKeyEdit.HotKey, KeysFile);
//  DrawHKList;
  GlobalKeysBox.Items[GlobalKeysBox.ItemIndex].SubItems[0]:=HotKeyToText(GlobalHotKeyEdit.HotKey, true);
//  HotKeysBox.Items[HotKeysBox.ItemIndex].SubItems[1]:=HotKeyToText(HotKeyEdit.HotKey, false);


end;


function TOptionsForm.GetActionText(aName: string): string;
begin
 result:=aName;

 //-
 with AmpViewMainForm do
  begin
   if aName='Play' then result:=PlayBtn.Hint;
   if aName='Stop' then result:=StopBtn.Hint;
   if aName='Pause' then result:=PauseBtn.Hint;
   //-
   if aName='VolumeUp' then result:=ItemVolumeUp.Caption;
   if aName='VolumeDown' then result:=ItemVolumeDown.Caption;
   if aName='Mute' then result:=MuteBtn.Hint;
   //-
   if aName='Open' then result:=OpenBtn.Hint;
   if aName='OpenFolder' then result:=OpenBtn.Hint;   
   if aName='NextTrack' then result:=ItemNextTrack.Caption;
   if aName='PrevTrack' then result:=PrevBtn.Hint;
   if aName='NextFile' then result:=ItemNextFile.Caption;
   //-
   if aName='TimeLeftMode' then result:=ItemTimeMode.Caption;
   if aName='TopMost' then result:=ItemTopMost.Caption;
   if aName='Options' then result:=ItemOptions.Caption;
   //-
   if aName='FileInfo' then result:=PlayListForm.ItemFileInfo.Caption;
   if aName='PlayList' then result:=PlayListBtn.Hint;
   if aName='Minimize' then result:=MinBtn.Hint;
   if aName='Restore' then result:=TrayItemRestore.Caption;
  end;
end;


procedure TOptionsForm.UseControlClick(Sender: TObject);
begin
 SetIniBool('main', 'UseControl', UseControl.Checked, IniFile);
end;

procedure TOptionsForm.FSEditChange(Sender: TObject);
begin
 SetIniString('main', 'FormatString', FSEdit.Text, IniFile);
end;

procedure TOptionsForm.WarningCheckBoxClick(Sender: TObject);
begin
 SetIniBool('main', 'ShowWarnings', WarningCheckBox.Checked, IniFile);
end;

procedure TOptionsForm.AddBtnClick(Sender: TObject);
var
 i: integer;
begin
//
 for i:=0 to ExtListBox.Items.Count-1 do
  begin
   if (ExtListBox.Items[i]='') then ExtListBox.Items.Delete(i);
  end;
//
 if Length( ExtEdit.Text )=0 then exit;
 for i:=0 to ExtListBox.Items.Count-1 do
  begin
   if (ExtListBox.Items[i]=ExtEdit.Text)
    then exit;
  end;

 ExtListBox.Items.Add(ExtEdit.Text);
 SaveExtList;
 GetExtList;
end;

procedure TOptionsForm.GetExtList;
var
 ExtFile: string;
 i: integer;
 NumOfExt: integer;
begin
 ExtFile:=PlugDir+'\Extensions.lst';
 ExtListBox.Clear;
 // Загрузка списка дополнительных расширений
 NumOfExt:=GetIniInt('ext', 'num', 0, 0, 1000, ExtFile);
 for i:=0 to NumOfExt do
  begin
    ExtListBox.Items.Add( LowerCase(  GetIniString('ext', IntToStr(i), '', ExtFile) ) );
  end;

end;


procedure TOptionsForm.SaveExtList;
var
 ExtFile: string;
 i: integer;
 NumOfExt: integer;
begin
 ExtFile:=PlugDir+'\Extensions.lst';
 if FileExists(ExtFile) then DeleteFile(ExtFile);
 // Загрузка списка дополнительных расширений
 NumOfExt:=ExtListBox.Items.Count-1;
 SetIniInt('ext', 'num', NumOfExt, ExtFile);
 for i:=0 to NumOfExt do
  begin
    SetIniString('ext', IntToStr(i), ExtListBox.Items[i], ExtFile);
  end;

end;

procedure TOptionsForm.DeleteBtnClick(Sender: TObject);
begin
 ExtListBox.Items.Delete(ExtListBox.ItemIndex);
 SaveExtList;
end;

procedure TOptionsForm.ExtListBoxClick(Sender: TObject);
begin
 if (ExtListBox.Items.Count>0) and (ExtListBox.ItemIndex>=0)
  then ExtEdit.Text:=ExtListBox.Items[ExtListBox.ItemIndex];
end;


// Загрузка списка горячих клавиш
procedure TOptionsForm.DrawHKList;
var
 Lines,i: integer;
// tsl: TStringList;
begin
  HotKeysBox.Clear;

  lines:=HotKeyList.Count-1;
  for i:=0 to lines do
   begin
     HotKeysBox.Items.Add;
     HotKeysBox.Items[HotKeysBox.Items.Count-1].SubItems.Add('');
     HotKeysBox.Items[HotKeysBox.Items.Count-1].SubItems.Add('');
     HotKeysBox.Items[i].SubItems[1]:=HotKeyList.Items[i];
   end;

 // Отрисовка в сетке списка
 for i:=0 to lines do
  begin
   if HotKeysBox.Items[i].Caption<>'-' then
    begin
     HotKeysBox.Items[i].Caption:=GetActionText(HotKeysBox.Items[i].SubItems[1]);
     HotKeysBox.Items[i].SubItems[0]:=HotKeyToText(GetIniInt('main', HotKeysBox.Items[i].SubItems[1], 0,0,MaxInt, KeysFile), true);
    end;
 end;

end;


// Загрузка списка глобальных горячих клавиш
procedure TOptionsForm.DrawGHKList;
var
 Lines,i: integer;
begin
  GlobalKeysBox.Clear;

  lines:=GHotKeysList.Count-1;
  for i:=0 to lines do
   begin
     GlobalKeysBox.Items.Add;
     GlobalKeysBox.Items[GlobalKeysBox.Items.Count-1].SubItems.Add('');
     GlobalKeysBox.Items[GlobalKeysBox.Items.Count-1].SubItems.Add('');
     GlobalKeysBox.Items[i].SubItems[1]:=GHotKeysList.Items[i];
   end;

 // Отрисовка в сетке списка
 for i:=0 to lines do
  begin
   if GlobalKeysBox.Items[i].Caption<>'-' then
    begin
     GlobalKeysBox.Items[i].Caption:=GetActionText(GlobalKeysBox.Items[i].SubItems[1]);
     GlobalKeysBox.Items[i].SubItems[0]:=HotKeyToText(GetIniInt('global', GlobalKeysBox.Items[i].SubItems[1], 0,0,MaxInt, KeysFile), true);
    end;
 end;

end;


// Отображение комбинации клавиш в поле редактирования
// Функция выполняется при выборе пунктаиз списка
procedure TOptionsForm.GlobalKeysBoxSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
 aName: string;
begin
 if not Selected then exit;
 try
 aName:=GlobalKeysBox.Items[GlobalKeysBox.ItemIndex].SubItems[1];
 if GlobalKeysBox.Items[GlobalKeysBox.ItemIndex].Caption<>'-'
  then
   begin
    GlobalHotKeyEdit.HotKey:=TextToHotKey(GlobalKeysBox.Items[GlobalKeysBox.ItemIndex].SubItems[0], true);
    GlobalHotKeyEdit.Enabled:=true;
   end
  else GlobalHotKeyEdit.Enabled:=false;
 except
 end;
end;


procedure TOptionsForm.TabSheet8Show(Sender: TObject);
begin
 HotKeysBox.SetFocus;
end;

procedure TOptionsForm.DefaultConfigCheckBoxClick(Sender: TObject);
begin
 SetIniBool('main', 'OnlyDefaultConfig', DefaultConfigCheckBox.Checked, PlugDir+'\Config\default.ini');
end;

end.
