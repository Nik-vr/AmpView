unit xIni;

{$B-,R-}

interface

uses Windows, SysUtils, Classes;

//
function GetIniString(const Section, Key: String; Default: String; const Filename: String): String;
function GetIniInt(const Section, Key: String; const Default, Min, Max: Longint; const Filename: String): Longint;
function GetIniBool(const Section, Key: String; const Default: Boolean; const Filename: String): Boolean;
function SetIniString(const Section, Key, Value, Filename: String): Boolean;
function SetIniInt(const Section, Key: String; const Value: Longint; const Filename: String): Boolean;
function SetIniBool(const Section, Key: String; const Value: Boolean; const Filename: String): Boolean;
function ReadIniSection(const Section: string; FileName: string): TStringList;

implementation


function GetIniString(const Section, Key: String; Default: String; const Filename: String): String;
var
  BufSize, Len: Integer;
begin
  UniqueString(Default);
  BufSize := 256;
  while True do begin
    SetString(Result, nil, BufSize);
    if Filename <> '' then
      Len := GetPrivateProfileString(PChar(Section), PChar(Key), PChar(Default),
        @Result[1], BufSize, PChar(Filename))
    else
      Len := GetProfileString(PChar(Section), PChar(Key), PChar(Default),
        @Result[1], BufSize);
    if Len <> 0 then
      Len := StrLen(PChar(Result));
    if (Len < BufSize-8) or (BufSize >= 65536) then begin
      SetLength(Result, Len);
      Break;
    end;
    BufSize := BufSize * 2;
  end;
end;


function GetIniInt(const Section, Key: String;
  const Default, Min, Max: Longint; const Filename: String): Longint;
{ Reads a Longint from an INI file. If the Longint read is not between Min/Max
  then it returns Default. If Min=Max then Min/Max are ignored }
var
  S: String;
  E: Integer;
begin
  S := GetIniString(Section, Key, '', Filename);
  if S = '' then
    Result := Default
  else begin
    Val(S, Result, E);
    if (E <> 0) or ((Min <> Max) and ((Result < Min) or (Result > Max))) then
      Result := Default;
  end;
end;


function GetIniBool(const Section, Key: String; const Default: Boolean;
  const Filename: String): Boolean;
begin
  Result := GetIniInt(Section, Key, Ord(Default), 0, 0, Filename) <> 0;
end;

function SetIniString(const Section, Key, Value, Filename: String): Boolean;
begin
  if Filename <> '' then
    Result := WritePrivateProfileString(PChar(Section), PChar(Key),
      PChar(Value), PChar(Filename))
  else
    Result := WriteProfileString(PChar(Section), PChar(Key),
      PChar(Value));
end;

function SetIniInt(const Section, Key: String; const Value: Longint;
  const Filename: String): Boolean;
begin
  Result := SetIniString(Section, Key, IntToStr(Value), Filename);
end;

function SetIniBool(const Section, Key: String; const Value: Boolean;
  const Filename: String): Boolean;
begin
  Result := SetIniInt(Section, Key, Ord(Value), Filename);
end;


function ReadIniSection(const Section: string; FileName: string): TStringList;
const
  BufSize = 16384;
var
  Buffer, P: PChar;
begin
  result:=TStringList.Create;
  GetMem(Buffer, BufSize);
  try
    result.BeginUpdate;
    try
      result.Clear;
      if GetPrivateProfileString(PChar(Section), nil, nil, Buffer, BufSize,
        PChar(FileName)) <> 0 then
      begin
        P := Buffer;
        while P^ <> #0 do
        begin
          result.Add(P);
          Inc(P, StrLen(P) + 1);
        end;
      end;
    finally
      result.EndUpdate;
    end;
  finally
    FreeMem(Buffer, BufSize);
  end;
end;


end.


