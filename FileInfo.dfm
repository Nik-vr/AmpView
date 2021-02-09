object FileInfoForm: TFileInfoForm
  Left = 257
  Top = 186
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'File Info'
  ClientHeight = 328
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CloseButton: TButton
    Left = 144
    Top = 296
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Close'
    Default = True
    TabOrder = 1
    OnClick = CloseButtonClick
  end
  object FileInfoPageControl: TPageControl
    Left = 8
    Top = 8
    Width = 353
    Height = 281
    ActivePage = TabSheetMetadata
    TabOrder = 0
    object TabSheetMetadata: TTabSheet
      Caption = 'Metadata'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 345
        Height = 253
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 100
          end
          item
            Caption = 'Value'
            Width = 220
          end>
        ColumnClick = False
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        PopupMenu = ListViewPopupMenu1
        ShowHint = False
        TabOrder = 0
        ViewStyle = vsReport
        OnEnter = ListView1Enter
        OnExit = ListView1Exit
      end
    end
    object TabSheetProperties: TTabSheet
      Caption = 'Properties'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object FileIconImage: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object TypeLabel: TLabel
        Left = 16
        Top = 120
        Width = 27
        Height = 13
        Caption = 'Type:'
      end
      object DurationLabel: TLabel
        Left = 16
        Top = 144
        Width = 43
        Height = 13
        Caption = 'Duration:'
      end
      object FileSizeLabel: TLabel
        Left = 16
        Top = 72
        Width = 40
        Height = 13
        Caption = 'File size:'
      end
      object BitrateLabel: TLabel
        Left = 16
        Top = 168
        Width = 33
        Height = 13
        Caption = 'Bitrate:'
      end
      object ChannelModeLabel: TLabel
        Left = 16
        Top = 216
        Width = 72
        Height = 13
        Caption = 'Channel Mode:'
      end
      object SampleRateLabel: TLabel
        Left = 16
        Top = 192
        Width = 64
        Height = 13
        Caption = 'Sample Rate:'
      end
      object LastModifiedLabel: TLabel
        Left = 16
        Top = 96
        Width = 66
        Height = 13
        Caption = 'Last Modified:'
      end
      object FileNameEdit: TEdit
        Left = 56
        Top = 24
        Width = 273
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object TypeEdit: TEdit
        Left = 152
        Top = 120
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
      object DurationEdit: TEdit
        Left = 152
        Top = 144
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object FileSizeEdit: TEdit
        Left = 152
        Top = 72
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object BitrateEdit: TEdit
        Left = 152
        Top = 168
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
      object ChannelModeEdit: TEdit
        Left = 152
        Top = 216
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
      end
      object SampleRateEdit: TEdit
        Left = 152
        Top = 192
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
      object LastModifiedEdit: TEdit
        Left = 152
        Top = 96
        Width = 177
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object Panel1: TPanel
        Left = 16
        Top = 56
        Width = 313
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 8
      end
    end
  end
  object ActionList1: TActionList
    Left = 200
    Top = 24
    object ActionCopy: TAction
      Caption = 'Copy'
      Enabled = False
      ShortCut = 16451
      OnExecute = ActionCopyExecute
    end
  end
  object ListViewPopupMenu1: TPopupMenu
    Left = 204
    Top = 136
    object Copy1: TMenuItem
      Action = ActionCopy
    end
  end
end
