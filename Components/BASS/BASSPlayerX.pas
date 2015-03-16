// ========================================================
// Multimedia Player, based on BASS sound system
// Delphi 7
// (c) 2005-2006 Nikolay Petrochenko
// ========================================================


unit BASSPlayerX;

interface

uses Windows, Messages, SysUtils, Classes, xIni, Dynamic_BASS,
     RT_basswma, tags, MyTools, bassmidi;

const
  WM_GetToEnd    = WM_USER + 107;    // message to notify that BASS reaches the end of a stream
  NumEQBands  = 10;     // Number of bands for equalizer
  MaxDX8Effect = 32;    // DX8 Effect range : 0 ~ 32
  EQBandWidth  : array[0..NumEQBands-1] of float =
                 (4, 4, 4, 4, 5, 6, 5, 4, 3, 3);
  EQFreq : array[0..NumEQBands-1] of float =
                 (80, 170, 310, 600, 1000, 3000, 6000, 10000, 12000, 14000);

  FLABUFLEN = 350;         // buffer length for flanger effect


type
 TPlayerMode=(pmPaused, pmStoped, pmPlayed, pmWaiting);
// TChannelType=(ctUnknow, ctStream, ctMusic, ctPluginDecoded);
 TNotifyEvent = procedure(Sender: TObject) of object;
 TSoundEffects = set of (Flanger, Equalizer, Echo, Reverb);

  TBandData = record
     CenterFreq : float;   // 80 ~ 16,000 (cannot exceed one-third of the sampling frequency)
     BandWidth  : float;   // Bandwidth, in semitones, in the range from 1 to 36
  end;

type
  TFileInfo = record
    BitRate: string;
    SampleRate: string;
    ChannelMode: string;
//    TrackCaption: string;
//    FileLength: integer;
  end;

  TEQGains = array [0..NumEQBands-1] of float;  // -15.0 ~ +15.0

  TEQBands = record
     Bands : word;     // Number of equalizer bands (0 ~ 10)
     BandPara : array[0..NumEQBands-1] of TBandData;
  end;

type TBASSPlayerX = Class(TObject)
  private
    FMode: TPlayerMode;
    FChannel: DWORD;
//    FChannelType: TChannelType;
    FFileInfo: TFileInfo;
    FTrackFile: string;
    FPosition: cardinal;
    FTrackLength: cardinal;
    FVolume: integer;
    FOnPlayEnd: TNotifyEvent;
    FEQParam: BASS_FX_DX8_PARAMEQ..12;
    FEQGains: TEQGains;
    FEQBands        : TEQBands;
    ReverbParam   : BASS_FX_DX8_REVERB..12;
    FSoundEffects: TSoundEffects;
    MessageHandle: HWND;
    FEchoLevel      : word;
    FReverbLevel    : word;
    EQParam       : BASS_FX_DX8_PARAMEQ..12;
    //
 //   DSPHandle     : HDSP;
    fladspHandle  : HDSP;
    EQHandle      : array [0..NumEQBands-1] of HFX;
    EchoHandle    : HFX;
    ReverbHandle  : HFX;
    EchoParam     : BASS_FX_DX8_ECHO..12;
    FDX8EffectReady : boolean;
//==================
  Chan: HSTREAM;
  sfont: HSOUNDFONT;
  fn: String;
  revfx: HFX;
  path: String;
  sf: BASS_MIDI_FONT;
  pR: BASS_FX_DX8_REVERB..12;
  lyrics: array [0..1000] of char; // lyrics buffer
 //==================


    procedure ProcMessage(var Msg: TMessage);
     function GetFileInfo: TFileInfo;
     function GetTrackPosition: cardinal;
    procedure SetTrackPosition(const Value: cardinal);
    procedure FSetVolume(const Value: integer);
  public
    constructor Create(Handle: HWND; const DllPath: string);

    function SetAEQGain(BandNum : integer; EQGain : float) : boolean;
    property Mode: TPlayerMode read FMode;
    property FileInfo: TFileInfo read FFileInfo;
    property TrackFile: string read FTrackFile;
    property Position: cardinal read GetTrackPosition write SetTrackPosition;
    property Volume: integer read FVolume write FSetVolume;
    property TrackLength: cardinal read FTrackLength;

    function GetTrackTime(Left: boolean): string;
    function GetFullTime: string;
    function GetTrackCaption(FileName: string; FormatString: string): string;
    function GetTrackLength(FileName: string): cardinal;
    procedure Mute;
    procedure UnMute;
    procedure OpenFile(const FileName: string);
    procedure Play;
    procedure Stop;
    procedure Pause;
    function BassLenToTime(len: cardinal): string;
    destructor Destroy; override;
  published
    property OnPlayEnd : TNotifyEvent read FOnPlayEnd write FOnPlayEnd;
  end;


 procedure SetFlangeParams;
 procedure Flange(handle: HSYNC; channel: DWORD; buffer: Pointer; length, user: DWORD); stdcall;


implementation

var
//  FEQBands: TEQBands;
//  EQParam: BASS_FXPARAMEQ;
  // Variables for DSP (flanger effect) implementation
  flabuf : array[0..FLABUFLEN-1, 0..2] of SmallInt;  // buffer
  flapos : Integer;         // cur.pos
  flas, flasinc : FLOAT;    // sweep pos/min/max/inc


// This procedure is called when a stream reaches the end.
procedure PlayEndSync(SyncHandle : HSYNC; Channel, data, user : DWORD); stdcall;
begin
   PostMessage(user, WM_GetToEnd, 0, 0);
end;


procedure SetFlangeParams;
begin
   FillChar(flabuf, SizeOf(flabuf), 0);
   flapos := 0;
   flas := FLABUFLEN / 2;
   flasinc := 0.002;
end;

function fmod(a, b: FLOAT): FLOAT;
begin
   Result := a - (b * Trunc(a / b));
end;

function Clip(a: Integer): Integer;
begin
   if a <= -32768 then
      a := -32768
   else if a >= 32767 then
      a := 32767;

   Result := a;
end;

procedure Flange(handle: HSYNC; channel: DWORD; buffer: Pointer; length, user: DWORD); stdcall;
var
  lc, rc: SmallInt;
  p1, p2, s: Integer;
  d: ^DWORD;
  f: FLOAT;
begin
  d := buffer;
  while (length > 0) do
  begin
    lc := LOWORD(d^); rc := HIWORD(d^);
    p1 := (flapos + Trunc(flas)) mod FLABUFLEN;
    p2 := (p1 + 1) mod FLABUFLEN;
    f := fmod(flas, 1.0);
    s := lc + Trunc(((1.0-f) * flabuf[p1, 0]) + (f * flabuf[p2, 0]));
    flabuf[flapos, 0] := lc;
    lc := Clip(s);
    s := rc + Trunc(((1.0-f) * flabuf[p1, 1]) + (f * flabuf[p2, 1]));
    flabuf[flapos, 1] := rc;
    rc := Clip(s);
    d^ := MakeLong(lc, rc);
    Inc(d);
    Inc(flapos);
    if (flapos = FLABUFLEN) then flapos := 0;
    flas := flas + flasinc;
    if (flas < 0) or (flas > FLABUFLEN) then
      flasinc := -flasinc;
    length := length - 4;
  end;
end;


// Создание объектов
constructor TBASSPlayerX.Create(Handle: HWND; const DllPath: string);
var
 SR: TSearchRec;
 i: integer;
begin
  Load_BASSDLL(DllPath + '\bass.dll');
  Load_BASSWMADLL(DllPath + '\basswma.dll');
  BASS_Init(-1, 44100, BASS_DEVICE_SPEAKERS, Handle, nil);
  //
  if BASS_MIDI_StreamGetFonts(0,sf,1)>=1 then sfont := sf.font;
  //
  i := FindFirst(DllPath+'\Formats\bass*.dll', faAnyFile, sR);
  while i = 0 do
  begin
    if (BASS_PluginLoad(pchar(DllPath+'\Formats\'+sR.Name), 0) <> 0) then
     begin
//        ErrorMessage('OK!');
     end; // plugin loaded...
    i := FindNext(sR);
  end;
  FindClose(sR);

  FMode:=pmWaiting;
  FVolume:=100;
  FPosition:=0;
  MessageHandle := AllocateHWnd(ProcMessage);
  //
   FEQBands.Bands := NumEQBands;
   for i := 0 to (NumEQBands-1) do
   begin
      FEQGains[i] := 0;
      FEQBands.BandPara[i].CenterFreq := EQFreq[i];
      FEQBands.BandPara[i].BandWidth := EQBandWidth[i];
   end;
   FEchoLevel := MaxDX8Effect div 2{16};
   FReverbLevel := MaxDX8Effect div 2{16};
end;


// Разрушение объектов
destructor TBASSPlayerX.Destroy;
begin
  BASS_Stop;
  Unload_BASSDLL;
  Unload_BASSWMADLL;
//
 inherited Destroy;
end;


// Открытие трека
procedure TBASSPlayerX.OpenFile(const FileName: String);
var
 BASS_Flags: cardinal;
begin
 // Открытие канала
 FTrackFile:=FileName;

 BASS_Flags:=0;

 FChannel:=Bass_StreamCreateFile(false, PChar(FTrackFile), 0, 0, BASS_Flags);

 if FChannel = 0
  then FChannel := Bass_WMA_StreamCreateFile(false, PChar(FTrackFile), 0, 0, 0);

 if FChannel = 0
  then FChannel :=BASS_MusicLoad(FALSE, PChar(FTrackFile), 0, 0, BASS_MUSIC_PRESCAN or BASS_MUSIC_STOPBACK, 0);

 if FChannel = 0
  then FChannel := BASS_MIDI_StreamCreateFile(FALSE, PChar(FTrackFile),0,0,BASS_SAMPLE_LOOP,0);

 if FChannel = 0
  then exit;

 // Информация
 FFileInfo:=GetFileInfo;
 FTrackLength:=BASS_ChannelGetLength(FChannel, BASS_POS_BYTE);

end;


// Получение информации о файле
function TBASSPlayerX.GetFileInfo: TFileInfo;
var
 chInfo: BASS_CHANNELINFO;
 time: real;
 len: cardinal;
 br: integer;
begin
 BASS_ChannelGetInfo(FChannel, chInfo);

 result.SampleRate:=IntToStr(chInfo.freq)+' Hz';

 if chInfo.chans =1
  then result.ChannelMode:='Mono'
  else
   if chInfo.chans =2
    then result.ChannelMode:='Stereo'
    else result.ChannelMode:=IntToStr(chInfo.chans)+' ch';

  time:=BASS_ChannelBytes2Seconds(FChannel, BASS_ChannelGetLength(FChannel, BASS_POS_BYTE)); // playback duration
  len:=BASS_StreamGetFilePosition(FChannel, BASS_FILEPOS_END); // file length

  br:= Round ( len/(125*time)+0.5 ); // bitrate (Kbps)
//Round
//  if
  result.BitRate:=IntToStr(br)+' kB/s';
end;


// Получение заголовка трека
function TBASSPlayerX.GetTrackCaption(FileName: string; FormatString: string): string;
var
 Channel: HStream;
begin
  result:=ExtractFileName(FileName);

  try
   Channel := Bass_StreamCreateFile(false, PChar(FileName), 0, 0, 0);
   if Channel = 0
    then Channel := Bass_WMA_StreamCreateFile(false, PChar(FileName), 0, 0, 0);

   if Channel = 0
    then
     begin
      Channel := BASS_MIDI_StreamCreateFile(FALSE, PChar(FileName),0,0,BASS_SAMPLE_LOOP,0);
      Result:=String(BASS_ChannelGetTags(Channel,BASS_TAG_MIDI_TRACK));
     end;

   if Channel <> 0
    then result:=TAGS_Read(Channel, PChar(FormatString))
    else exit;
//
  except
   exit;
  end;

  if Length(result)<=3 then result:=ExtractFileName(FileName);
end;


// Получение времени трека
function TBASSPlayerX.GetTrackLength(FileName: string): cardinal;
var
 Channel: HStream;
 FloatLen : FLOAT;
 len: cardinal;
begin
  result:=0;

 try
  Channel:=Bass_StreamCreateFile(false, PChar(FileName), 0, 0, 0);

  if Channel = 0
   then Channel := Bass_WMA_StreamCreateFile(false, PChar(FileName), 0, 0, 0);

  if Channel = 0
   then Channel :=BASS_MusicLoad(false, PChar(FileName), 0, 0, 0, 0);

  if Channel = 0 then exit;

  except
   exit;
  end;

  Len := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);

  FloatLen:= BASS_ChannelBytes2Seconds(Channel, Len);
  result:= round(1000 * FloatLen);   // sec -> milli sec

end;

procedure TBASSPlayerX.Play;
begin
 if Mode=pmPaused
  then BASS_ChannelPlay(FChannel, false)
  else BASS_ChannelPlay(FChannel, true);
//
 BASS_ChannelSetSync(FChannel, BASS_SYNC_END, 0, @PlayEndSync, 0);

 FMode:=pmPlayed;
end;

procedure TBASSPlayerX.Pause;
begin
 BASS_ChannelPause(FChannel);
 FMode:=pmPaused;
end;

procedure TBASSPlayerX.Stop;
begin
 BASS_ChannelStop(FChannel);
 SetTrackPosition(0);
 FMode:=pmStoped;
end;


function TBASSPlayerX.GetTrackPosition: cardinal;
begin
 result:=BASS_ChannelGetPosition(FChannel, BASS_POS_BYTE);
end;

procedure TBASSPlayerX.SetTrackPosition(const Value: cardinal);
begin
 BASS_ChannelSetPosition(FChannel, value, BASS_POS_BYTE);
 FPosition:=Value;
end;


function TBASSPlayerX.BassLenToTime(len: cardinal): string;
const
 kd=1000 * 24 * 60 * 60;
 l=3600000;
var
  FloatLen : FLOAT;
  temp: cardinal;
begin
   result:= '00:00';
   //
   FloatLen:= BASS_ChannelBytes2Seconds(FChannel, Len);
   temp:= round(1000 * FloatLen);   // sec -> milli sec
   if temp<=l
    then result:=FormatDateTime ('nn:ss', temp / kd)
    else result:=FormatDateTime ('hh"/"nn', temp / kd)    
end;


function TBASSPlayerX.GetTrackTime(Left: boolean): string;
begin
 if left
  then result:='-'+BassLenToTime(FTrackLength-GetTrackPosition)
  else result:=' '+BassLenToTime(GetTrackPosition);
end;

function TBASSPlayerX.GetFullTime: string;
begin
 result:=BassLenToTime(FTrackLength);
end;

procedure TBASSPlayerX.Mute;
begin
  BASS_SetConfig(BASS_CONFIG_GVOL_MUSIC, 0);
  BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, 0);
//  BASS_SetVolume(0);
end;

procedure TBASSPlayerX.UnMute;
begin
  BASS_SetConfig(BASS_CONFIG_GVOL_MUSIC, FVolume);
  BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, FVolume);
//  BASS_SetVolume(FVolume);
end;

procedure TBASSPlayerX.FSetVolume(const Value: integer);
begin
  FVolume := Value;
  //
//  ErrorMessage(IntToStr(Value));
  BASS_ChannelSetAttribute(FChannel, BASS_ATTRIB_VOL, Value/100);
//  BASS_SetConfig(BASS_CONFIG_GVOL_MUSIC, Value);
//  BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, Value);
//  BASS_SetVolume(value/100);
end;

procedure TBASSPlayerX.ProcMessage(var Msg: TMessage);
begin
 if Msg.Msg=WM_GetToEnd then
  begin
   if Assigned(FOnPlayEnd) then FOnPlayEnd(Self);
  end;
end;


function TBASSPlayerX.SetAEQGain(BandNum : integer; EQGain : float) : boolean;   // * New at Ver 1.6
begin
   result := false;

//   if not FDX8EffectReady then
//      exit;
   if BandNum >= FEQBands.Bands then
      exit;

//  ErrorMessage('Полоса '+IntToStr(BandNum)+'='+FloatToStr(EqGain));

   if EQGain > 15.0 then
      FEQGains[BandNum] := 15.0
   else if EQGain < -15.0 then
      FEQGains[BandNum] := -15.0
   else
      FEQGains[BandNum] := EQGain;

end;


end.

