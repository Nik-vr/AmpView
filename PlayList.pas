unit PlayList;

interface

uses Windows, Messages, SysUtils, Controls, StdCtrls, GR32_Image,
     Menus, SkinTypes, Forms, ShellAPI, Graphics, ActnList,
     GR32_Layers, GRButton32, BASSPlayerX, Classes, ComCtrls,
     {$IF CompilerVersion <24}
       MyDialogs,
     {$ELSE}
       Dialogs,
     {$IFEND}
     ExtCtrls, System.Actions, clipbrd;

type
  TPlayListForm = class(TForm)
    PLMainImage: TImage32;
    PLPopupMenu: TPopupMenu;
    ItemView: TMenuItem;
    ShowFileNamesItem: TMenuItem;
    ShowFullNameItem: TMenuItem;
    ShowTrackCaptionItem: TMenuItem;
    N7: TMenuItem;
    ShowNumbersItem: TMenuItem;
    ShowTracksLength: TMenuItem;
    N4: TMenuItem;
    ItemFileInfo: TMenuItem;
    ActionList1: TActionList;
    ActionDeleteTrack: TAction;
    N1: TMenuItem;
    ItemDeleteTrack: TMenuItem;
    RightBottomImage: TImage32;
    PLCloseBtn: TButton32;
    ActionDeleteFiles: TAction;
    N2: TMenuItem;
    ItemShuffle: TMenuItem;
    ItemDeleteFile: TMenuItem;
    ItemSentToFolder: TMenuItem;
    ActionSend: TAction;
    ActionSortByTitle: TAction;
    N3: TMenuItem;
    ItemSortByTitle: TMenuItem;
    ActionSuffle: TAction;
    ActionSortByFileName: TAction;
    ActionSortByLength: TAction;
    ItemSort: TMenuItem;
    ItemSortByFileName: TMenuItem;
    ItemSortByLength: TMenuItem;
    ActionSavePlayList: TAction;
    N5: TMenuItem;
    ItemSavePlayList: TMenuItem;
    PlayList: TListView;
    InfoBox: TListBox;
    ActionCopyNames: TAction;
    procedure ActionDeleteFilesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowNumbersItemClick(Sender: TObject);
    procedure ShowFileNamesItemClick(Sender: TObject);
    procedure ShowTrackCaptionItemClick(Sender: TObject);
    procedure ShowFullNameItemClick(Sender: TObject);
    procedure ShowTracksLengthClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PLPopupMenuPopup(Sender: TObject);
    procedure ActionDeleteTrackExecute(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure RightBottomImageMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      Layer: TCustomLayer);
    procedure RightBottomImageMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      Layer: TCustomLayer);
    procedure RightBottomImageMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure PLCloseBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure PLCloseBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure PLCloseBtnClick(Sender: TObject);
    procedure ActionSendExecute(Sender: TObject);
    procedure ActionSortByTitleExecute(Sender: TObject);
    procedure ActionSuffleExecute(Sender: TObject);
    procedure ActionSortByFileNameExecute(Sender: TObject);
    procedure ActionSortByLengthExecute(Sender: TObject);
    procedure ActionSavePlayListExecute(Sender: TObject);
    procedure PlayListDblClick(Sender: TObject);
    procedure PlayListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PlayListAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure PlayListAdvancedCustomDraw(Sender: TCustomListView;
      const ARect: TRect; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure InfoBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ShowAbout;
    procedure InfoBoxDblClick(Sender: TObject);
    procedure InfoBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InfoBoxClick(Sender: TObject);
    procedure PlayListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PlayListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PlayListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionCopyNamesExecute(Sender: TObject);
  private
      { Private declarations }
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMDeactivate(var Msg: TMessage); message WM_KILLFOCUS;
    procedure WMActivate(var Msg: TMessage); message WM_ACTIVATE;
    procedure WMKeyDown(var Msg: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TMessage); message WM_KEYUP;
    { Private declarations }
  public
    FShowHoriz: Boolean;
    procedure DrawWindow;
    procedure RedrawPlayList;
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  PlayListForm: TPlayListForm;
  PLImages: TSizeableWindow;    // Р РёСЃСѓРЅРєРё РґР»СЏ РїРѕСЃС‚СЂРѕРµРЅРёСЏ playlist'Р°
  ListOptions: TListOptions;
//  PLCloseButton: TSimpleButton;      // РљРЅРѕРїРєР° PlayList
  SaveDialog: {$IF CompilerVersion >= 24.0} TSaveDialog {$ELSE} TMySaveDialog {$IFEND} ;
  //
  isResizing: boolean = false;
  oldPos: TPoint;
  WRect: TRect;
  //
  MinHeight: integer = 200;
  MinWidth: integer = 200;
  //
  SortByTitleReverse: boolean;
  SortByFileNameReverse: boolean;
  SortByLengthReverse: boolean;
  keydowncnt:integer;

implementation

uses Viewer, MyTools, xIni, GR32, PlayListClass, Types, Options;

{$R *.dfm}

procedure TPlayListForm.DrawWindow;
var
 i: integer;
 WindowRgn: HRGN;
 temp: integer;
begin
 PLMainImage.Top:=0;
 PLMainImage.Left:=0;

 Width:=GetIniInt('PlayList', 'Width', AmpViewMainForm.Width, AmpViewMainForm.Width, Screen.Width, IniFile);
 Height:=GetIniInt('PlayList', 'Height', 250, AmpViewMainForm.Height, Screen.Height, IniFile);

 if Width<AmpViewMainForm.Width then Width:=AmpViewMainForm.Width;
 if Height<AmpViewMainForm.Height then Width:=AmpViewMainForm.Height;  

 PLMainImage.Width:=Width;
 PLMainImage.Height:=Height;
 RightBottomImage.Bitmap:=PLImages.RightBottomImage;
 RightBottomImage.Width:=PLImages.RightBottomImage.Width;
 RightBottomImage.Height:=PLImages.RightBottomImage.Height;
 RightBottomImage.Top:=Height-PLImages.RightBottomImage.Height;
 RightBottomImage.Left:=Width-PLImages.RightBottomImage.Width;

  MinHeight:= AmpViewMainForm.Height;
  MinWidth:= AmpViewMainForm.Width;

  PLCloseBtn.Left:=PlayListForm.Width-PLCloseBtn.Width-PLCloseBtn.Tag;

  with PLImages do
   begin
    PLMainImage.SetupBitmap;
    PLMainImage.BeginUpdate;
    LeftTopImage.DrawTo(PLMainImage.Bitmap, 0,0);
    //
    temp:=PLMainImage.Width div TopImage.Width;
    for i:=0 to temp do
     begin
       TopImage.DrawTo(PLMainImage.Bitmap, i*TopImage.Width,0);
     end;
    //
    temp:=PLMainImage.Width div BottomImage.Width;
    for i:=0 to temp do
     begin
       BottomImage.DrawTo(PLMainImage.Bitmap, i*BottomImage.Width, PLMainImage.Height-BottomImage.Height);
     end;
    //
    temp:=PLMainImage.Height div LeftImage.Height;
    for i:=0 to temp do
     begin
       LeftImage.DrawTo(PLMainImage.Bitmap, 0, i*LeftImage.Height);
     end;
    //
    temp:=PLMainImage.Height div LeftImage.Height;
    for i:=0 to temp do
     begin
       RightImage.DrawTo(PLMainImage.Bitmap, PLMainImage.Width-RightImage.Width, i*LeftImage.Height);
     end;

    LeftTopImage.DrawTo(PLMainImage.Bitmap, 0,0);
    RightTopImage.DrawTo(PLMainImage.Bitmap, PLMainImage.Width-RightTopImage.Width,0);
    LeftBottomImage.DrawTo(PLMainImage.Bitmap, 0,PLMainImage.Height-BottomImage.Height);
    RightBottomImage.DrawTo(PLMainImage.Bitmap, PLMainImage.Width-RightBottomImage.Width,PLMainImage.Height-BottomImage.Height);

    with PlayList do
     begin
      Left:=LeftOffset;
      Top:=TopOffset;
      Height:=PLMainImage.Height-BottomOffset-TopOffset;
      Width:=PLMainImage.Width-RightOffset-LeftOffset;
      RedrawPlayList;
      //
      InfoBox.Left:=Left;
      InfoBox.Top:=Top;
      InfoBox.Width:=Width;
      InfoBox.Height:=Height;
      //
      // Установка шрифта 
      if GetIniBool('main', 'IgnorePLFont', false, IniFile) then
       begin
        Canvas.Font.Size:=GetIniInt('main', 'PLFontSize', 10, 6, 22, IniFile);
        Canvas.Font.Name:=GetIniString('main', 'PLFontName', 'Arial', IniFile);
//        PlayList.DefaultRowHeight:=Canvas.Font.Size*2;
       end
      else
       begin
//        PlayList.DefaultRowHeight:=ListOptions.Font.Size*2;
       end;

     end;
   end;

   if AmpViewMainForm.TransparentColor then
    begin
     if DetectWinVersion<>wvXP then
      begin
       windowRgn := BitmapToRgn(PLMainImage.Bitmap, AmpViewMainForm.TransparentColorValue);
       SetWindowRgn(Handle, WindowRgn, True);
      end
     else
      begin
        TransparentColorValue:=AmpViewMainForm.TransparentColorValue;
        TransparentColor:=true;
      end;
    end;

end;


procedure TPlayListForm.FormShow(Sender: TObject);
begin
 // РЎРїРёСЃРѕРє
 ShowNumbersItem.Checked:=GetIniBool('PlayList', 'ShowNumbers', true, IniFile);
 ShowTracksLength.Checked:=GetIniBool('PlayList', 'ShowTracksLength', true, IniFile);
 case GetIniInt('PlayList', 'ShowMode', 1, 0, 2, IniFile) of
  0: ShowFileNamesItem.Click;
  1: ShowTrackCaptionItem.Click;
  2: ShowFullNameItem.Click;
 end;
end;


procedure TPlayListForm.ShowNumbersItemClick(Sender: TObject);
begin
 if ShowNumbersItem.Checked
  then ShowNumbersItem.Checked:=false
  else ShowNumbersItem.Checked:=true;
 SetIniBool('PlayList', 'ShowNumbers', ShowNumbersItem.Checked, IniFile); 
 PlayList.Repaint;
 RedrawPlayList;
end;

procedure TPlayListForm.ShowFileNamesItemClick(Sender: TObject);
begin
 if not ShowFileNamesItem.Checked
  then
   begin
    ShowFileNamesItem.Checked:=true;
    ShowFullNameItem.Checked:=false;
    ShowTrackCaptionItem.Checked:=false;
   end;
 SetIniInt('PlayList', 'ShowMode', 0, IniFile);
 PlayList.Repaint;
 RedrawPlayList;
end;

procedure TPlayListForm.ShowTrackCaptionItemClick(Sender: TObject);
begin
 if not ShowTrackCaptionItem.Checked
  then
   begin
    ShowFileNamesItem.Checked:=false;
    ShowFullNameItem.Checked:=false;
    ShowTrackCaptionItem.Checked:=true;
   end;
 SetIniInt('PlayList', 'ShowMode', 1, IniFile);
 PlayList.Repaint;
 RedrawPlayList; 
end;

procedure TPlayListForm.ShowFullNameItemClick(Sender: TObject);
begin
 if not ShowFullNameItem.Checked
  then
   begin
    ShowFileNamesItem.Checked:=false;
    ShowFullNameItem.Checked:=true;
    ShowTrackCaptionItem.Checked:=false;
   end;
 SetIniInt('PlayList', 'ShowMode', 2, IniFile);
 PlayList.Repaint;
 RedrawPlayList; 
end;

procedure TPlayListForm.ShowTracksLengthClick(Sender: TObject);
begin
 if ShowTracksLength.Checked
  then ShowTracksLength.Checked:=false
  else ShowTracksLength.Checked:=true;
 SetIniBool('PlayList', 'ShowTracksLength', ShowTracksLength.Checked, IniFile);
 PlayList.Repaint;
 RedrawPlayList; 
end;

procedure TPlayListForm.FormCreate(Sender: TObject);
begin
  Left:=0;
  Top:=0;
  Height:=0;
  Width:=0;
  InfoBox.Visible:=false; 
  DragAcceptFiles(Handle, true);
  RightBottomImage.Cursor:=crSizeNWSE;

  SaveDialog:={$IF CompilerVersion >= 24.0} TSaveDialog {$ELSE} TMySaveDialog {$IFEND}.Create(PlayListForm);
  SaveDialog.Filter:='M3U Playlist|*.m3u|PLS Playlist|*.pls|XML Playlist|*.xml';
end;


procedure TPlayListForm.WMDropFiles(var Msg: TWMDropFiles);
const
  maxlen = 254;
var
  h: THandle;
  i, num:integer;
  pchr: array[0..maxlen] of char;
  FileName: string;
begin
  h := Msg.Drop;

  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  // РґРѕР±Р°РІР»РµРЅРёРµ С„Р°Р№Р»РѕРІ РІ СЃРїРёСЃРѕРє
  num:=DragQueryFile(h,Dword(-1),nil,0);
  for i:=0 to num-1 do
   begin
    DragQueryFile(h,i,pchr,maxlen);
    FileName := string(pchr);
    if FileExists(FileName)
     then AmpViewMainForm.AddFile(FileName, true)
     else
      begin
       if DirExists(FileName)
        then AmpViewMainForm.AddFolder(FileName);
      end;  
  end;

  DragFinish(h);

  Screen.Cursor:=crDefault;

end;

procedure TPlayListForm.FormDestroy(Sender: TObject);
begin
  DragAcceptFiles(Handle, False);
end;


procedure TPlayListForm.WMDeactivate(var Msg: TMessage);
begin
 //Exit;
 AmpViewMainForm.SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
 inherited;
end;

procedure TPlayListForm.WMActivate(var Msg: TMessage);
begin
//
inherited;
end;

procedure TPlayListForm.WMKeyDown(var Msg: TMessage);
begin
if (msg.WParam=VK_LEFT) or (msg.WParam=VK_RIGHT) then
  begin
  PostMessage(AmpViewMainForm.Handle, msg.Msg, msg.WParam, msg.LParam);
  exit;
  end;
if AmpViewMainForm.IsEmbedded then
  begin
  AmpViewMainForm.PostMsgParent(msg);
  end;
  inherited;
end;

procedure TPlayListForm.WMKeyUp(var Msg: TMessage);
begin
if AmpViewMainForm.IsEmbedded then
  begin
  AmpViewMainForm.PostMsgParent(msg);
  end;
  inherited;
end;

procedure TPlayListForm.PLPopupMenuPopup(Sender: TObject);
begin
 // Активация пунктов меню в зависимости от наличия файлов в списке
  ItemSort.Enabled:=not (MyPlayList.Count<=1);
  ItemShuffle.Enabled:=not (MyPlayList.Count<=1);
  ItemSavePlayList.Enabled:=not (MyPlayList.Count<=0);
 // Активация пунктов меню в зависимости от наличия выделенных файлов в списке
  ItemFileInfo.Enabled:=(PlayList.SelCount=1) and (MyPlayList.Count>0);
  ItemDeleteTrack.Enabled:=(PlayList.SelCount>0) and (MyPlayList.Count>0);
  ItemDeleteFile.Enabled:=(PlayList.SelCount>0) and (MyPlayList.Count>0);
end;

procedure TPlayListForm.ActionDeleteTrackExecute(Sender: TObject);
var
 i: integer;
 num: integer;
 MsgType: integer;
 lf: string;
 wr: string;
 ms: string;
begin
 // Проверка
 if MyPlayList.Count<0 then exit;

 // Инициализация переменных
 i:=0; num:=0;
 MsgType := MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_APPLMODAL;
 lf:=PlugDir+'\Language\'+GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile);
 ms:=GetIniString('Strings', 'WarningDeleteTracks', 'Are you sure you want to delete these tracks?', lf);
 wr:=GetIniString('Strings', 'WarningCaption', 'Warning', lf);

 if GetIniBool('main', 'ShowWarningsDelTracks', false, IniFile) then
  begin
   if MessageBox( Handle, PChar(ms), PChar(wr), MsgType)=IDNO then exit;
  end;

 // Проход по списку треков
 while i<=MyPlayList.Count-1 do
  begin
   // Если трек выделен
   if PlayList.Items[i].Selected then
    begin
      // Запоминаем позицию
      num:=i;
      // Удаление трека из списка
      MyPlayList.DeleteItem(i);
      PlayList.Items.Delete(i);
    end
   else
    begin
     i:=i+1;
    end;
  end;

  // Перерисовка сетки
  RedrawPlayList;

  // Возвращение фокуса списку
  if num=MyPlayList.Count then num:=num-1;
  if num>MyPlayList.Count-1 then exit;
  PlayList.SetFocus;
  PlayList.ItemIndex:=num;
  PlayList.ItemFocused:=PlayList.Items[PlayList.ItemIndex];

end;

procedure TPlayListForm.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 if CtrlDown then
  AmpViewMainForm.ActionVolumeDown.Execute;
end;

procedure TPlayListForm.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 if CtrlDown then
 AmpViewMainForm.ActionVolumeUp.Execute;
end;

procedure TPlayListForm.RightBottomImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  isResizing := true;
  oldPos := Mouse.CursorPos;
  GetWindowRect(Handle, WRect); //РїРѕР»СѓС‡Р°РµРј РїСЂСЏРјРѕСѓРіРѕР»СЊРЅРёРє РѕРєРЅР°
  DrawFocusRect(GetDC(0), WRect);
end;

procedure TPlayListForm.RightBottomImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if isResizing then
  begin
    DrawFocusRect(GetDC(0), WRect);
    BoundsRect := WRect;
    SetIniInt('PlayList', 'Width', PlayListForm.Width, IniFile);
    SetIniInt('PlayList', 'Height', PlayListForm.Height, IniFile);
    DrawWindow;
  end;
  isResizing := false;
  Cursor:=crDefault;
end;

procedure TPlayListForm.RightBottomImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
  dx, dy: integer;
begin
  if isResizing then
  begin
   DrawFocusRect(GetDC(0), WRect); //СЃС‚РёСЂР°РµРј РїСЂРµРґС‹РґСѓС‰СѓСЋ СЂР°РјРєСѓ
    dx := Mouse.CursorPos.X - oldPos.X;
    dy := Mouse.CursorPos.Y - oldPos.Y;
    if (WRect.Right - WRect.Left + dx > AmpViewMainForm.Width) and
    (WRect.Right + dx < Screen.Width)
     then WRect.Right := WRect.Right + dx;
    if (WRect.Bottom - WRect.Top + dy > AmpViewMainForm.Height) and
    (WRect.Bottom + dy < Screen.Height)
     then WRect.Bottom := WRect.Bottom + dy;
   DrawFocusRect(GetDC(0), WRect);
  end;
  oldPos := Mouse.CursorPos;
end;


procedure TPlayListForm.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  //if DetectWinVersion=wvXP
  // then Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;



procedure TPlayListForm.PLCloseBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
 if Button=mbLeft then
  PLCloseBtn.Bitmap:=AmpViewMainForm.CloseBtn.PushedButton;
end;

procedure TPlayListForm.PLCloseBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
 if Button=mbLeft then
  PLCloseBtn.Bitmap:=AmpViewMainForm.CloseBtn.InactiveButton;
end;

procedure TPlayListForm.PLCloseBtnClick(Sender: TObject);
begin
 Hide;
 SetIniBool('PlayList', 'Visible', PlayListForm.Visible, IniFile);
 AmpViewMainForm.PlayListBtn.Checked:=false;
end;

procedure TPlayListForm.ActionCopyNamesExecute(Sender: TObject);
var a:integer;
    s:string;
begin
if PlayList.SelCount<=0 then exit;
s:='';
for a := 0 to PlayList.Items.Count-1 do
  begin
  if not PlayList.Items[a].Selected then continue;
  s:=s+PlayList.Items[a].Caption+#13#10;
  end;
if s<>'' then Clipboard.AsText:=s;
end;

procedure TPlayListForm.ActionDeleteFilesExecute(Sender: TObject);
var
 i,ii: integer;
 num: integer;
 MsgType: integer;
 lf: string;
 wr: string;
 ms: string;
 cnt:Integer;
 skipline:Boolean;
begin
 // Проверка
 if MyPlayList.Count<0 then exit;

 // Инициализация переменных
 i:=0; num:=0;
 MsgType := MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_APPLMODAL;
 lf:=PlugDir+'\Language\'+GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile);
 ms:=GetIniString('Strings', 'WarningDeleteFiles', 'Are you sure you want to delete these files?', lf);
 wr:=GetIniString('Strings', 'WarningCaption', 'Warning', lf);

 cnt:=0;
 for ii:=0 to MyPlayList.Count-1 do
   begin
   if PlayList.Items[ii].Selected then inc(cnt);
   end;

 ms:=ms+' ('+inttostr(cnt)+')'#13#10;
 cnt:=0;
 skipline:=false;
 for ii:=0 to MyPlayList.Count-1 do
  begin
   // Если трек выделен
   if PlayList.Items[ii].Selected then
    begin
      if (cnt<5) or (ii>=MyPlayList.Count-3) then
        begin
        ms:=ms+#13#10+MyPlayList.GetFileName(ii);
        end
      else if (cnt>=5) and (not skipline) and (ii<MyPlayList.Count-3) then
        begin
          ms:=ms+#13#10'...';
          skipline:=true;
        end;
      inc(cnt);
    end;
  end;

 if GetIniBool('main', 'ShowWarningsDelFiles', true, IniFile) then
  begin
   if MessageBox( Handle, PChar(ms), PChar(wr), MsgType)=IDNO then exit;
  end;

 // Проход по списку треков
 while i<=MyPlayList.Count-1 do
  begin
   // Если трек выделен
   if PlayList.Items[i].Selected then
    begin
      // Запоминаем позицию
      num:=i;
      // Удаление трека из списка
      DeleteFile(MyPlayList.GetFileName(i));
      MyPlayList.DeleteItem(i);
      PlayList.Items.Delete(i);
    end
   else
    begin
     i:=i+1;
    end;
  end;

  // Перерисовка сетки
  RedrawPlayList;

  // Возвращение фокуса списку
  if num=MyPlayList.Count then num:=num-1;
  if num>MyPlayList.Count-1 then exit;
  PlayList.SetFocus;
  PlayList.ItemIndex:=num;
  PlayList.ItemFocused:=PlayList.Items[PlayList.ItemIndex];


end;


procedure TPlayListForm.ActionSendExecute(Sender: TObject);
var
 i: integer;
 QF: string;
begin
 QF:=GetIniString('main', 'QuickFilder', PlugDir, IniFile);
 i:=0;
 while i<=PlayList.SelCount-1 do
  begin
   if PlayList.Items[i].Selected
    then
      begin
      CopyFile(PChar(MyPlayList.GetFileName(i)), PChar(QF+'\'+ExtractFileName(MyPlayList.GetFileName(i))), true)
      end
    else i:=i+1;
  end;
end;


procedure TPlayListForm.ActionSuffleExecute(Sender: TObject);
begin
 // Проверка длины списка
 if MyPlayList.Count<=0 then exit;
 // Перемешивание
 MyPlayList.Shuffle;
 // Перерисовка списка
 RedrawPlayList;
end;


// Сортировка по заголовку трека
procedure TPlayListForm.ActionSortByTitleExecute(Sender: TObject);
begin
 // Проверка длины списка
 if MyPlayList.Count<=0 then exit;
 // Сортировка по заголовкам
 MyPlayList.Sort(1, SortByTitleReverse);
 SortByTitleReverse:=not SortByTitleReverse;
 // Перерисовка списка
 RedrawPlayList;
end;

procedure TPlayListForm.ActionSortByFileNameExecute(Sender: TObject);
begin
 // Проверка длины списка
 if MyPlayList.Count<=0 then exit;
 // Сортировка по именам файлов
 MyPlayList.Sort(2, SortByFileNameReverse);
 SortByFileNameReverse:=not SortByFileNameReverse;
 // Перерисовка списка
 RedrawPlayList;
end;

procedure TPlayListForm.ActionSortByLengthExecute(Sender: TObject);
begin
 // Проверка длины списка
 if MyPlayList.Count<=0 then exit;
 // Сортировка по длине треков
 MyPlayList.Sort(3, SortByLengthReverse);
 SortByLengthReverse:=not SortByLengthReverse;
 // Перерисовка списка
 RedrawPlayList;
end;

procedure TPlayListForm.ActionSavePlayListExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
   begin
    case SaveDialog.FilterIndex of
     1: MyPlayList.SaveM3U(SaveDialog.FileName+'.m3u');
     2: MyPlayList.SavePLS(SaveDialog.FileName+'.pls');
     3: MyPlayList.SaveXML(SaveDialog.FileName+'.xml');
    end;
   end;
end;

procedure TPlayListForm.PlayListDblClick(Sender: TObject);
begin
 if PlayList.ItemIndex<0 then exit;

 with AmpViewMainForm do
  begin
   Player.Stop;
   CurTrack:=PlayList.ItemIndex;
   OpenTrack(MyPlayList.GetFileName(CurTrack));
   Player.Play;
//   PlayList.ItemIndex:=CurTrack;
   PlayList.Repaint;
   SetButtonStates;
  end;
end;

procedure TPlayListForm.PlayListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var flags:LongInt;
begin

 if (Key=VK_LEFT) or (Key=VK_RIGHT) then
   begin
   flags:=0;
   if keydowncnt>0 then flags:=$40000000;
   flags:=flags+keydowncnt;
   SendMessage(AmpViewMainForm.Handle,WM_KEYDOWN,Key,flags);
   inc(keydowncnt);
   exit;
   end;

 if PlayList.ItemIndex<0 then exit;

 if Key=13 then
  with AmpViewMainForm do
   begin
    Player.Stop;
    CurTrack:=PlayList.ItemIndex;
    OpenTrack(MyPlayList.GetFileName(CurTrack));
    Player.Play;
//    PlayList.ItemIndex:=CurTrack;
    PlayList.Repaint;
    SetButtonStates;
    Exit;
   end;   
end;


// Перерисовка списка треков
procedure TPlayListForm.RedrawPlayList;
var
 i, lines: integer;
 text: string;
 ScrollBarWidth: integer;
 top_item, bottom_item:integer;
begin

  top_item:=0; bottom_item:=0;
  if PlayList.Items.Count>0 then
    begin
    top_item:=PlayList.TopItem.Index;
    bottom_item:=top_item+PlayList.VisibleRowCount-1;
    end;

  PlayList.Items.BeginUpdate;

  PlayList.Clear;

  if MyPlayList.Count<=0 then
    begin
    PlayList.Items.EndUpdate;
    exit;
    end;

  lines:=MyPlayList.Count-1;
  for i:=0 to lines do
   begin
     PlayList.Items.Add;
     PlayList.Items[PlayList.Items.Count-1].SubItems.Add('');
     PlayList.Items[PlayList.Items.Count-1].SubItems.Add('');
   end;

  //
  for i:=0 to lines do
   begin
    CurTrack:=MyPlayList.SearchByFileName(Player.TrackFile);
   end;

 // Опции
 // Скрываем столбец с нумерацией (больше не нужен; см. ниже)
// PlayList.Columns[0].Width:=0;

 // Если есть линейка прокрутки
 if (GetWindowlong(PlayList.Handle, GWL_STYLE) and WS_VSCROLL) <> 0
  then ScrollBarWidth := GetSystemMetrics(SM_CXHSCROLL)
  else ScrollBarWidth := 0;

 // Длина треков (вкл/выкл)
 if ShowTracksLength.Checked
  then PlayList.Columns[2].Width:=PlayList.Canvas.TextWidth('909:99:909') // '099:990'
  else PlayList.Columns[2].Width:=0;

 // Размеры колонок
 //PlayList.Columns[1].Width:=PlayList.Width-PlayList.Columns[0].Width-PlayList.Columns[2].Width-ScrollBarWidth;
 PlayList.Columns[0].Width:=PlayList.Width-PlayList.Columns[1].Width-PlayList.Columns[2].Width-ScrollBarWidth;

 // Отрисовка в сетке списка треков
 for i:=0 to lines do
  begin
   // Нумерация треков
   if ShowNumbersItem.Checked
    then PlayList.Items[i].Caption:=IntToStr(i+1)+'. ';
    //PlayList.Cells[0,i]:=

   // Длина треков
   if ShowTracksLength.Checked
    then PlayList.Items[i].SubItems[1]:=LenToTime(MyPlayList.GetLength(i));

   // Заголовки треков
   if ShowTrackCaptionItem.Checked
    then text:=MyPlayList.GetText(i)
    else
     if ShowFullNameItem.Checked
      then text:=MyPlayList.GetFileName(i)
      else text:=ExtractFileName( MyPlayList.GetFileName(i) );

   // Нумерация треков
   if ShowNumbersItem.Checked

    then text:=IntToStr(i+1)+'. '+text;
   // "Красивая" обрезка длинных строк
   if GetTextWidth(Canvas.Handle, text, true)>=PlayList.Columns[0].Width
    then text:=BeautyStr(text, PlayList.Columns[0].Width)
    else text:=BeautyStr(text, PlayList.Columns[0].Width);

   PlayList.Items[i].Caption:=text;
   PlayList.Items[i].SubItems[0]:=text;

 end;

 if bottom_item>PlayList.Items.Count-1 then bottom_item:=PlayList.Items.Count-1;
 if bottom_item>=0 then
   begin
   PlayList.Items[top_item].MakeVisible(False);
   PlayList.Items[bottom_item].MakeVisible(False);
   end;
 PlayList.Items.EndUpdate;

 PlayList.Repaint;

end;



procedure TPlayListForm.PlayListAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
 if Item=nil then exit;


 with Sender as TCustomListView do
  begin
   Canvas.Brush.Color:=ListOptions.BackColor1;
   Canvas.Font:=ListOptions.SelectedPlayedFont;
   //  Brush.Color:=ListOptions.BackColor1;

   // Текущий трек
   if Item.Index=CurTrack then
     begin
     // Выделенная строка
     if (Item.Index=PlayList.ItemIndex) then//and Focused
       begin
       Canvas.Font:=ListOptions.SelectedPlayedFont;
       Canvas.Brush.Color:=ListOptions.SelectedPlayedBackColor;
       Canvas.FillRect(Item.DisplayRect(drBounds));
       end
     else
       // Невыделенные строки
       begin
       Canvas.Font:=ListOptions.PlayedFont;
       if (Item.Index mod 2)=0
         then Canvas.Brush.Color:=ListOptions.BackColor1
         else Canvas.Brush.Color:=ListOptions.BackColor2;
       end;
     end
   // Р•СЃР»Рё С„Р°Р№Р» РЅРµ РїСЂРѕРёРіСЂС‹РІР°РµС‚СЃСЏ
    else
     begin
     // Р•СЃР»Рё РєСѓСЂСЃРѕСЂ РЅР° С„Р°Р№Р»Рµ
     if {(}Item.selected{Index=PlayList.ItemIndex) and Focused  } then
       begin
       Canvas.Font:=ListOptions.SelectedFont;
       Canvas.Brush.Color:=ListOptions.SelectedBackColor;
       Canvas.FillRect(Item.DisplayRect(drBounds));
       end
     else
       begin
       Canvas.Font:=ListOptions.Font;
       if (Item.Index mod 2)=0
         then Canvas.Brush.Color:=ListOptions.BackColor1
         else Canvas.Brush.Color:=ListOptions.BackColor2;
       end;
     end;


  // Р•СЃР»Рё РІРєР»СЋС‡РµРЅРѕ РёРіРЅРѕСЂРёСЂРѕРІР°РЅРёРµ С€СЂРёС„С‚Р°
   if GetIniBool('main', 'IgnorePLFont', false, IniFile) then
    begin
     Canvas.Font.Size:=GetIniInt('main', 'PLFontSize', 10, 6, 22, IniFile);
     Canvas.Font.Name:=GetIniString('main', 'PLFontName', 'Arial', IniFile);
    end
   else
    begin
//      PlayList.DefaultRowHeight:=ListOptions.Font.Size*2;
    end;
   Canvas.TextOut(Item.DisplayRect(drBounds).Left+5, Item.DisplayRect(drBounds).Top+3, item.Caption);
   Canvas.TextOut(clientwidth-canvas.TextWidth('     '+item.SubItems[1])-5, Item.DisplayRect(drBounds).Top+3, '     '+item.SubItems[1]+'     ');

   if focused and item.Focused then DrawFocusRect(canvas.Handle,Item.DisplayRect(drBounds));

  end;

end;


procedure TPlayListForm.PlayListAdvancedCustomDraw(Sender: TCustomListView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
//  if Item.Selected then
  DrawFocusRect(Canvas.Handle, ARect);
end;

procedure TPlayListForm.InfoBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
 text: string;
begin
 // выбор цветов и отрисовка
  with Control as TListBox do
  begin
     begin
     Canvas.Brush.Color:=ListOptions.BackColor1;

     // Если курсор на файле
     if odSelected in State
      then
       begin
        Canvas.Font:=ListOptions.SelectedFont;
        Canvas.Brush.Color:=ListOptions.SelectedBackColor;
       end
      else
       begin
        Canvas.Font:=ListOptions.Font;
        if (Index mod 2)=0
         then Canvas.Brush.Color:=ListOptions.BackColor1
         else Canvas.Brush.Color:=ListOptions.BackColor2;
       end;

      if ((Index)=(InfoBox.Items.Count-1)) or (Index=0) then Canvas.Font.Color:=ListOptions.PlayedFont.Color;
      if ((Index)=(InfoBox.Items.Count-1)) or (Index=0) then Canvas.Font.Style:=Canvas.Font.Style+[fsBold] else Canvas.Font.Style:=Canvas.Font.Style-[fsBold];
      Canvas.FillRect(Rect);
      text:=Items[index];
      Canvas.TextOut(Rect.Left + 2, Rect.Top, text);
      end;
    // Зарисовка рамки фокуса
    if odFocused in State then DrawFocusRect(Canvas.Handle, Rect);
  end;
end;

procedure TPlayListForm.ShowAbout;
var
 temp: string;
begin
 InfoBox.Visible:=true;
 with InfoBox do
  begin
   Items.Clear;
   InfoBox.Color:=ListOptions.BackColor1;
   //
   temp:=AmpViewMainForm.ItemAbout.Caption;
   if temp[1]='&'
    then temp:=Copy(temp, 2, Length(temp));

   temp:='AmpView. '+version;

   //Items.Add(AmpViewMainForm.ItemAbout.Caption);

   Items.Add('AmpView version '+version);
   //Items.Add('');
   //Items.Add('                 version '+version);

   Items.Add('');
   Items.Add('(c) 2020, mod');
   if GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile)='Russian.lng'
    then Items.Add('Автор (c) 2004-2007 Николай Петроченко')
    else Items.Add('Author (c) 2004-2007 Nikolay Petrochenko');

   Items.Add('E-mail: Nik_vr@mail.ru');
   Items.Add('');
   Items.Add(OptionsForm.LanguageBox.Caption+': ' + GetIniString('main', 'language', GetLocaleInformation(LOCALE_SENGLANGUAGE)+'.lng', IniFile) );
   Items.Add(OptionsForm.TranslatorBox.Caption+': '+OptionsForm.TranslatorLabel.Caption);
   Items.Add('');
   Items.Add(OptionsForm.SkinBox.Caption+': '+SkinText.Description);
   Items.Add(SkinText.Author);
   Items.Add('');
   Items.Add('[ '+AmpViewMainForm.CloseBtn.Hint+' ]');      
  end;
end;

procedure TPlayListForm.InfoBoxDblClick(Sender: TObject);
begin
// ErrorMessage(IntToStr(InfoBox.ItemIndex)+'='+IntToStr(InfoBox.Items.Count-1));
// if (InfoBox.ItemIndex)=(InfoBox.Items.Count-1) then
 InfoBox.Visible:=false;
end;

procedure TPlayListForm.InfoBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then InfoBox.Visible:=false;
end;

procedure TPlayListForm.InfoBoxClick(Sender: TObject);
begin
if InfoBox.ItemIndex<0 then exit;
 if (InfoBox.ItemIndex)=(InfoBox.Items.Count-1) then
 InfoBox.Visible:=false;
end;

procedure TPlayListForm.PlayListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  If Source = PlayList then
    begin
      Accept := True;
    end;
end;

procedure TPlayListForm.PlayListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  MyItem : TListItem;
  src_indx,indx,top_item, bottom_item:integer;
  add1:integer;
begin
  if Source = PlayList then
    with Source as TListView do
      begin
      if GetItemAt(X,Y)<>nil then
        begin
        indx:=GetItemAt(X,Y).Index;
        if indx<0 then Exit;
        if ItemIndex<0 then Exit;
        if Selected=nil then exit;
        src_indx:=Selected.Index;
        if src_indx=indx then exit;
        top_item:=PlayList.TopItem.Index;
        //PlayList.Items.BeginUpdate;
        bottom_item:=top_item+PlayList.VisibleRowCount-1;
        if bottom_item>Items.Count-1 then bottom_item:=Items.Count-1;
        add1:=0;
        if (src_indx<indx) then add1:=1;
        MyPlayList.InsertItem ( indx+add1 , MyPlayList.GetFileName(src_indx), MyPlayList.GetText(src_indx), MyPlayList.GetLength(src_indx));
        MyItem:=Items.Insert(indx+add1);
        MyItem.Assign(Selected);
        add1:=0;
        if (src_indx>indx) then add1:=1;
        MyPlayList.DeleteItem(src_indx+add1);
        //Selected.Delete;
        Items.Delete(src_indx+add1);
        RedrawPlayList;
        PlayList.SetFocus;
        PlayList.ItemIndex:=indx;
        if bottom_item>PlayList.Items.Count-1 then bottom_item:=PlayList.Items.Count-1;
        if bottom_item>=0 then
          begin
          PlayList.Items[top_item].MakeVisible(False);
          PlayList.Items[bottom_item].MakeVisible(False);
          end;
        //PlayList.Items.EndUpdate;
        end;
      end;
end;

procedure TPlayListForm.FormActivate(Sender: TObject);
begin                  
AmpViewMainForm.SetTopMost( GetIniBool('main', 'TopMost', false, IniFile) );
{if AmpViewMainForm.IsEmbedded then
  begin
  AmpViewMainForm.DoDeactivate;
  end; }
end;

procedure TPlayListForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=27 then
  begin
  SendMessage(AmpViewMainForm.Handle,WM_KEYDOWN,27,0);
  end;
end;

procedure TPlayListForm.PlayListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
keydowncnt:=0;
end;

end.
