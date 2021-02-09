object AmpViewMainForm: TAmpViewMainForm
  Left = 435
  Top = 276
  BorderIcons = [biMinimize]
  BorderStyle = bsNone
  Caption = 'AmpView'
  ClientHeight = 163
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000040040000000000000000000000000000000000000000
    0000000000000000000000000006000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000003010003200B00370300004A0000002C0000000B00000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00001F0B0021C84500D6C54400DA30100072000000450000000D000000000000
    0000000000000000000000000006000000060000000600000005000000000000
    000000000000010000013C15003FE25000F03010007200000040000000040000
    000003010003200B00371A090060190800601808005000000029000000040000
    00000000000000000000000000003C15003FC74500D70401004C000000270000
    00001F0B0021E95200F7CA4600E71D0900631B09003800000003000000000000
    000000000000000000000000000001000001B03D00BBAD3C00C70300004A0000
    001C00000006CC4600DAEE5400FD1A0900600000001E00000000000000000000
    00000000000000000000000000000000000006020007CD4700D9351200751908
    00601C090057CA4600E3EE5400FD1A0900600000001E00000000000000000000
    000000000000000000000000000000000000000000003F160042EB5300F93412
    00791D0A004DB23E00C0EE5400FD1A0900600000002100000000000000000000
    0000000000000000000000000000000000000000000005010005B43F00BEAC3C
    00C90300004A200A003EEC5300FB321100760000004100000004000000000401
    0005180600420000003E0000000B000000000000000001000001200B0038E650
    00F7321100761A090060EE5400FDC24300E20000004700000005000000009C31
    00BAD14300F81506005E0000001E0000000001000001AC3B00B89F3700CB3311
    0078E65000F74E1B008FEE5400FDC44400E30000004700000006000000003611
    003FB73A00DA1A07004B0000001D0000000001000001CB4700D7C54400E20401
    004CB23E00C0EE5400FDF05500FFC84600E50300004A00000018000000000000
    00001F0900241E09003F0200003D00000016000000003C15003FC74500D70401
    00431E0A0048E85100F8F05500FFEE5400FD1A0900600000001F000000000000
    00001F090024B73B00DD170600600000001700000000000000003C15003FAC3C
    00BCA83A00C34F1B008EEC5300FBEB5200FC1B0900620000002A000000000000
    0000030000031F09002402000005000000000000000000000000000000000501
    0005230C0024200A0025220B00263E1500448C31009C00000014000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000010000010000000000000000EFFF
    000083FF000081E10000C0800000F0810000F0030000F8030000FC030000FC01
    00000C010000080100000801000084010000860100008F010000FFFB0000}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object MainImage: TImage32
    Left = 0
    Top = 0
    Width = 256
    Height = 118
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    PopupMenu = MainPopupMenu
    Scale = 1.000000000000000000
    ScaleMode = smScale
    TabOrder = 0
    OnMouseDown = MainImageMouseDown
    OnMouseMove = MainImageMouseMove
    OnMouseUp = MainImageMouseUp
    object TimerImage: TImage32
      Left = 6
      Top = 5
      Width = 50
      Height = 24
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      Scale = 1.000000000000000000
      ScaleMode = smScale
      TabOrder = 0
      Visible = False
      OnDblClick = TimerImageDblClick
      OnMouseDown = TimerImageMouseDown
    end
    object TrackCaptionImage: TImage32
      Left = 11
      Top = 50
      Width = 234
      Height = 11
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smScale
      ShowHint = True
      TabOrder = 1
      Visible = False
      OnDblClick = TrackCaptionImageDblClick
      OnMouseDown = TrackCaptionImageMouseDown
    end
    object ProgressBar: TProgressBar32
      Left = 11
      Top = 68
      Width = 234
      Height = 12
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = False
      TabOrder = 2
      Visible = False
      OnMouseDown = ProgressBarMouseDown
      OnMouseMove = ProgressBarMouseMove
      OnMouseUp = ProgressBarMouseUp
    end
    object VolumeBar: TProgressBar32
      Left = 180
      Top = 94
      Width = 65
      Height = 8
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = False
      TabOrder = 3
      Visible = False
      OnMouseDown = VolumeBarMouseDown
      OnMouseMove = VolumeBarMouseMove
      OnMouseUp = VolumeBarMouseUp
    end
    object MinBtn: TButton32
      Left = 206
      Top = 4
      Width = 20
      Height = 12
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 4
      OnClick = MinBtnClick
    end
    object CloseBtn: TButton32
      Left = 229
      Top = 4
      Width = 19
      Height = 12
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 5
      OnClick = CloseBtnClick
    end
    object OpenBtn: TButton32
      Left = 180
      Top = 30
      Width = 20
      Height = 14
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 6
      OnClick = ActionOpenExecute
    end
    object InfoBtn: TButton32
      Left = 225
      Top = 30
      Width = 20
      Height = 14
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 7
      OnClick = ActionFileInfoExecute
    end
    object PlayListBtn: TButton32
      Left = 203
      Top = 30
      Width = 19
      Height = 14
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 8
      OnClick = ActionPlayListExecute
    end
    object PrevBtn: TButton32
      Left = 15
      Top = 90
      Width = 18
      Height = 18
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 9
      OnClick = ActionPrevTrackExecute
    end
    object NextBtn: TButton32
      Left = 105
      Top = 90
      Width = 18
      Height = 18
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 10
      OnClick = ActionNextTrackExecute
    end
    object MuteBtn: TButton32
      Left = 131
      Top = 90
      Width = 14
      Height = 14
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 11
      OnClick = ActionMuteExecute
    end
    object PlayBtn: TButton32
      Left = 38
      Top = 90
      Width = 19
      Height = 20
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 12
      OnClick = ActionPlayExecute
    end
    object PauseBtn: TButton32
      Left = 60
      Top = 90
      Width = 20
      Height = 20
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 13
      OnClick = ActionPauseExecute
    end
    object StopBtn: TButton32
      Left = 83
      Top = 90
      Width = 19
      Height = 20
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      ParentShowHint = False
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      ShowHint = True
      TabOrder = 14
      OnClick = ActionStopExecute
    end
  end
  object MainPopupMenu: TPopupMenu
    Left = 80
    Top = 133
    object ItemOpen: TMenuItem
      Action = ActionOpen
    end
    object ItemOpenFolder: TMenuItem
      Action = ActionOpenFolder
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ItemOptions: TMenuItem
      Action = ActionOptions
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ItemShufflePlay: TMenuItem
      Action = ActionShufflePlay
    end
    object ItemTimeMode: TMenuItem
      Action = ActionTimeLeftMode
    end
    object ItemTopMost: TMenuItem
      Action = ActionTopMost
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ItemControlMenu: TMenuItem
      Caption = 'Control'
      object ItemPlay: TMenuItem
        Action = ActionPlay
      end
      object ItemPause: TMenuItem
        Action = ActionPause
      end
      object ItemStop: TMenuItem
        Action = ActionStop
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object ItemPrevTrack: TMenuItem
        Action = ActionPrevTrack
      end
      object ItemNextTrack: TMenuItem
        Action = ActionNextTrack
      end
      object ItemNextFile: TMenuItem
        Action = ActionGetNextFile
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object ItemVolumeUp: TMenuItem
        Action = ActionVolumeUp
      end
      object ItemVolumeDown: TMenuItem
        Action = ActionVolumeDown
      end
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object ItemAbout: TMenuItem
      Action = ActionAbout
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object ItemClose: TMenuItem
      Action = ActionClose
    end
    object ItemDetach: TMenuItem
      Action = ActionDetach
    end
  end
  object ActionList: TActionList
    Left = 45
    Top = 133
    object ActionClose: TAction
      Category = #1054#1082#1085#1086
      Caption = 'Close'
      SecondaryShortCuts.Strings = (
        'Alt+F4')
      ShortCut = 27
      OnExecute = ActionCloseExecute
    end
    object ActionAbout: TAction
      Category = #1056#1072#1079#1085#1086#1077
      Caption = 'About...'
      ShortCut = 112
      OnExecute = ActionAboutExecute
    end
    object ActionRewind: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Rewind'
      OnExecute = ActionRewindExecute
    end
    object ActionForward: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Forward'
      OnExecute = ActionForwardExecute
    end
    object ActionVolumeUp: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Volume Up'
      SecondaryShortCuts.Strings = (
        'Ctrl+Up'
        'Num +')
      ShortCut = 107
      OnExecute = ActionVolumeUpExecute
    end
    object ActionVolumeDown: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Volume Down'
      SecondaryShortCuts.Strings = (
        'Ctrl+Down'
        'Num-')
      ShortCut = 109
      OnExecute = ActionVolumeDownExecute
    end
    object ActionFileInfo: TAction
      Category = #1056#1072#1079#1085#1086#1077
      Caption = 'File info...'
      ShortCut = 32819
      OnExecute = ActionFileInfoExecute
    end
    object ActionMute: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Mute'
      ShortCut = 77
      OnExecute = ActionMuteExecute
    end
    object ActionPlay: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Play'
      ShortCut = 88
      OnExecute = ActionPlayExecute
    end
    object ActionStop: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Stop'
      ShortCut = 86
      OnExecute = ActionStopExecute
    end
    object ActionPause: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Pause'
      ShortCut = 67
      OnExecute = ActionPauseExecute
    end
    object ActionOptions: TAction
      Caption = 'Options'
      ShortCut = 16464
      OnExecute = ActionOptionsExecute
    end
    object ActionTimeLeftMode: TAction
      Category = #1054#1082#1085#1086
      Caption = 'Time left mode'
      ShortCut = 16468
      OnExecute = ActionTimeLeftModeExecute
    end
    object ActionTopMost: TAction
      Category = #1054#1082#1085#1086
      Caption = 'Stay on Top'
      OnExecute = ActionTopMostExecute
    end
    object ActionPlayList: TAction
      Category = #1054#1082#1085#1086
      Caption = 'Show/Hide PlayList'
      SecondaryShortCuts.Strings = (
        'L')
      ShortCut = 32848
      OnExecute = ActionPlayListExecute
    end
    object ActionNextTrack: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Next track'
      ShortCut = 66
      OnExecute = ActionNextTrackExecute
    end
    object ActionPrevTrack: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Previous track'
      ShortCut = 90
      OnExecute = ActionPrevTrackExecute
    end
    object ActionGetNextFile: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Next file'
      ShortCut = 16450
      OnExecute = ActionGetNextFileExecute
    end
    object ActionOpen: TAction
      Caption = 'Open...'
      OnExecute = ActionOpenExecute
    end
    object ActionMinimizeToTray: TAction
      Caption = 'Minimize'
      OnExecute = ActionMinimizeToTrayExecute
    end
    object ActionRestoreFromTray: TAction
      Caption = 'ActionRestoreFromTray'
      OnExecute = ActionRestoreFromTrayExecute
    end
    object ActionCaseWindow: TAction
      Category = #1054#1082#1085#1086
      Caption = 'ActionCaseWindow'
      ShortCut = 9
      OnExecute = ActionCaseWindowExecute
    end
    object ActionEQ: TAction
      Category = #1054#1082#1085#1086
      Caption = 'ActionEQ'
      ShortCut = 16453
      OnExecute = ActionEQExecute
    end
    object ActionOpenFolder: TAction
      Caption = 'Open Folder...'
      OnExecute = ActionOpenFolderExecute
    end
    object ActionSelectAll: TAction
      Category = #1054#1082#1085#1086
      Caption = 'ActionSelectAll'
      ShortCut = 16449
      OnExecute = ActionSelectAllExecute
    end
    object ActionDetach: TAction
      Category = #1054#1082#1085#1086
      Caption = 'Detach'
      Enabled = False
      ShortCut = 16452
      Visible = False
      OnExecute = ActionDetachExecute
    end
    object ActionShufflePlay: TAction
      Category = #1054#1082#1085#1086
      Caption = 'Shuffle play'
      OnExecute = ActionShufflePlayExecute
    end
  end
  object XPManifest1: TXPManifest
    Left = 115
    Top = 133
  end
  object WorkTimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = WorkTimerTimer
    Left = 10
    Top = 133
  end
  object TrayPopupMenu: TPopupMenu
    Left = 150
    Top = 173
    object TrayItemRestore: TMenuItem
      Action = ActionRestoreFromTray
      Default = True
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object TrayItemStop: TMenuItem
      Action = ActionStop
    end
    object TrayItemPause: TMenuItem
      Action = ActionPause
    end
    object TrayItemPlay: TMenuItem
      Action = ActionPlay
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object TrayItemNextTrack: TMenuItem
      Action = ActionNextTrack
    end
    object TrayItemPreviousTtrack: TMenuItem
      Action = ActionPrevTrack
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object TrayItemOptions: TMenuItem
      Action = ActionOptions
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object TrayItemClose: TMenuItem
      Action = ActionClose
    end
  end
  object hwHintTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = hwHintTimerTimer
    Left = 200
    Top = 136
  end
  object DelayedExecutionTimer: TTimer
    Enabled = False
    Interval = 1
    Left = 160
    Top = 120
  end
end
