unit BannerForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TFormBanner }

  TFormBanner = class(TForm)
    ImageBanner: TImage;
    LabelLoading: TLabel;
    TimerBanner: TTimer;
    procedure ImageBannerClick(Sender: TObject);
    procedure TimerBannerTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormBanner: TFormBanner;

implementation

{$R *.lfm}

{ TFormBanner }

procedure TFormBanner.TimerBannerTimer(Sender: TObject);
begin
  TimerBanner.Enabled:= False;
  FormBanner.close;
end;

procedure TFormBanner.ImageBannerClick(Sender: TObject);
begin
  TimerBanner.Enabled:= False;
  FormBanner.close;
end;


end.

