unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Generics.collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, JvCsvData, Vcl.StdCtrls, JvComponentBase, JvCSVBaseControls, Vcl.Grids, JvExGrids, JvStringGrid,
  System.RegularExpressions, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

const
  csv = 'd:\db\Dynacaisse\asepta 107.csv';

type
  tRow = tDictionary<String,String>;

  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    ListBox2: TListBox;
    sg1: TJvStringGrid;
    btnLoad: TButton;
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDCommand1: TFDCommand;
    Button3: TButton;
    FDQuery1: TFDQuery;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { D�clarations priv�es }
    dFields: tDictionary<string, integer>;
    function sanitize(sLine: String): String;
    function readline(var stream: tStream; var sLine: String): Boolean;
    function insertInTable(sList : tStrings) : integer;
    function isNumeric(sField : String) : boolean;
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile(csv);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  sList: tStrings;
  // sLine: String;
  iField: integer;
  iRow: integer;
  key: String;
begin
  sList := TStringList.Create;
  sList.Delimiter := ';';
  sList.StrictDelimiter := true;
  sList.DelimitedText := ListBox1.Items[0];
  dFields := tDictionary<string, integer>.Create;
  iField := 0;
  while iField <= sList.Count - 1 do
  begin
    dFields.Add(sList[iField], iField);
    inc(iField);
  end;

  sg1.Clear;
  sg1.ColCount := dFields.Count;
  //sg1.FixedCols := 1;
  //sg1.RowCount := 2;

  // Headers
  for key in dFields.Keys do
  begin
    if dFields.TryGetValue(key, iField) then
      sg1.Cells[iField, 0] := key;
  end;

  sg1.BeginUpdate;
  iRow := 1;
  while iRow <= ListBox1.Items.Count - 1 do
  begin
    if sg1.Cells[0, sg1.RowCount - 1] <> '' then
      sg1.RowCount := sg1.RowCount + 1;
    sList.Clear;
    sList.Delimiter := ';';
    sList.StrictDelimiter := true;
    sList.DelimitedText := sanitize(ListBox1.Items[iRow]);
    iField := 0;
    while iField <= sList.Count - 1 do
    begin
      sg1.Cells[iField, sg1.RowCount - 1] := sList[iField];
      inc(iField);
    end;

    inc(iRow);
  end;

  sg1.EndUpdate;

  /// listbox2.Items.Assign(sList);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    fdConnection1.Open;
    FDCommand1.Execute;
end;

function TForm1.insertInTable(sList: tStrings): integer;
var
   ccode,
   cnom,
   cnomjf,
   cprenom,
   cnoss,
   csexe : String;

   function getField(key : String) : String;
   var
     i : Integer;
   begin
      result := '';
      if dFields.TryGetValue(key, i) then
         if i <= sList.Count -1 then
            result := sList[i];


   end;
begin
  ccode := getField('ccode');
  cnom := getField('cnom');
  cnomjf := getField('cnomjf');
  cprenom := getField('cprenom');
  cnoss := getField('cnoss');
  csexe := getField('csexe');
  FDQuery1.ParamByName('ccode').asString := ccode;
  FDQuery1.ParamByName('cnom').asString := cnom;
  FDQuery1.ParamByName('cnomjf').asString := cnomjf;
  FDQuery1.ParamByName('cprenom').asString := cprenom;
  FDQuery1.ParamByName('cnoss').asString := cnoss;
  FDQuery1.ParamByName('csexe').asString := csexe;
  FDQuery1.ExecSQL;


end;

function TForm1.isNumeric(sField: String): boolean;
const
  rx = '^[0-9]+$';
var
  regexpr: tREgEx;
  RegExReplace: tREgEx;
  Match: tMatch;
begin
    regexpr := tREgEx.Create(rx, [roIgnoreCase]);
    Match := regexpr.Match(sField);
    result :=  Match.Success;

end;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  fCSV: tStream;
  buffer: String;
  iLine: integer;

  sList: tStrings;
  // sLine: String;
  iField: integer;
  iRow: integer;
  key: String;

begin

  sList := TStringList.Create;
  fCSV := TFileStream.Create(csv, fmOpenRead);
  iLine := 0;
  //sg1.BeginUpdate;
  while readline(fCSV, buffer) do
  begin
    if iLine = 0 then
    begin
{$REGION 'Process Headers'}
      // Ent�tes ....
      sList.Delimiter := ',';
      sList.StrictDelimiter := true;
      sList.CommaText := buffer;
      listbox2.Items.Assign(sList);
      dFields := tDictionary<string, integer>.Create;
      iField := 0;
      while iField <= sList.Count - 1 do
      begin
        dFields.Add(sList[iField], iField);
        inc(iField);
      end;

      sg1.Clear;
      sg1.ColCount := dFields.Count;
      sg1.FixedCols := 1;
      sg1.RowCount := 2;

      // Headers
      for key in dFields.Keys do
      begin
        if dFields.TryGetValue(key, iField) then
          sg1.Cells[iField, 0] := key;
      end;
{$ENDREGION}
    end
    else
    begin
{$REGION 'Process Rows'}
      // Rows
      if sg1.Cells[0, sg1.RowCount - 1] <> '' then
        sg1.RowCount := sg1.RowCount + 1;
      sList.Clear;
      sList.Delimiter := ',';
      sList.StrictDelimiter := true;
      sList.CommaText := sanitize(buffer);
      insertInTable(sList);
      iField := 0;
      while iField <= sList.Count - 1 do
      begin
        sg1.Cells[iField, sg1.RowCount - 1] := sList[iField];
        inc(iField);
      end;

{$ENDREGION}
    end;
    inc(iLine);
    if (iLine mod 50) = 0 then
       Application.ProcessMessages;
  end;
  //sg1.EndUpdate;

  fCSV.Free;

end;

function TForm1.readline(var stream: tStream; var sLine: String): Boolean;
var
  ligne: String;
  ch: ansiChar;
begin
  result := false;
  ch := #0;
  while (stream.read(ch, 1) = 1) and (ch <> #10) do
  begin
    result := true;
    ligne := ligne + ch;
  end;
  sLine := ligne;
  if ch = #10 then
  begin
    result := true;
    //if (stream.read(ch, 1) = 1) and (ch <> #10) then
    //  stream.Seek(-1, soCurrent)
  end;
end;

function TForm1.sanitize(sLine: String): String;
const
  rx = '(\d{4}-\d{2}-\d{2},\d{2}:\d{2}:\d{2}.\d{4,6})';
var
  regexpr: tREgEx;
  RegExReplace: tREgEx;
  Match: tMatch;
  aText: String;
begin
  regexpr := tREgEx.Create(rx, [roIgnoreCase]);
  Match := regexpr.Match(sLine);
  if Match.Success then
  begin
    aText := Match.Groups.Item[1].Value;
    RegExReplace.Create(aText);
    result := RegExReplace.Replace(sLine, '"' + aText + '"');
  end
  else
    result := sLine;

end;

end.
