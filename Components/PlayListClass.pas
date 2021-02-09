// ========================================================
// PlayListClass for AmpView 3.1+
// Compiled on Delphi 7, 2005
//    - loading/saving of PLS and M3U
// Based on PlayList (c) Porzillosoft Inc.
// http://digilander.iol.it/Kappe/audioobject
//
// Author (c) 2005 Nikolay Petrochenko


unit PlayListClass;

interface

uses Windows, Messages, SysUtils, Classes, xIni, MyTools, ComCtrls;

type TPlaylist = Class(TObject)
  private
    FileList   : TStringList;
    FileTitle  : TStringList;
    FileLength : TStringList;
    CurPlaylist  : String;
  public
    constructor Create;
    function LoadPLS(FileName : String; ClearCurrent : Boolean) : Boolean;
    function LoadM3U(FileName : String; ClearCurrent : Boolean) : Boolean;
    function LoadPlainList(FileName : String; ClearCurrent : Boolean) : Boolean;
    function SavePLS(FileName : String) : Boolean;
    function SaveXML(FileName : String) : Boolean;
    function SaveM3U(FileName : String) : Boolean;

    procedure Add(const FileName, Title : String; FileLen : Integer);
    function GetFileName( i : Integer) : String;
    function GetText( i : Integer) : String;
    function GetLength( i : Integer) : LongInt;

    procedure SetFileName( i : Integer; FileName : String);
    procedure SetText( i : Integer; FileName : String);
    procedure SetLength( i : Integer; Len : LongInt);

    procedure DeleteItem ( i : Integer);
    procedure InsertItem ( i : Integer; FileName, Title : String; FileLen:integer);

    function SearchByTitle (Title : String) : Integer;
    function SearchByFileName (FileName : String) : Integer;

    procedure Shuffle;
    procedure Sort(Attribute: byte; Reverse: boolean);

    procedure Clear;
    function Count : Integer;
    destructor Destroy; override;
  end;

implementation

uses viewer;

function GetNameFromM3U(EXTstring: string; Default: string): string;
var
 i: integer;
 pos: integer;
 len: integer;
begin
  result:=Default;
  pos:=0;
  if Copy(EXTstring, 1, 1) <> '#' then exit;

  len:=Length(EXTstring);
  for i:=0 to Len do
   begin
    if EXTstring[i]=',' then
     begin
      pos:=i;
      break;
     end;
   end;

   result:=Copy(EXTstring, pos+1, Len);
end;


function GetLengthFromM3U(EXTstring: string): string;
var
 i: integer;
 pos1, pos2: integer;
 len: integer;
begin
  result:='0';
  pos1:=0;
  pos2:=0;

  if Copy(EXTstring, 1, 1) <> '#' then exit;

  len:=Length(EXTstring);
  for i:=0 to Len do
   begin
    if EXTstring[i]=':' then
     begin
      pos1:=i;
      break;
     end;
   end;

  for i:=pos1 to Len do
   begin
    if EXTstring[i]=',' then
     begin
      pos2:=i;
      break;
     end;
   end;

   result:=Copy(EXTstring, pos1+1, pos2-pos1-1);
   // Г¤Г«Гї Г±Г®ГўГ¬ГҐГ±ГІГЁГ¬Г®Г±ГІГЁ Г± WinampEngine ГЇГҐГ°ГҐГўГ®Г¤ГЁГ¬ Гў Г¬ГЁГ«Г«ГЁГ±ГҐГЄГіГ­Г¤Г»
   try
    result:=IntToStr( StrToInt(result)*1000 );
   except
    result:='0';
   end;
end;


// Г‘Г®Г§Г¤Г Г­ГЁГҐ Г®ГЎГєГҐГЄГІГ®Гў
constructor TPlaylist.Create;
begin
  FileList  := TStringList.Create;
  FileTitle := TStringList.Create;
  FileLength := TStringList.Create;
end;


// Г‡Г ГЈГ°ГіГ§ГЄГ  ГЁГ§ PLS
function TPlaylist.LoadPLS(FileName : String; ClearCurrent : Boolean) : Boolean;
var
  i: Integer;
  FileINI: string;
  Temp: String;
  Num: integer;
  Dir: string;
begin
  CurPlaylist := FileName;
  Dir:=ExtractFileDir(FileName);
  try
   if ClearCurrent then
    begin
     FileList.Clear;
     FileTitle.Clear;
    end;
   FileINI := FileName;

   Num:=GetIniInt('playlist', 'NumberOfEntries', 0, 0, High(integer), FileINI)-1;
   for i := 0 to Num do
    begin
      Temp := GetIniString('playlist', 'File' + IntToStr(i + 1), '', FileINI);    
      if FileExists(temp)
       then
        begin
         FileList.Add(temp);
         FileTitle.Add( GetIniString('playlist', 'Title' + IntToStr(i + 1), ExtractFileName(Temp), FileINI) );
         FileLength.Add( GetIniString('playlist', 'Length' + IntToStr(i + 1), '0', FileIni) );
        end
       else
        if FileExists(Dir+'\'+temp)
         then
          begin
           FileList.Add(Dir+'\'+temp);
           FileTitle.Add( GetIniString('playlist', 'Title' + IntToStr(i + 1), ExtractFileName(Dir+'\'+Temp), FileINI) );
           FileLength.Add( GetIniString('playlist', 'Length' + IntToStr(i + 1), '0', FileIni) );
          end;
    end; // for
   result := True;
  except
   result := False;
  end;
end;


// Г‡Г ГЈГ°ГіГ§ГЄГ  ГЁГ§ M3U
function TPlaylist.LoadM3U(FileName : String; ClearCurrent : Boolean) : Boolean;
var
  i,x: Integer;
  FileINI: TStringList;
  Temp: String;
  Dir: string;
begin
  result:=false;
  if not FileExists(FileName) then exit;
  CurPlaylist := FileName;
  Dir:=ExtractFileDir(FileName);
  try
   if ClearCurrent then
    begin
     FileList.Clear;
     FileTitle.Clear;
    end;
   FileINI:= TStringList.Create;
   FileINI.LoadFromFile(LowerCase(FileName));
   //
   if FileIni.Count<1 then
     begin
     result:=false;
     Exit;
     end;
   if Copy(FileIni[0], 1, 7)<>'#EXTM3U' then
    begin
     result:=LoadPlainList(FileName, ClearCurrent);
     exit;
    end;
   //
   x:=FileINI.Count-1;
   for i:=1 to x do
    begin
     Temp:=FileINI[i];
     // Г„Г®ГЎГ ГўГ«ГїГҐГ¬ ГЁГ¬Гї ГґГ Г©Г«Г 
     if Copy(Temp, 1, 1)<>'#' then
     begin
      if FileExists(FileINI[i])
       then
        begin
         FileList.Add(temp);
         FileLength.Add(GetLengthFromM3U(FileINI[i-1]));
         FileTitle.Add(GetNameFromM3U(FileINI[i-1], ExtractFileName(temp)));
        end
       else
        if FileExists(Dir+'\'+temp)
         then
          begin
           FileList.Add(Dir+'\'+temp);
           FileLength.Add(GetLengthFromM3U(FileINI[i-1]));
           FileTitle.Add(GetNameFromM3U(FileINI[i-1], ExtractFileName(temp)));
          end
        else
          begin
          FileList.Add(temp);
          FileLength.Add('-1');
          FileTitle.Add(GetNameFromM3U(FileINI[i-1], ExtractFileName(temp)));
          end;
      end;
    end;
   result:=true;
  except
   result := False;
  end;
end;


// ГЏГ®Г«ГіГ·ГҐГ­ГЁГҐ ГЁГ¬ГҐГ­ГЁ ГґГ Г©Г«Г 
function TPlaylist.GetFileName( i : Integer) : String;
begin
if i>=FileList.Count then
  begin
  result:='-1';
  Exit;
  end;
 result := FileList[i];
end;


// ГЏГ®Г«ГіГ·ГҐГ­ГЁГҐ Г§Г ГЈГ®Г«Г®ГўГЄГ  ГІГ°ГҐГЄГ 
function TPlaylist.GetText( i : Integer) : String;
begin
  result := FileTitle[i];
end;


// ГЉГ®Г«ГЁГ·ГҐГ±ГІГўГ® ГІГ°ГҐГЄГ®Гў
function TPlaylist.Count : Integer;
begin
  result := FileList.Count;
end;


// Г‡Г ГЇГЁГ±Гј ГЁГ¬ГҐГ­ГЁ ГґГ Г©Г«Г 
procedure TPlaylist.SetFileName( i : Integer; FileName : String);
begin
  FileList[i] := FileName;
end;


// Г‡Г ГЇГЁГ±Гј Г§Г ГЈГ®Г«Г®ГўГЄГ  ГІГ°ГҐГЄГ 
procedure TPlaylist.SetText( i : Integer; FileName : String);
begin
  FileTitle[i] := FileName;
end;


// Г“Г¤Г Г«ГҐГ­ГЁГҐ Г§Г ГЇГЁГ±ГЁ
procedure TPlaylist.DeleteItem ( i : Integer);
begin
  FileList.Delete(i);
  FileTitle.Delete(i);
  FileLength.Delete(i);
end;


// Г‚Г±ГІГ ГўГЄГ  Г§Г ГЇГЁГ±ГЁ
procedure TPlaylist.InsertItem ( i : Integer; FileName, Title : String; FileLen:integer);
begin
  FileList.Insert(i, FileName);
  FileTitle.Insert(i, Title);
  FileLength.Insert (i, IntToStr(FileLen){'0'});
end;


// ГЋГ·ГЁГ±ГІГЄГ  Г±ГЇГЁГ±ГЄГ 
procedure TPlaylist.Clear;
begin
  FileList.Clear;
  FileTitle.Clear;
  FileLength.Clear;
end;


// Г„Г®ГЎГ ГўГ«ГҐГ­ГЁГҐ Г§Г ГЇГЁГ±ГЁ
procedure TPlaylist.Add(const FileName, Title : String; FileLen : Integer);
begin
  FileList.Add(FileName);
  FileTitle.Add (Title);
  FileLength.Add(IntToStr(FileLen));
end;


// ГЏГ®ГЁГ±ГЄ ГЇГ® Г§Г ГЈГ®Г«Г®ГўГЄГі
function TPlaylist.SearchByTitle (Title : String) : Integer;
begin
  Result := FileTitle.IndexOf(Title);
end;


// ГЏГ®ГЁГ±ГЄ ГЇГ® ГЁГ¬ГҐГ­ГЁ ГґГ Г©Г«Г 
function TPlaylist.SearchByFileName (FileName : String) : Integer;
begin
  Result := FileList.IndexOf(FileName);
end;


// Г‘Г®ГµГ°Г Г­ГҐГ­ГЁГҐ PLS
function TPlaylist.SavePLS(FileName : String) : Boolean;
var
 i: Integer;
 FileINI: string;
 Temp: String;
 fn:string;
begin
  try
   FileINI := FileName;
   Temp := ExtractFilePath(FileName);
   For i := 1 to FileList.Count do
    begin
    fn:=FileList[i - 1];
    if GetIniBool('main', 'UseRelativePaths', False, IniFile) then fn:=ExtractRelativePath(Temp, FileList[i - 1]);
     SetIniString('playlist', 'File' + IntToStr(i), fn, FileINI);
     SetIniString('playlist', 'Title' + IntToStr(i), FileTitle[i -1], FileIni);
     SetIniString('playlist', 'Length' + IntToStr(i), FileLength[i -1], FileIni);
    end;
   SetIniInt('playlist','NumberOfEntries', FileList.Count, FileIni);
   result := True;
  except
   result := False;
  end;
end;


// Г‘Г®Г§Г°Г Г­ГҐГ­ГЁГҐ M#U
function TPlaylist.SaveM3U(FileName : String) : Boolean;
var
  i: Integer;
  FileINI: TStringList;
  Temp: String;
  fn:string;
begin
  result:=false;
  try
   FileINI := TStringList.Create;
   Temp := ExtractFilePath(FileName);
   if not DirectoryExists(Temp) then
     begin
       if not CreateDir(Temp) then Exit;
     end;
   FileINI.Add('#EXTM3U');
   For i := 1 to FileList.Count do
    begin
    fn:=FileList[i - 1];
    if GetIniBool('main', 'UseRelativePaths', False, IniFile) then fn:=ExtractRelativePath(Temp, FileList[i - 1]);
    FileINI.Add('#EXTINF:' + FileLength[i - 1] + ',' + FileTitle[i - 1]);
    FileINI.Add(fn);
    end;
   {$IFDEF UNICODE}
   FileINI.SaveToFile(FileName,TEncoding.UTF8);
   {$ELSE}
   FileINI.SaveToFile(FileName);
   {$IFEND}
   FileINI.Free;
   result := True;
  except
   result := False;
  end;
end;


// Г‘Г®ГµГ°Г Г­ГҐГ­ГЁГҐ XML
function TPlaylist.SaveXML(FileName : String) : Boolean;
var
 i: Integer;
 FileINI: TStringList;
 Temp: String;
 fn:string;
begin
  try
   FileINI := TStringList.Create;
   Temp := ExtractFilePath(FileName);
   FileINI.Add('<?xml version="1.0" encoding="ISO-8859-1" ?>' + #13 +
               '<!-- XML Playlist created by AmpView 3.1 -->' + #13 +
               '<!DOCTYPE Playlist [' + #13 +
               '<!ELEMENT Playlist (Song*) >' + #13 +
               '<!ELEMENT Song (File, Title, Length) >' + #13 +
               '<!ELEMENT File (#PCDATA) >' + #13 +
               '<!ELEMENT Title (#PCDATA) >' + #13 +
               '<!ELEMENT Length (#PCDATA) >]>' + #13 +
               '<Playlist>');
   For i := 1 to FileList.Count do
    begin
     fn:=FileList[i - 1];
     if GetIniBool('main', 'UseRelativePaths', False, IniFile) then fn:=ExtractRelativePath(Temp, FileList[i - 1]);
     FileINI.Add('<Song>' + #13 +
                 '<File>' + fn + '</File>' + #13 +
                 '<Title>' + FileTitle[i - 1] + '</Title>' + #13 +
                 '<Length>' + FileLength[i - 1] + '</Length>'+ #13 +
                 '</Song>' + #13);
    end;
   FileINI.Add('</Playlist>');
   FileINI.SaveToFile(FileName);
   FileINI.Free;
   result := True;
  except
   result := False;
  end;
end;


// ГђГ Г§Г°ГіГёГҐГ­ГЁГҐ Г®ГЎГєГҐГЄГІГ®Гў
destructor TPlaylist.Destroy;
begin
  FileList.Destroy;
  FileTitle.Destroy;
  FileLength.Destroy;
end;


// Г‡Г ГЇГЁГ±Гј Г¤Г«ГЁГ­Г» ГІГ°ГҐГЄГ 
procedure TPlaylist.SetLength(i, Len : LongInt);
begin
  FileLength[i] := IntToStr(Len);
end;


// Г—ГІГҐГ­ГЁГҐ Г¤Г«ГЁГ­Г» ГІГ°ГҐГЄГ 
function TPlaylist.GetLength( i : Integer) : LongInt;
begin
  Result := StrToInt(FileLength[i]);
end;


function TPlaylist.LoadPlainList(FileName: String;
  ClearCurrent: Boolean): Boolean;
var
  i,x: Integer;
  FileINI: TStringList;
  Temp: String;
  Dir: string;
begin
  CurPlaylist := FileName;
  Dir:=ExtractFileDir(FileName);
  try
   if ClearCurrent then
    begin
     FileList.Clear;
     FileTitle.Clear;
    end;
   FileINI := TStringList.Create;
   FileINI.LoadFromFile(FileName);
   //
   x:=FileINI.Count-1;
   for i:=0 to x do
    begin
     Temp:=ExtractFilePath( FileINI[i] )+ExtractFileName( FileIni[i] );
     if not FileExists(temp)
      then temp:=dir+'\'+ExtractFileName( FileIni[i] );
     // Г„Г®ГЎГ ГўГ«ГїГҐГ¬ ГЁГ¬Гї ГґГ Г©Г«Г 
     if FileExists(temp) then
      begin
       FileList.Add(temp);
       FileLength.Add('0');
       FileTitle.Add(ExtractFileName(temp));
      end;
    end;
   result:=true;
  except
   result := False;
  end;
end;

procedure TPlaylist.Shuffle;
var
  pos: integer;
  len: integer;
begin
 Randomize;
 len:=FileList.Count;
 while len>=0 do
  begin
   pos:=Random(len);
   FileList.Add(FileList[pos]);
   FileLength.Add(FileLength[pos]);
   FileTitle.Add(FileTitle[pos]);
   //
   FileList.Delete(pos);
   FileLength.Delete(pos);
   FileTitle.Delete(pos);
   //
   len:=len-1;
  end;

end;


procedure TPlaylist.Sort(Attribute: byte; Reverse: boolean);
var
  i: integer;
  num: integer;
  FTit: TStringList;
  FLis: TStringList;
  FLen: TStringList;
begin
 // Подготовка временных списков
  FTit:=TStringList.Create;
  FLis:=TStringList.Create;
  FLen:=TStringList.Create;
  FTit.Clear;
  FLis.Clear;
  FLen.Clear;

  while FileList.Count>0 do
   begin
    // Ищем элемент списка в зависимости от параметров
    case Attribute of
     // Сортировка по заголовку
     1: begin
          // Обратная
          if Reverse
           then num:=FindMaxString(FileTitle)
           // прямая
           else num:=FindMinString(FileTitle);
        end;
     2: begin
          // Обратная
          if Reverse
           then num:=FindMaxString(FileList)
           // прямая
           else num:=FindMinString(FileList);
        end;
     3: begin
          // Обратная
          if Reverse
           then num:=FindMaxInt(FileLength)
           // прямая
           else num:=FindMinInt(FileLength);
        end;
     end;
    // Переносим его во временный список
    FTit.Add(FileTitle[num]);
    FLis.Add(FileList[num]);
    FLen.Add(FileLength[num]);
    // Удаляем из исходного списка
    FileTitle.Delete(num);
    FileList.Delete(num);
    FileLength.Delete(num);
   end; 

  // Передаем отсортированный список обратно
  for i:=0 to FTit.Count-1 do
   begin
    FileTitle.Add(FTit[i]);
    FileList.Add(FLis[i]);
    FileLength.Add(FLen[i]);
   end;

end;

end.


