unit xIni;
{$MODE Delphi}

{$B-,R-}

interface

uses Windows, SysUtils;

//
function GetIniString(const Section, Key, Default, Filename: String): String;
function GetIniInt(const Section, Key: String; const Default, Min, Max: Longint; const Filename: String): Longint;
function GetIniBool(const Section, Key: String; const Default: Boolean; const Filename: String): Boolean;
function SetIniString(const Section, Key, Value, Filename: String): Boolean;
function SetIniInt(const Section, Key: String; const Value: Longint; const Filename: String): Boolean;
function SetIniBool(const Section, Key: String; const Value: Boolean; const Filename: String): Boolean;

implementation

function GetIniString(const Section, Key, Default, Filename: String): String;
begin
  SetLength(Result, 1023);
  if Filename <> '' then
    SetLength(Result, GetPrivateProfileString(
      PChar(Section), PChar(Key), PChar(Default),
      @Result[1], 1024, PChar(Filename)))
  else
    SetLength(Result, GetProfileString(
      PChar(Section), PChar(Key), PChar(Default),
      @Result[1], 1024));
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

end.

