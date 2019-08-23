//f03_cari unit
//Update : 08/04/2019 16.00 WIB
// Dev : Yoga
// v1.0.0

unit f03_cari;

interface

uses banana_csvparser;
	
procedure cari;
{cari berdasarkan kategori}

implementation

procedure cari;

var
	user_data : banana_csvdoc;
	y,i,count : integer;
	data : array [0..2, 0..100] of string;
	dicari : string;
begin
	//----- INPUT -----//
	write('Masukkan kategori: ');
	readln(dicari);
	while((dicari <> 'sastra') and (dicari <> 'sains') and (dicari <> 'manga') and (dicari <> 'sejarah') and (dicari <> 'programming')) do
	begin
		writeln('Kategori ', dicari, ' tidak valid.');
		write('Masukkan kategori: ');
		readln(dicari);
	end;
	
	//Change CSV form to array
	user_data := load_csv('buku_tmp.csv');
	
	//Sort CSV data based on the title
	sort_data(user_data,row_count(user_data),6,2);
	
	//Find category
	count := -1;
	for y:=1 to row_count(user_data) do
	begin
		if(user_data[y,6] = dicari) then
		begin
			count := count + 1;
			for i := 0 to 2 do
			begin 
				data[i,count] := user_data[y,i+1];
			end;
		end;
	end;
	
	//-----OUTPUT-----//
	writeln();
	writeln('Hasil Pencarian: ');
	for y:= 0 to count do
	begin
		writeln(data[0,y], ' | ', data[1,y], ' | ', data[2,y]);
	end;

	if(count=-1) then writeln('Tidak ada buku dalam kategori ini.');
end;	

end.

