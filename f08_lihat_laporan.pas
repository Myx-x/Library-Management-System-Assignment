//f08_lihat_laporan
//Update : 09/04/2019 16.30 WIB
//Dev : Jovan
//v1.0.0

unit f08_lihat_laporan;

interface

uses banana_csvparser;

procedure lihatlaporan;
{melihat laporan kehilangan}
{hanya untuk admin}
implementation

procedure lihatlaporan;

var
	databuku, datalaporan : banana_csvdoc;
	y,i,count : integer;
	data : array [0..2, 0..99] of string;

begin
	//-----    Input    -----
	writeln('Buku yang hilang :');
	
	//Change CSV form to array
	databuku := load_csv('buku_tmp.csv');
	datalaporan := load_csv('kehilangan_tmp.csv');
	
	//Sort CSV data based on the ID
	sort_data(databuku,row_count(databuku),6,2);
	
	//Find id buku hilang and tanggal laporan
	count:= -1;
	for y:=1 to row_count(datalaporan) do
	begin
		count:=count+1;
		for i := 1 to 2 do
			begin 
				data[i,count] := datalaporan[y,i+1];
			end;
		end;
	
	//Find Judul buku
	for y:=0 to count do
	begin
		for i:=1 to row_count(databuku) do
		begin
			if(data[1,y] = databuku[i,1]) then
			begin
				data[0,y] := databuku[i,2];
			end;
		end;
	end;
	
	//-----OUTPUT-----//
	for y:= 0 to count do
	begin
		writeln(data[1,y], ' | ', data[0,y], ' | ', data[2,y]);
	end;
	
end;
end.
