object OptionsForm: TOptionsForm
  Left = 510
  Top = 297
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 394
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000040030000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000808080808080808080808080808080
    808080808080808080808080808080808080808080808080808080808080C4A0
    8DBB8E7CBC917EBC927FBC927FBC927FBC927FBC937FBC927FBC927FBC927FBC
    927FBC927FBD917EBC917E808080C59A7CD5CABDD1C6B7D2C6B7D2C7B9D0C9BE
    DBCFBDE7D3B4D4C8B7D2CBBED0C9BDD1C6B6D2C6B7D9CBBDBC917E808080BC91
    7EE5FFFFE1FCFFE1FFFFF0FFFFFFFFEFC8E0F99589A6F7EED2F8FFFFE7F8FFE7
    F8FFE7F8FFE9FFFFBC917E808080BC917EE0FBFFE7F8FFE7F8FF7B95D085667F
    7C89A11375CBB184794C539DCDB0A3E8FAFDE7F8FFE7F8FFBC917E808080BC91
    7EE2FBFFE7F8FFE7F8FF7EC2DD2A86D23F96D663E8FF236BBD089CE6A8B2A4FD
    EBD0E7F8FFE7F8FFBC917E808080BC917EE2FBFFE7F8FF7284BC377EC580F1FF
    63D9FC5BCAEF4DD7FD3CCDF31A48A3C5B0AFE7F8FFE7F8FFBC917E808080BC91
    7EE3FCFFE7F8FF92D3EE5FCFF76ADCFFBBE3EF775D581D69A522B4EB00A5E2B0
    CED3E7F8FFE7F8FFBC917E808080BC917EE2FCFFE7F8FFE7F8FF83C3EC53CEFB
    DBF1F877564F268FB02ABFF085C9D5DEF4F8E7F8FFE7F8FFBC917E808080BC91
    7EE3FCFFE7F8FFE7F8FFA9C1E05CD2FECEE2E54F3734439DAF42CCF9F1E6E1E7
    F8FFE7F8FFE7FDFFBC917E808080BC917EE8FFFFE7F8FFE7F8FFECFFFFE8FFFF
    DDDBD3535353C7D0D5EEFFFFECFDFFE7F9FFE5F8FFECFFFFBC917E808080BC91
    7EDCEBE6DAE2DCDBE2DBDDE2DCE1E4DDE0E7DFE5EADEE5E8E2E2E4DDDBE1DBD9
    DDD8D9DFD9E4EBDEBC917E808080B25800AD5300AD5400AC5200AB5500AD5400
    AD5300AE5600AD5300AC5300AD5400B45F0EB75E04995829AF6A2B808080D987
    28E48A20E48515E38314E38313E48416E48416E38415E38113E2800DE17F0DE8
    8B1FEE8C1ACC8746C88542000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000800000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000010000FFFF0000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object CloseButton: TButton
    Left = 465
    Top = 360
    Width = 100
    Height = 28
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 2
    OnClick = ActionCancelExecute
  end
  object OptionsPages: TPageControl
    Left = 155
    Top = 10
    Width = 456
    Height = 342
    ActivePage = TabSheet2
    MultiLine = True
    TabHeight = 25
    TabOrder = 1
    TabPosition = tpRight
    TabWidth = 50
    object PageInterface: TTabSheet
      Caption = 'Interface'
      object LanguageBox: TGroupBox
        Left = 10
        Top = 5
        Width = 395
        Height = 181
        Caption = 'Language'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object LabelSelectLanguage: TLabel
          Left = 18
          Top = 25
          Width = 190
          Height = 16
          AutoSize = False
          Caption = 'Select language from list:'
        end
        object LangComboBox: TComboBox
          Left = 18
          Top = 49
          Width = 183
          Height = 22
          Style = csOwnerDrawFixed
          ItemHeight = 16
          TabOrder = 0
          OnChange = LangComboBoxChange
        end
        object TranslatorBox: TGroupBox
          Left = 15
          Top = 85
          Width = 365
          Height = 80
          Caption = 'Translator'
          TabOrder = 1
          object TranslatorLabel: TLabel
            Left = 12
            Top = 25
            Width = 344
            Height = 16
            AutoSize = False
            Caption = '???'
          end
          object TranslatorEmailLabel: TLabel
            Left = 12
            Top = 51
            Width = 339
            Height = 16
            Cursor = crHandPoint
            AutoSize = False
            Caption = '???'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clHotLight
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            OnClick = TranslatorEmailLabelClick
          end
        end
      end
      object EffectsBox: TGroupBox
        Left = 10
        Top = 195
        Width = 395
        Height = 85
        Caption = 'Effects'
        TabOrder = 1
        object UseShadows: TCheckBox
          Left = 15
          Top = 25
          Width = 371
          Height = 17
          Caption = 'To resolve display of shadows'
          TabOrder = 0
          OnClick = UseShadowsClick
        end
        object UseAntiAliasing: TCheckBox
          Left = 15
          Top = 55
          Width = 371
          Height = 17
          Caption = 'To resolve use of AntiAliasing'
          TabOrder = 1
          OnClick = UseAntiAliasingClick
        end
      end
    end
    object PagePlugins: TTabSheet
      Caption = 'Plugins'
      ImageIndex = 1
      object PluginsBox: TGroupBox
        Left = 10
        Top = 5
        Width = 395
        Height = 141
        Caption = 'Avaible plugins'
        TabOrder = 0
        object PluginsList: TListBox
          Left = 15
          Top = 25
          Width = 365
          Height = 95
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object ExtGroupBox: TGroupBox
        Left = 10
        Top = 155
        Width = 395
        Height = 155
        Caption = 'Extensions'
        TabOrder = 1
        object ExtListBox: TListBox
          Left = 15
          Top = 30
          Width = 245
          Height = 105
          ItemHeight = 16
          Sorted = True
          TabOrder = 0
          OnClick = ExtListBoxClick
        end
        object ExtEdit: TEdit
          Left = 280
          Top = 32
          Width = 96
          Height = 24
          TabOrder = 1
        end
        object DeleteBtn: TButton
          Left = 280
          Top = 108
          Width = 100
          Height = 28
          Caption = 'Delete'
          TabOrder = 3
          OnClick = DeleteBtnClick
        end
        object AddBtn: TButton
          Left = 280
          Top = 70
          Width = 100
          Height = 28
          Caption = 'Add'
          TabOrder = 2
          OnClick = AddBtnClick
        end
      end
    end
    object PageSkins: TTabSheet
      Caption = 'Skins'
      ImageIndex = 2
      object SkinPages: TPageControl
        Left = 0
        Top = 0
        Width = 415
        Height = 335
        ActivePage = TabSheet1
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Skin'
          object SkinBox: TGroupBox
            Left = 10
            Top = 5
            Width = 385
            Height = 290
            Caption = 'Skin'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object SkinList: TListBox
              Left = 15
              Top = 25
              Width = 355
              Height = 90
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 16
              ParentFont = False
              TabOrder = 0
              OnClick = SkinListClick
            end
            object InformationBox: TGroupBox
              Left = 15
              Top = 125
              Width = 355
              Height = 150
              Caption = 'Information'
              TabOrder = 1
              object SkinAutorLabel: TLabel
                Left = 12
                Top = 25
                Width = 340
                Height = 16
                AutoSize = False
                Caption = '???'
                WordWrap = True
              end
              object SkinEmailLabel: TLabel
                Left = 12
                Top = 50
                Width = 340
                Height = 16
                Cursor = crHandPoint
                AutoSize = False
                Caption = '???'
                Color = clBtnFace
                Font.Charset = ANSI_CHARSET
                Font.Color = clHotLight
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                OnClick = SkinEmailLabelClick
              end
              object SkinDescLabel: TLabel
                Left = 12
                Top = 100
                Width = 340
                Height = 41
                AutoSize = False
                Caption = '???'
              end
              object SkinHomePageLabel: TLabel
                Left = 12
                Top = 75
                Width = 340
                Height = 16
                Cursor = crHandPoint
                AutoSize = False
                Caption = '???'
                Font.Charset = ANSI_CHARSET
                Font.Color = clHotLight
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                OnClick = SkinHomePageLabelClick
              end
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'PlayList'
          ImageIndex = 1
          object FontBox: TGroupBox
            Left = 10
            Top = 5
            Width = 395
            Height = 131
            Caption = 'Font'
            TabOrder = 0
            object IgnoreSkinFontCheckBox: TCheckBox
              Left = 15
              Top = 25
              Width = 375
              Height = 17
              Caption = 'Ignore skin font'
              TabOrder = 0
              OnClick = IgnoreSkinFontCheckBoxClick
            end
            object SampleBox: TGroupBox
              Left = 210
              Top = 50
              Width = 176
              Height = 60
              Caption = 'Sample'
              TabOrder = 3
              object SampleLabel: TLabel
                Left = 2
                Top = 18
                Width = 55
                Height = 16
                Align = alClient
                Alignment = taCenter
                Caption = 'AaZz 123'
              end
            end
            object FontComboBox: TComboBox
              Left = 15
              Top = 55
              Width = 181
              Height = 22
              Style = csOwnerDrawVariable
              ItemHeight = 16
              TabOrder = 1
              OnChange = FontComboBoxChange
              OnDrawItem = FontComboBoxDrawItem
            end
            object FontSizeComboBox: TComboBox
              Left = 15
              Top = 85
              Width = 181
              Height = 24
              Style = csDropDownList
              ItemHeight = 16
              TabOrder = 2
              OnChange = FontSizeComboBoxChange
              Items.Strings = (
                '6'
                '8'
                '10'
                '12'
                '14'
                '16'
                '18')
            end
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'HotKeys'
      ImageIndex = 4
      object HotKeysPages: TPageControl
        Left = 0
        Top = 0
        Width = 415
        Height = 335
        ActivePage = TabSheet8
        TabOrder = 0
        object TabSheet8: TTabSheet
          Caption = 'Internal HotKeys'
          OnShow = TabSheet8Show
          object HotKeyGroupBox: TGroupBox
            Left = 10
            Top = 5
            Width = 385
            Height = 290
            Caption = 'HotKeys'
            TabOrder = 0
            object PressKeyBox1: TGroupBox
              Left = 10
              Top = 220
              Width = 365
              Height = 60
              Caption = 'Press Key or keys combination'
              TabOrder = 0
              object HotKeyEdit: THotKey
                Left = 15
                Top = 25
                Width = 165
                Height = 22
                HotKey = 0
                InvalidKeys = [hcNone]
                Modifiers = []
                TabOrder = 0
                OnChange = HotKeyEditChange
              end
            end
            object HotKeysBox: TListView
              Left = 15
              Top = 25
              Width = 355
              Height = 185
              Columns = <
                item
                  MaxWidth = 220
                  Width = 220
                end
                item
                  Alignment = taRightJustify
                  MaxWidth = 110
                  Width = 110
                end>
              ReadOnly = True
              RowSelect = True
              ShowColumnHeaders = False
              ShowWorkAreas = True
              TabOrder = 1
              ViewStyle = vsReport
              OnSelectItem = HotKeysBoxSelectItem
            end
            object ScrollBox1: TScrollBox
              Left = 15
              Top = 25
              Width = 341
              Height = 186
              Color = clWindow
              ParentColor = False
              TabOrder = 2
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Global'
          ImageIndex = 1
          object GlobalBox: TGroupBox
            Left = 10
            Top = 5
            Width = 385
            Height = 290
            Caption = 'Global HotKeys'
            TabOrder = 0
            object PressKeyBox2: TGroupBox
              Left = 10
              Top = 220
              Width = 365
              Height = 60
              Caption = 'Press Key or keys combination'
              TabOrder = 0
              object GlobalHotKeyEdit: THotKey
                Left = 15
                Top = 25
                Width = 165
                Height = 22
                HotKey = 0
                InvalidKeys = [hcNone]
                Modifiers = []
                TabOrder = 0
                OnChange = GlobalHotKeyEditChange
              end
            end
            object GlobalKeysBox: TListView
              Left = 15
              Top = 25
              Width = 355
              Height = 185
              Columns = <
                item
                  MaxWidth = 220
                  Width = 220
                end
                item
                  Alignment = taRightJustify
                  MaxWidth = 110
                  Width = 110
                end>
              ReadOnly = True
              RowSelect = True
              ShowColumnHeaders = False
              TabOrder = 1
              ViewStyle = vsReport
              OnSelectItem = GlobalKeysBoxSelectItem
            end
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'Mouse'
          ImageIndex = 2
          object MouseBox: TGroupBox
            Left = 10
            Top = 5
            Width = 390
            Height = 71
            Caption = 'Volume'
            TabOrder = 0
            object UseControl: TCheckBox
              Left = 15
              Top = 25
              Width = 366
              Height = 36
              Caption = 'Change Volume with mouse well only if [Ctrl] key pressed'
              TabOrder = 0
              WordWrap = True
              OnClick = UseControlClick
            end
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Other'
      ImageIndex = 5
      object RewindStepBox: TGroupBox
        Left = 10
        Top = 195
        Width = 395
        Height = 65
        Caption = 'Step of rewind (seconds)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object StepEdit: TEdit
          Left = 20
          Top = 25
          Width = 51
          Height = 24
          CharCase = ecUpperCase
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          Text = '1'
        end
        object ScrollStep: TUpDown
          Left = 71
          Top = 25
          Width = 20
          Height = 24
          Associate = StepEdit
          Min = 1
          Max = 50
          Position = 1
          TabOrder = 1
          Thousands = False
        end
      end
      object ListerGroupBox: TGroupBox
        Left = 10
        Top = 5
        Width = 395
        Height = 111
        Caption = 'Lister'
        TabOrder = 0
        object NotQVCheckBox: TCheckBox
          Left = 10
          Top = 22
          Width = 376
          Height = 36
          Caption = 'Not use AmpView for QuickView [Ctrl+Q]'
          TabOrder = 0
          WordWrap = True
          OnClick = NotQVCheckBoxClick
        end
        object NotNVCheckBox: TCheckBox
          Left = 10
          Top = 58
          Width = 376
          Height = 36
          Caption = 'Not use AmpView for Normal View [F3]'
          TabOrder = 1
          OnClick = NotNVCheckBoxClick
        end
      end
      object ConfigGroupBox: TGroupBox
        Left = 10
        Top = 125
        Width = 395
        Height = 61
        Caption = 'Configuration'
        TabOrder = 2
        object DefaultConfigCheckBox: TCheckBox
          Left = 10
          Top = 25
          Width = 376
          Height = 17
          Caption = 'Use only default configuration file for all users'
          TabOrder = 0
          OnClick = DefaultConfigCheckBoxClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'PlayList'
      ImageIndex = 5
      object OnEndTrackBox: TRadioGroup
        Left = 10
        Top = 5
        Width = 395
        Height = 145
        Caption = 'On end of a track'
        Items.Strings = (
          'Stop track'
          'Open next track from list'
          'Close AmpView'
          'Restart current track'
          'Open next track from folder')
        TabOrder = 0
        TabStop = True
        OnClick = OnEndTrackBoxClick
      end
      object FormatTrackBox: TGroupBox
        Left = 10
        Top = 155
        Width = 395
        Height = 76
        Caption = 'Format of track'#39's captions'
        TabOrder = 1
        object FSEdit: TEdit
          Left = 15
          Top = 30
          Width = 361
          Height = 24
          TabOrder = 0
          OnChange = FSEditChange
        end
      end
      object OtherGroupBox: TGroupBox
        Left = 10
        Top = 235
        Width = 395
        Height = 57
        Caption = 'Other'
        TabOrder = 2
        object WarningCheckBox: TCheckBox
          Left = 16
          Top = 24
          Width = 372
          Height = 17
          Caption = 'Show warnings of the track'#39's deleting'
          TabOrder = 0
          OnClick = WarningCheckBoxClick
        end
      end
    end
  end
  object OptionsList: TListBox
    Left = 10
    Top = 10
    Width = 140
    Height = 340
    ItemHeight = 16
    Items.Strings = (
      'Interface'
      'Plugins'
      'Skins'
      'HotKeys'
      'Other'
      'PlayList')
    TabOrder = 0
    OnClick = OptionsListClick
  end
  object HotKeyList: TListBox
    Left = 10
    Top = 355
    Width = 121
    Height = 21
    ItemHeight = 16
    Items.Strings = (
      'Play'
      'Stop'
      'Pause'
      '-'
      'VolumeUp'
      'VolumeDown'
      'Mute'
      '-'
      'Open'
      'OpenFolder'
      'NextTrack'
      'PrevTrack'
      'NextFile'
      '-'
      'TimeLeftMode'
      'TopMost'
      'Options'
      '-'
      'FileInfo'
      'PlayList'
      'Minimize')
    TabOrder = 3
    Visible = False
  end
  object GHotKeysList: TListBox
    Left = 145
    Top = 355
    Width = 121
    Height = 22
    ItemHeight = 16
    Items.Strings = (
      'Play'
      'Stop'
      'Pause'
      '-'
      'VolumeUp'
      'VolumeDown'
      'Mute'
      '-'
      'Restore'
      'NextTrack'
      'PrevTrack')
    TabOrder = 4
    Visible = False
  end
  object ActionList1: TActionList
    Left = 354
    Top = 361
    object ActionCancel: TAction
      Caption = 'Cancel'
      ShortCut = 27
      SecondaryShortCuts.Strings = (
        'Alt+F4')
      OnExecute = ActionCancelExecute
    end
  end
end
