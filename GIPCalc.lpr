program GIPCalc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainForm, turbopoweripro, printer4lazarus, BannerForm, aboutform,
  licenseform;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormBanner, FormBanner);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormLicense, FormLicense);
  Application.Run;
end.

