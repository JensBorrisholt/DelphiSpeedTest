program BinomialTest;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.Sysutils, System.Diagnostics, System.Threading;

function Binomial(n, k: Integer): Integer;
var
  Denominator: Integer;
begin
  if k > n then
    Exit(0);

  if k = 0 then
    Exit(1);

  if k > n - k then
    k := n - k;

  Result := 1;
  Denominator := 0;

  while Denominator < k do
  begin
    Result := Result * (n - Denominator);
    Inc(Denominator);
    Result := Result div Denominator;
  end;
end;

var
  Stopwatch: TStopwatch;
  i, j: Integer;

Const
  Count = 2000;

begin
  Stopwatch := TStopwatch.StartNew;

  for i := 1 to Count do
    for j := 1 to Count do
      Binomial(i, j);
  Stopwatch.Stop;

  Writeln('Binomial single thread: ' + FormatFloat('Elapsed time: 0.00 seconds', Stopwatch.Elapsed.TotalSeconds));

  Stopwatch := TStopwatch.StartNew;

  TParallel.&For(2, 1, Count,
    procedure(i: Int64)
    var
      j: Integer;
    begin
      for j := 1 to Count do
        Binomial(i, j);
    end);

  Stopwatch.Stop;
  Writeln('Binomial TParallel.&For: ' + FormatFloat('Elapsed time: 0.00 seconds', Stopwatch.Elapsed.TotalSeconds));
  readln;

end.
