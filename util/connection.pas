unit connection;

interface
uses FireDAC.Stan.Intf, FireDAC.Stan.Option,  FireDAC.Stan.Error, FireDAC.UI.Intf,
     FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
     FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.SysUtils,
     FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.MySQL, FireDAC.Phys.MSSQL,
     FireDAC.Phys.IBBase, System.IniFiles, System.IOUtils;

type
  TConnection = class
    private
      FConexao: TFDConnection;
      FTransacao: TFDTransaction;
      procedure LerConfiguracaoINI;

    public
      FDPhysFBDriverLink: TFDPhysFBDriverLink;
      constructor Create;
      destructor Destroy; override;
      function GetConexao: TFDConnection;
      function CriarQuery: TFDQuery;
      function CriarDataSource: TDataSource;
      function CriarTransaction: TFDTransaction;
      function TestarConexao: Boolean;
      procedure InciarTransacao;

  end;

implementation

uses Vcl.Dialogs;

{ TConnection }

constructor TConnection.Create;
var FDPhysMSSQL: TFDPhysMSSQLDriverLink;
    FDPhysMySQL: TFDPhysMySQLDriverLink;
    Banco: string;
    Ini: TIniFile;
    IniFileName: string;
begin
  inherited Create;
  // Caminho do arquivo INI
  IniFileName := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'pharma.ini');

  // Carregar o arquivo INI
  Ini := TIniFile.Create(IniFileName);
  try
    // Ler o tipo de banco de dados configurado
    Banco := Ini.ReadString('DatabaseConfig', 'Banco', 'FIREBIRD');

    if Banco = 'MSSQL' then
    begin
      // Configura��o para MSSQL
      FDPhysMSSQL := TFDPhysMSSQLDriverLink.Create(nil);

      FConexao := TFDConnection.Create(nil);
      FConexao.Params.DriverID := 'MSSQL';
      FConexao.Params.Database := Ini.ReadString('Database', 'Database', 'bdtestewk');
      FConexao.Params.UserName := Ini.ReadString('Database', 'UserName', 'sa');
      FConexao.Params.Password := Ini.ReadString('Database', 'Password', 'info');
      FConexao.Params.Add('Server=' + Ini.ReadString('Database', 'Server', 'PC-ALVARO\SQLEXPRESS'));
      FConexao.Params.Add('Port=' + Ini.ReadString('Database', 'Port', '1433'));
      FConexao.LoginPrompt := False;
    end
    else if Banco = 'FIREBIRD' then
    begin
      // Configura��o para Firebird
      //FDPhysFBDriverLink.Create(nil);
      //FDPhysFBDriverLink.VendorLib := 'c:\windows\system32\fbclient.dll'; // Caminho para a biblioteca do Firebird

      FConexao := TFDConnection.Create(nil);
      FConexao.Params.DriverID := 'FB'; // Driver do Firebird no FireDAC
      FConexao.Params.Database := Ini.ReadString('Database', 'Database', 'D:\banco firebird\PharmaPele\bdpharma.fdb'); // Caminho para o arquivo do banco de dados
      FConexao.Params.UserName := Ini.ReadString('Database', 'UserName', 'SYSDBA');
      FConexao.Params.Password := Ini.ReadString('Database', 'Password', 'masterkey');
      FConexao.Params.Add('Server=' + Ini.ReadString('Database', 'Server', 'localhost'));
      FConexao.Params.Add('Port=' + Ini.ReadString('Database', 'Port', '3050'));
      FConexao.Params.Add('CharacterSet=WIN1252');
      FConexao.LoginPrompt := False;
    end
    else
      raise Exception.Create('Banco de dados n�o configurado corretamente no arquivo INI.');

    // Cria��o da transa��o
    FTransacao := TFDTransaction.Create(nil);
    FTransacao.Connection := FConexao;
    FConexao.Transaction := FTransacao;

    TestarConexao;
  finally
    Ini.Free;
  end;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;

end;

function TConnection.GetConexao: TFDConnection;
begin
  Result := FConexao;
end;

function TConnection.CriarQuery: TFDQuery;
var Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConexao;
  Query.Transaction := FTransacao;
  Result := Query;
end;

function TConnection.CriarDataSource: TDataSource;
var DataSource: TDataSource;
begin
  DataSource := TDataSource.Create(nil);
  Result := DataSource;
end;

function TConnection.CriarTransaction: TFDTransaction;
begin
  Result := FTransacao;
end;

function TConnection.TestarConexao: Boolean;
begin
  Result := False;
  try
    FConexao.Connected := True;
    Result := FConexao.Connected;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao conectar: ' + E.Message);
    end;
  end;
end;

procedure TConnection.InciarTransacao;
begin
  // Verifica se a transa��o j� foi iniciada
  if not FTransacao.Active then
  begin
    FTransacao.Connection := FConexao;
    FTransacao.StartTransaction;
  end;
end;

procedure TConnection.LerConfiguracaoINI;
var Ini: TIniFile;
    IniFileName: string;
begin
  // Caminho do arquivo INI
  IniFileName := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'testewk.ini');

  // Verifica se o arquivo INI existe
  if not FileExists(IniFileName) then
    raise Exception.Create('Arquivo testewk.ini n�o encontrado!');

   // Carregar o arquivo INI
  Ini := TIniFile.Create(IniFileName);
  try
    FConexao.Params.Values['Banco'] := Ini.ReadString('DatabaseConfig', 'Banco', 'MySQL');
    FConexao.Params.DriverID := Ini.ReadString('Database', 'DriverID', '');
    FConexao.Params.Database := Ini.ReadString('Database', 'Database', '');
    FConexao.Params.UserName := Ini.ReadString('Database', 'UserName', '');
    FConexao.Params.Password := Ini.ReadString('Database', 'Password', '');
    FConexao.Params.Add('Server=' + Ini.ReadString('Database', 'Server', ''));
    FConexao.Params.Add('Port=' + Ini.ReadString('Database', 'Port', '3307')); // Porta padr�o
    FConexao.LoginPrompt := False;
  finally
    Ini.Free;
  end;

end;


end.
