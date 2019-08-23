{Unit f11_riwayat}
{Update: 9 April 2019, 14.55 WIB}
{oleh: Indrayana}

unit f11_riwayat;

interface

uses banana_csvparser;

	
procedure riwayat;
{Procedure Riwayat}
{Menampilkan riwayat peminjaman pengguna berupa kode buku, judul buku, dan tanggal pengembalian}

implementation
	
procedure riwayat;	

var
	datakembali: banana_csvdoc;
	databuku: banana_csvdoc;
	i : integer;
	j: integer;
	username : string;
	judul : string;
	
begin
	{LOADING DATA}
	datakembali := load_csv('pengembalian_tmp.csv');
	databuku := load_csv('buku_tmp.csv');
	
	{MEMINTA INPUT USERNAME}
	write('Masukkan username pengunjung: ');
	readln(username);
	
	{ANALISIS DATA DAN MENULISKAN DATA KE LAYAR}
	for i :=0 to row_count(datakembali) do begin
		for j:=0 to row_count(databuku) do begin
			if (username = datakembali[i, 1]) then begin
				if (datakembali[i, 2] = databuku[j, 1]) then begin
					judul := databuku[j,2];
					write(datakembali[i, 3], ' | ', datakembali[i, 2], ' | ', judul);
					writeln();
				end;
			end;
		end;
	end;
end;
end.
	
