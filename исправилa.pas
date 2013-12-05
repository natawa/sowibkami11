unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Unit2,Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, TADbSource, TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }

//Отрезок а и б ( 4,0;5.0 )  деление отрезка пополам

    function my_graph(x:real):real;
    begin
    Result := x+exp(ln(x)*(1/3))-6.09;
    end;


{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
  var code:integer;
  h:word;
begin
  h:=MessageDlg('Ви насправді хочете все видалити?',mtConfirmation,[mbYes,mbNo],0);
  if h=mrYes then begin
    Edit1.text:='';
    edit2.text:='';
    Edit3.Text:='';
    Memo1.lines.clear;
    Chart1lineseries1.Clear;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, h,y, x, p,i: real; // a- нач коор b- кон координ. h - шаг
  t, code: byte;
  s1, s2: string;
begin
    memo1.Clear;
    val(Edit1.Text, a, code);
    if code <> 0 then
      t := Application.MessageBox('Помилка! , початок графіку. ', '', 0)
    else
    begin
      val(Edit2.Text, b, code);
      if code <> 0 then
        t := Application.MessageBox('Помилка! , кінець графіку. ', '', 0)
      else
      begin
        val(Edit3.Text, h, code);
        if code <> 0 then
          t := Application.MessageBox('Помилка кроку', '', 0)
       else
        begin
          if a > b then
           ShowMessage('Помилка!!!  а > b!!!');
           begin
          Code := 0;
          repeat
            Code := Code + 1;
            x := (a + b) / 2;
            if my_graph(a) * my_graph(x) < 0 then
              b := x
            else
              a := x;
            if (Code > 100) then
            begin
              memo1.Lines.add('Неможливо розв''язати');
              exit;
            end;
          until abs(my_graph(x)) < h;
          val(edit1.Text, a, code); ///121
          val(edit2.Text, b, code);
          i := a;
          Chart1LineSeries1.Clear;
          while (i < b) do
          begin
            Chart1LineSeries1.AddXY(i, my_graph(i));
            i := i + 0.01;
          end;
          Str(x: 3: 3, s1);
          Str(my_graph(x): 4: 4, s2);
          memo1.Lines.add('Корінь = ' + s1);     //132 с3
          memo1.Lines.add('  F(x)=  ' + s2);
        end;
      end;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   code:integer;
   h:word;
   begin
   h:=MessageDlg('Ви насправді хочете закінчити роботу програми?',mtConfirmation,[mbYes,mbNo],0);
   if h=mrYes then close;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if savedialog1.Execute then
    memo1.Lines.SaveToFile(savedialog1.FileName);
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;





end.

