object AboutForm: TAboutForm
  Left = 398
  Top = 267
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'About'
  ClientHeight = 215
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object AboutImage: TImage32
    Left = 0
    Top = 0
    Width = 271
    Height = 176
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 0
    OnMouseDown = AboutImageMouseDown
    object InfoBox: TListBox
      Left = 25
      Top = 15
      Width = 211
      Height = 111
      Style = lbOwnerDrawVariable
      BorderStyle = bsNone
      ItemHeight = 16
      TabOrder = 0
      OnDrawItem = InfoBoxDrawItem
      OnMouseUp = InfoBoxMouseUp
    end
  end
  object ActionList1: TActionList
    Left = 55
    Top = 45
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 27
      OnExecute = Action1Execute
    end
  end
end
