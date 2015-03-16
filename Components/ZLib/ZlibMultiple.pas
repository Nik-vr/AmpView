// ==========================================================
// Данный файл содежит процедуры для распаковки zLib-архивов
// ==========================================================

unit ZlibMultiple;

interface

uses SysUtils, Classes, ZLibEx;

  procedure DecompressFile(FileName, Directory: string; Overwrite: Boolean);
  procedure DecompressStream(Stream: TStream; Directory: string; Overwrite: Boolean);

implementation


procedure DecompressStream(Stream: TStream; Directory: string; Overwrite: Boolean);
var
  FileStream: TFileStream;
  ZStream: TZDecompressionStream;
  CStream: TMemoryStream;
  B: Byte;
  Tab: array [1..256] of Char;
  S: string;
  Count, FileSize, I: Integer;
  Buffer: array [0..1023] of Byte;
begin
  if (Length(Directory) > 0) and (Directory[Length(Directory)] <> PathDelim) then
    Directory := Directory + PathDelim;

  while Stream.Position < Stream.Size do
  begin
    //Read and force the directory
    Stream.Read(B, SizeOf(B));
    { (RB) Can be improved }
    Stream.Read(Tab, B);
    S := '';
    for I := 1 to B do
      S := S + Tab[I];
    ForceDirectories(Directory + S);
    if (Length(S) > 0) and (S[Length(S)] <> PathDelim) then
      S := S + PathDelim;

    //Read filename
    Stream.Read(B, SizeOf(B));
    { (RB) Can be improved }
    Stream.Read(Tab, B);
    for I := 1 to B do
      S := S + Tab[I];

    Stream.Read(FileSize, SizeOf(FileSize));
    Stream.Read(I, SizeOf(I));
    CStream := TMemoryStream.Create;
    try
      CStream.CopyFrom(Stream, I);
      CStream.Position := 0;

      //Decompress the file
      S := Directory + S;
      if Overwrite or not FileExists(S) then
      begin
        FileStream := TFileStream.Create(S, fmCreate or fmShareExclusive);
        ZStream := TZDecompressionStream.Create(CStream);
        try

          { (RB) ZStream has an OnProgress event, thus copyfrom can be used }
          repeat
            Count := ZStream.Read(Buffer, SizeOf(Buffer));
            FileStream.Write(Buffer, Count);
          until Count = 0;

        finally
          FileStream.Free;
          ZStream.Free;
        end;
      end;
    finally
      CStream.Free;
    end;
  end;
end;

procedure DecompressFile(FileName, Directory: string; Overwrite: Boolean);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Stream.Position := 0;
    DecompressStream(Stream, Directory, Overwrite);
  finally
    Stream.Free;
  end;
end;

end.

