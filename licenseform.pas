unit LicenseForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormLicense }

  TFormLicense = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormLicense: TFormLicense;

implementation

{$R *.lfm}

{ TFormLicense }

procedure TFormLicense.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

