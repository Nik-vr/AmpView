unit FileInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, ActnList, Clipbrd, Menus,
  System.Actions;

type
  TFileInfoForm = class(TForm)
    CloseButton: TButton;
    FileInfoPageControl: TPageControl;
    TabSheetMetadata: TTabSheet;
    TabSheetProperties: TTabSheet;
    FileIconImage: TImage;
    FileNameEdit: TEdit;
    TypeLabel: TLabel;
    TypeEdit: TEdit;
    DurationLabel: TLabel;
    DurationEdit: TEdit;
    FileSizeLabel: TLabel;
    FileSizeEdit: TEdit;
    BitrateLabel: TLabel;
    BitrateEdit: TEdit;
    ChannelModeLabel: TLabel;
    ChannelModeEdit: TEdit;
    SampleRateLabel: TLabel;
    SampleRateEdit: TEdit;
    LastModifiedLabel: TLabel;
    LastModifiedEdit: TEdit;
    Panel1: TPanel;
    ListView1: TListView;
    ActionList1: TActionList;
    ActionCopy: TAction;
    ListViewPopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionCopyExecute(Sender: TObject);
    procedure ListView1Enter(Sender: TObject);
    procedure ListView1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FileInfoForm: TFileInfoForm;

implementation

{$R *.dfm}

procedure TFileInfoForm.CloseButtonClick(Sender: TObject);
begin
close;
end;

procedure TFileInfoForm.FormShow(Sender: TObject);
begin
FileInfoPageControl.SetFocus;
end;

procedure TFileInfoForm.ActionCopyExecute(Sender: TObject);
var a:integer;
    s:string;
begin
if (not ListView1.Visible) or (not ListView1.Focused) then exit;
if ListView1.SelCount<=0 then Exit;
s:='';
for a:=0 to ListView1.Items.Count-1 do
  begin
  if not ListView1.Items[a].Selected then continue;
  s:=s+ListView1.Items[a].Caption;
  if ListView1.Items[a].Caption<>'' then s:=s+': ';
  if ListView1.Items[a].SubItems.Count>0 then s:=s+ListView1.Items[a].SubItems[0];
  s:=s+#13#10;
  end;
Clipboard.AsText:=s;
end;

procedure TFileInfoForm.ListView1Enter(Sender: TObject);
begin
ActionCopy.Enabled:=True;
end;

procedure TFileInfoForm.ListView1Exit(Sender: TObject);
begin
ActionCopy.Enabled:=false;
end;

end.
