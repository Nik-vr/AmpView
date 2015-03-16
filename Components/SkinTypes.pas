unit SkinTypes;

//  данный модуль содержит типы для работы со скинами

{$B-,R-}

interface

uses Windows, SysUtils, Classes, Graphics, GR32_Image, GR32;

//const
//  NEWREGSTR_PATH_SETUP = 'Software\Microsoft\Windows\CurrentVersion';

type
  TSkinTextAtributes= record
   //
   Name: string;
   Description: string;
   Author: string;
   Email: string;
   HomePage: string;
   //
   TrackCaptionVisible: boolean;
   TrackCaption: string;
   TrackCaptionShadow: boolean;
   TrackCaptionOffset: integer;
   //
   TimerVisible: boolean;
//   TimerCaption: string;
   TimerShadow: boolean;
   //
   BitRateVisible: boolean;
   BitRateCaption: string;
   BitRateLeft: integer;
   BitRateTop: integer;
   BitRateFont: TFont;
   BitRateShadow: boolean;
   //
   ChannelVisible: boolean;
   ChannelCaption: string;
   ChannelLeft: integer;
   ChannelTop: integer;
   ChannelFont: TFont;
   ChannelShadow: boolean;
   //
   SPSVisible: boolean;
   SPSCaption: string;
   SPSLeft: integer;
   SPSTop: integer;
   SPSFont: TFont;
   SPSShadow: boolean;
  end;

type
  TSizeableWindow=record
    LeftTopImage: TBitmap32;
    LeftImage: TBitmap32;
    LeftBottomImage: TBitmap32;
    RightTopImage: TBitmap32;
    RightImage: TBitmap32;
    RightBottomImage: TBitmap32;
    TopImage: TBitmap32;
    BottomImage: TBitmap32;
    LeftOffset: integer;
    RightOffset: integer;
    TopOffset: Integer;
    BottomOffset: Integer;
  end;

type
 TListOptions = record
  Font: TFont;
  SelectedFont: TFont;
  PlayedFont: TFont;
  SelectedPlayedFont: TFont;
  BackColor1: integer;
  BackColor2: integer;
  SelectedBackColor: integer;
  SelectedPlayedBackColor: integer;
end;


implementation

// здесь размещаются сами функции
//function GetLocaleInformation(Flag: Integer): string;
//var
//  pcLCA: array [0..20] of Char;
//begin
//  if GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, Flag, pcLCA, 19) <= 0 then
//    pcLCA[0] := #0;
//  Result := pcLCA;
//end;



end.

