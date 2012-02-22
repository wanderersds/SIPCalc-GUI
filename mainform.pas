unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  CheckLst, StdCtrls, MaskEdit, ExtCtrls, ComCtrls, Menus, XMLPropStorage,
  AboutForm, LicenseForm, BannerForm;

type

  { TFormMain }

  TFormMain = class(TForm)
    ButtonCalc: TButton;
    FontDialog1: TFontDialog;
    GroupOptions: TCheckGroup;
    LabelAddr: TLabel;
    LabelMask: TLabel;
    EditAddr: TEdit;
    EditMask: TEdit;
    MainMenu: TMainMenu;
    MemoResult: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    sipcalc: TProcess;
    XMLPropStorage: TXMLPropStorage;
    procedure ButtonCalcClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private
  public
  end;

var
  FormMain: TFormMain;
  keys : Array[0..9] of char = ('a', 'b', 'c', 'd', 'e', 'i', 'r', 't', 'w', 'x');
  path : string;

procedure Calc();
function Valid(path : string) : Boolean;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.ButtonCalcClick(Sender: TObject);
begin
  Calc();
end;

procedure TFormMain.FormShow(Sender: TObject);
begin

  FormBanner.ShowModal;
  Calc();

end;

procedure TFormMain.MenuItem10Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
     Calc;
end;

function Valid(path : string) : Boolean;
begin
  Valid:=False;
  FormMain.sipcalc.CommandLine:= path + ' ' +  FormMain.EditAddr.Text + ' ' + FormMain.EditMask.text + '-' + keys;
  try
     FormMain.sipcalc.Execute;
  except //Ошибка продолжает выскакивать если тут будет finaly, городим except, хотя в обработке и не нуждаюсь
    on Excp : EProcess do //А еще она выскакивает, если здесь этого нет
       Exit;
  end;

  if FormMain.sipcalc.ExitStatus = 0 then
       Valid:=True;


end;

procedure TFormMain.MenuItem1Click(Sender: TObject);
begin
  if FontDialog1.Execute then
      MemoResult.Font:=FontDialog1.Font;

end;

procedure TFormMain.MenuItem2Click(Sender: TObject);
begin

end;

procedure TFormMain.MenuItem3Click(Sender: TObject);
begin
  FormLicense.Show;
end;

procedure TFormMain.MenuItem6Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.MenuItem7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     MemoResult.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFormMain.MenuItem8Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure Calc();
var i : integer;
    key : string = ' -';
begin
  while Valid(FormMain.OpenDialog1.FileName) = False do
  begin
       ShowMessageFmt('Утилита sipcalc по заданому пути не найдена, укажите правильный путь.',[1]);
         if FormMain.OpenDialog1.Execute = False then
         begin
             Application.Terminate; //Какого она не завершается нормально?
             Break; //Пришлось добавить, иначе при закрытии диалога выбора файла цикл начинвется сначала
         end;
  end;

  path:=FormMain.OpenDialog1.FileName;

  for i := 0 to 9 do
      if FormMain.GroupOptions.Checked[i] then
          key := key + keys[i];

  FormMain.sipcalc.CommandLine := path + ' ' +  FormMain.EditAddr.Text + ' ' + FormMain.EditMask.text + key;
  FormMain.sipcalc.Execute;
  FormMain.MemoResult.Lines.LoadFromStream(FormMain.sipcalc.Output);
end;

end.
