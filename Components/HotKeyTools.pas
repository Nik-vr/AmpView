unit HotKeyTools;

interface

uses Classes, Windows, Messages, SysUtils, Forms;


function HotKeyAvailable(HotKey: Cardinal): Boolean;
function HotKeyValid(HotKey: Cardinal): Boolean;
function GetHotKey(Modifiers, Key: Word): Cardinal;
procedure SeparateHotKey(HotKey: Cardinal; var Modifiers, Key: Word);
function HotKeyToText(HotKey: Cardinal; Localized: Boolean): String;
function TextToHotKey(Text: String; Localized: Boolean): Cardinal;

implementation

const
  HotKeyAtomPrefix = 'HotKeyManagerHotKey';
  // Non-localized (!) modifier names
  ModName_Shift = 'Shift';
  ModName_Ctrl  = 'Ctrl';
  ModName_Alt   = 'Alt';
  ModName_Win   = 'Win';

var
  EnglishKeyboardLayout: HKL;
  ShouldUnloadEnglishKeyboardLayout: Boolean;
  // Localized (!) modifier names
  LocalModName_Shift: String = ModName_Shift;
  LocalModName_Ctrl: String  = ModName_Ctrl;
  LocalModName_Alt: String   = ModName_Alt;
  LocalModName_Win: String   = ModName_Win;

{------------------- Static methods -------------------}

function GetHotKey(Modifiers, Key: Word): Cardinal;
// Get a shortcut from key and modifiers
const
  VK2_SHIFT   =  32;
  VK2_CONTROL =  64;
  VK2_ALT     = 128;
  VK2_WIN     = 256;
var
  hk: Cardinal;
begin
  hk := 0;
  if (Modifiers and MOD_ALT) <> 0 then
    Inc(hk, VK2_ALT);
  if (Modifiers and MOD_CONTROL) <> 0 then
    Inc(hk, VK2_CONTROL);
  if (Modifiers and MOD_SHIFT) <> 0 then
    Inc(hk, VK2_SHIFT);
  if (Modifiers and MOD_WIN) <> 0 then
    Inc(hk, VK2_WIN);
  hk := hk shl 8;
  Inc(hk, Key);
  Result := hk;
end;


procedure SeparateHotKey(HotKey: Cardinal; var Modifiers, Key: Word);
// Separate key and modifiers, so they can be used with RegisterHotKey
const
  VK2_SHIFT   =  32;
  VK2_CONTROL =  64;
  VK2_ALT     = 128;
  VK2_WIN     = 256;
var
  Virtuals: Integer;
  V: Word;
//  x: Byte;
  x: Word;
begin
  Key := Byte(HotKey);
  x := HotKey shr 8;
  Virtuals := x;
  V := 0;
  if (Virtuals and VK2_WIN) <> 0 then
    Inc(V, MOD_WIN);
  if (Virtuals and VK2_ALT) <> 0 then
    Inc(V, MOD_ALT);
  if (Virtuals and VK2_CONTROL) <> 0 then
    Inc(V, MOD_CONTROL);
  if (Virtuals and VK2_SHIFT) <> 0 then
    Inc(V, MOD_SHIFT);
  Modifiers := V;
end;


function HotKeyAvailable(HotKey: Cardinal): Boolean;
// Test if HotKey is available (test if it can be registered - by this or any app.)
var
  M, K: Word;
  Atom: Word;
begin
  Atom := GlobalAddAtom(PChar('HotKeyManagerHotKeyTest'));
  SeparateHotKey(HotKey, M, K);
  Result := RegisterHotKey(Application.Handle, Atom, M, K);
  if Result then
    UnregisterHotKey(Application.Handle, Atom);
  GlobalDeleteAtom(Atom);
end;


function HotKeyValid(HotKey: Cardinal): Boolean;
// Test if HotKey is valid (test if it can be registered even if this app. already registered it)
var
  M, K: Word;
  WasRegistered: Boolean;
  Atom: Word;
begin
  Atom := GlobalAddAtom(PChar(HotKeyAtomPrefix + IntToStr(HotKey)));
  SeparateHotKey(HotKey, M, K);
  WasRegistered := UnregisterHotKey(Application.Handle, Atom);
  if WasRegistered then
  begin
    RegisterHotKey(Application.Handle, Atom, M, K);
    Result := True;
  end
  else
  begin
    Result := RegisterHotKey(Application.Handle, Atom, M, K);
    if Result then
      UnregisterHotKey(Application.Handle, Atom);
  end;
  GlobalDeleteAtom(Atom);
end;


function HotKeyToText(HotKey: Cardinal; Localized: Boolean): String;
// Return localized(!) or English(!) string value from key combination

  function GetModifierNames: String;
  var
    S: String;
  begin
    S := '';
    if Localized then
    begin
      if (HotKey and $4000) <> 0 then       // scCtrl
        S := S + LocalModName_Ctrl + '+';
      if (HotKey and $2000) <> 0 then       // scShift
        S := S + LocalModName_Shift + '+';
      if (HotKey and $8000) <> 0 then       // scAlt
        S := S + LocalModName_Alt + '+';
      if (HotKey and $10000) <> 0 then
        S := S + LocalModName_Win + '+';
    end
    else
    begin
      if (HotKey and $4000) <> 0 then       // scCtrl
        S := S + ModName_Ctrl + '+';
      if (HotKey and $2000) <> 0 then       // scShift
        S := S + ModName_Shift + '+';
      if (HotKey and $8000) <> 0 then       // scAlt
        S := S + ModName_Alt + '+';
      if (HotKey and $10000) <> 0 then
        S := S + ModName_Win + '+';
    end;
    Result := S;
  end;

  function GetVKName(Extended: Boolean): String;
  var
    ScanCode: Cardinal;
    KeyName: array[0..255] of Char;
    oldkl: HKL;
//    engkl: HKL;
{    kllist: array[0..255] of HKL;
    layouts: Cardinal;
    I: Integer; }
  begin
    Result := '';
    if Localized then        // Local language key names
    begin
      if Extended then
        ScanCode := (MapVirtualKey(Byte(HotKey), 0) shl 16) or (1 shl 24)
      else
        ScanCode := (MapVirtualKey(Byte(HotKey), 0) shl 16);
      if ScanCode <> 0 then
      begin
        GetKeyNameText(ScanCode, KeyName, SizeOf(KeyName));
        Result := KeyName;
      end;
    end
    else                     // English key names
    begin
      if Extended then
        ScanCode := (MapVirtualKeyEx(Byte(HotKey), 0, EnglishKeyboardLayout) shl 16) or (1 shl 24)
      else
        ScanCode := (MapVirtualKeyEx(Byte(HotKey), 0, EnglishKeyboardLayout) shl 16);
      if ScanCode <> 0 then
      begin
        oldkl := GetKeyboardLayout(0);
        if oldkl <> EnglishKeyboardLayout then
          ActivateKeyboardLayout(EnglishKeyboardLayout, 0);  // Set English kbd. layout
        GetKeyNameText(ScanCode, KeyName, SizeOf(KeyName));
        Result := KeyName;
        if oldkl <> EnglishKeyboardLayout then
        begin
          if ShouldUnloadEnglishKeyboardLayout then
            UnloadKeyboardLayout(EnglishKeyboardLayout);     // Restore prev. kbd. layout
          ActivateKeyboardLayout(oldkl, 0);
        end;
      end;
    end;
  end;

var
  KeyName: String;
begin
  case Byte(HotKey) of
    // PgUp, PgDn, End, Home, Left, Up, Right, Down, Ins, Del
    $21..$28, $2D, $2E: KeyName := GetVKName(True);
  else
    KeyName := GetVKName(False);
  end;
  Result := GetModifierNames + KeyName;
end;


function TextToHotKey(Text: String; Localized: Boolean): Cardinal;
// Return key combination created from (non-localized!) string value
var
  Tokens: TStringList;

  function GetModifiersValue: Word;
  var
    I: Integer;
    M: Word;
    ModName: String;
  begin
    M := 0;
    for I := 0 to Tokens.Count -2 do
    begin
      ModName := Trim(Tokens[I]);
      if (AnsiCompareText(ModName, ModName_Shift) = 0) or
         (AnsiCompareText(ModName, LocalModName_Shift) = 0) then
        M := M or MOD_SHIFT
      else if (AnsiCompareText(ModName, ModName_Ctrl) = 0) or
              (AnsiCompareText(ModName, LocalModName_Ctrl) = 0) then
        M := M or MOD_CONTROL
      else if (AnsiCompareText(ModName, ModName_Alt) = 0) or
              (AnsiCompareText(ModName, LocalModName_Alt) = 0) then
        M := M or MOD_ALT
      else if (AnsiCompareText(ModName, ModName_Win) = 0) or
              (AnsiCompareText(ModName, LocalModName_Win) = 0) then
        M := M or MOD_WIN
      else
      begin
        // Unrecognized modifier encountered
        Result := 0;
        Exit;
      end;
    end;
    Result := M;
  end;

  function IterateVKNames(KeyName: String): Word;
  var
    I: Integer;
    K: Word;
  begin
    K := 0;
    for I := $08 to $FF do        // The brute force approach
      if AnsiCompareText(KeyName, HotKeyToText(I, Localized)) = 0 then
      begin
        K := I;
        Break;
      end;
    Result := K;
  end;

  function GetKeyValue: Word;
  var
    K: Word;
    KeyName: String;
    C: Char;
  begin
    K := 0;
    if Tokens.Count > 0 then
    begin
      KeyName := Trim(Tokens[Tokens.Count-1]);
      if Length(KeyName) = 1 then
      begin
        C := UpCase(KeyName[1]);
        case Byte(C) of
          $30..$39, $41..$5A:     // 0..9, A..Z
            K := Ord(C);
        else
          K := IterateVKNames(C);
        end;
      end
      else
      begin
        if (KeyName <> ModName_Ctrl) and (KeyName <> LocalModName_Ctrl) and
           (KeyName <> ModName_Alt) and (KeyName <> LocalModName_Alt) and
           (KeyName <> ModName_Shift) and (KeyName <> LocalModName_Shift) and
           (KeyName <> ModName_Win) and (KeyName <> LocalModName_Win) then
        K := IterateVKNames(KeyName);
      end;
    end;
    Result := K;
  end;

var
  Modifiers, Key: Word;
begin
  Tokens := TStringList.Create;
  try
    ExtractStrings(['+'], [' '], PChar(Text), Tokens);
    Modifiers := GetModifiersValue;
    if (Modifiers = 0) and (Tokens.Count > 1) then
      // Something went wrong when translating the modifiers
      Result := 0
    else
    begin
      Key := GetKeyValue;
      if Key = 0 then
        // Something went wrong when translating the key
        Result := 0
      else
        Result := GetHotKey(Modifiers, Key);
    end;
  finally
    Tokens.Free;
  end;
end;


function IsUpperCase(S: String): Boolean;
var
  I: Integer;
  C: Byte;
begin
  Result := True;
  for I := 1 to Length(S) do
  begin
    C := Ord(S[I]);
    if (C < $41) or (C > $5A) then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

end.


