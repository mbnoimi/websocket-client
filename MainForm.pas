unit MainForm;

interface

uses
// Delphi-Cross-Socket
  Net.CrossSocket.Base,
  Net.CrossWebSocketClient,
  Net.CrossWebSocketParser,
  Utils.Utils,
//---------------------
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Edit;

type
  THomeForm = class(TForm)
    Button_Connect: TButton;
    ListBox_Log: TListBox;
    Edit_IP: TEdit;
    Panel1: TPanel;
    ClearEditButton1: TClearEditButton;
    procedure RunWebSocketClient;
    procedure Button_ConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HomeForm: THomeForm;
  __WebSocket: ICrossWebSocket;
  ip: String;

implementation

{$R *.fmx}

procedure THomeForm.RunWebSocketClient;
begin
  __WebSocket := TCrossWebSocket.Create(ip);

  __WebSocket.OnOpen(procedure
    begin
      ListBox_Log.Items.Add('WebSocket Opened');
    end);

  __WebSocket.OnClose(
    procedure
    begin
      ListBox_Log.Items.Add('WebSocket Closed');
    end);

  __WebSocket.OnPing(
    procedure
    begin
      ListBox_Log.Items.Add('WebSocket Ping');
    end);

  __WebSocket.OnPong(
    procedure
    begin
      ListBox_Log.Items.Add('WebSocket Pong');
    end);

  __WebSocket.OnMessage(
    procedure(const AMessageType: TWsMessageType; const AMessageData: TBytes)
    var
      LMessage: string;
    begin
      case AMessageType of
        wtText:
          LMessage := TUtils.GetString(AMessageData);
      else
        LMessage := TUtils.BytesToHex(AMessageData);
      end;

      ListBox_Log.Items.Add('Message: ' + LMessage);
    end);

  __WebSocket.Open;
end;

procedure THomeForm.Button_ConnectClick(Sender: TObject);
begin
  ip := Edit_IP.Text;
  RunWebSocketClient;
end;

end.
