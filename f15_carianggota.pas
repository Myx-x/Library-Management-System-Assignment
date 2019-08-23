{Unit f15_carianggota}
{Update: 9 April 2019, 15.10 WIB}
{oleh: Indrayana}


unit f15_carianggota;

interface

uses banana_csvparser;

procedure carianggota;
{Procedure carianggota}
{Mengecek apakah username termasuk anggota perpustakaan, lalu menampilkan data user tersebut berupa nama dan alamat}

implementation

procedure carianggota;

var
datauser: banana_csvdoc;
username: string;
i : integer;
found : boolean;

begin
	{LOADING DATA}
	datauser:= load_csv('user_tmp.csv');
	
	{MEMINTA INPUT USERNAME}
	write('Masukkan username: ');
	readln(username);
	
	{INISIALISASI VARIABEL}
	found:=false;
	
	{ANALISIS DATA DAN MENAMPILKAN DATA USERNAME}
	for i:=1 to row_count(datauser) do begin
		if (username = datauser[i,3]) then begin
			writeln('Nama Anggota: ', datauser[i, 1]);
			writeln('Alamat anggota: ', datauser[i, 2]);
			found := true;
		end;
	end;
	if (found = false) then begin
		writeln('Maaf, anggota dengan username tersebut tidak ditemukan.');
	end;
end;
end.
