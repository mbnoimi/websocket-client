program WebsocketClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainForm in 'MainForm.pas' {HomeForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THomeForm, HomeForm);
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.Run;
end.
