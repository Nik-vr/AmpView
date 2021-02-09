object PlayListForm: TPlayListForm
  Left = 571
  Top = 306
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'PlayList'
  ClientHeight = 174
  ClientWidth = 299
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PLMainImage: TImage32
    Left = 0
    Top = 0
    Width = 241
    Height = 111
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 0
    object RightBottomImage: TImage32
      Left = 210
      Top = 90
      Width = 26
      Height = 17
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      TabOrder = 0
      OnMouseDown = RightBottomImageMouseDown
      OnMouseMove = RightBottomImageMouseMove
      OnMouseUp = RightBottomImageMouseUp
    end
    object PLCloseBtn: TButton32
      Left = 215
      Top = 5
      Width = 21
      Height = 11
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 1
      OnClick = PLCloseBtnClick
    end
    object PlayList: TListView
      Left = 13
      Top = 3
      Width = 191
      Height = 86
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Columns = <
        item
        end
        item
          Width = 0
        end
        item
          Alignment = taRightJustify
        end>
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNone
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      FlatScrollBars = True
      HideSelection = False
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      PopupMenu = PLPopupMenu
      ShowColumnHeaders = False
      TabOrder = 2
      ViewStyle = vsReport
      OnAdvancedCustomDraw = PlayListAdvancedCustomDraw
      OnAdvancedCustomDrawItem = PlayListAdvancedCustomDrawItem
      OnDblClick = PlayListDblClick
      OnDragDrop = PlayListDragDrop
      OnDragOver = PlayListDragOver
      OnKeyDown = PlayListKeyDown
      OnKeyUp = PlayListKeyUp
    end
  end
  object InfoBox: TListBox
    Left = 15
    Top = 120
    Width = 121
    Height = 26
    Style = lbOwnerDrawVariable
    BorderStyle = bsNone
    TabOrder = 1
    OnClick = InfoBoxClick
    OnDblClick = InfoBoxDblClick
    OnDrawItem = InfoBoxDrawItem
    OnMouseDown = InfoBoxMouseDown
  end
  object PLPopupMenu: TPopupMenu
    OnPopup = PLPopupMenuPopup
    Left = 255
    Top = 20
    object ItemFileInfo: TMenuItem
      Action = AmpViewMainForm.ActionFileInfo
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ItemView: TMenuItem
      Caption = 'View'
      object ShowFileNamesItem: TMenuItem
        Caption = 'File-names'
        RadioItem = True
        OnClick = ShowFileNamesItemClick
      end
      object ShowFullNameItem: TMenuItem
        Caption = 'Full names'
        RadioItem = True
        OnClick = ShowFullNameItemClick
      end
      object ShowTrackCaptionItem: TMenuItem
        Caption = 'Track caption'
        RadioItem = True
        OnClick = ShowTrackCaptionItemClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object ShowNumbersItem: TMenuItem
        Caption = 'Show numbers'
        OnClick = ShowNumbersItemClick
      end
      object ShowTracksLength: TMenuItem
        Caption = 'Show tracks length'
        OnClick = ShowTracksLengthClick
      end
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ItemSort: TMenuItem
      Caption = 'Sort tracks'
      object ItemSortByTitle: TMenuItem
        Action = ActionSortByTitle
        Caption = 'by title'
      end
      object ItemSortByFileName: TMenuItem
        Action = ActionSortByFileName
        Caption = 'by FileName'
      end
      object ItemSortByLength: TMenuItem
        Action = ActionSortByLength
        Caption = 'by length'
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ItemShuffle: TMenuItem
      Action = ActionSuffle
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ItemSavePlayList: TMenuItem
      Action = ActionSavePlayList
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ItemSentToFolder: TMenuItem
      Action = ActionSend
      Visible = False
    end
    object ItemDeleteTrack: TMenuItem
      Action = ActionDeleteTrack
    end
    object ItemDeleteFile: TMenuItem
      Action = ActionDeleteFiles
      Caption = 'Delete file'
    end
  end
  object ActionList1: TActionList
    Left = 255
    Top = 55
    object ActionDeleteTrack: TAction
      Caption = 'Delete track'
      ShortCut = 46
      OnExecute = ActionDeleteTrackExecute
    end
    object ActionDeleteFiles: TAction
      Caption = 'ActionDeleteFiles'
      ShortCut = 8238
      OnExecute = ActionDeleteFilesExecute
    end
    object ActionSend: TAction
      Caption = 'ActionSend'
      OnExecute = ActionSendExecute
    end
    object ActionSuffle: TAction
      Caption = 'Shuffle'
      ShortCut = 16576
      OnExecute = ActionSuffleExecute
    end
    object ActionSortByTitle: TAction
      Caption = 'Sort track by title'
      ShortCut = 16433
      OnExecute = ActionSortByTitleExecute
    end
    object ActionSortByFileName: TAction
      Caption = 'Sort by FileName'
      ShortCut = 16434
      OnExecute = ActionSortByFileNameExecute
    end
    object ActionSortByLength: TAction
      Caption = 'Sort by length'
      ShortCut = 16435
      OnExecute = ActionSortByLengthExecute
    end
    object ActionSavePlayList: TAction
      Caption = 'Save PlayList...'
      OnExecute = ActionSavePlayListExecute
    end
    object ActionCopyNames: TAction
      Caption = 'ActionCopyNames'
      ShortCut = 16451
      OnExecute = ActionCopyNamesExecute
    end
  end
end
