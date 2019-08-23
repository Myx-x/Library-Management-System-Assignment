{Unit f12_statistik}
{Update: 9 April 2019, 14.30 WIB}
{oleh: Indrayana}

unit f12_statistik;

interface

uses banana_csvparser;

var
	datauser: banana_csvdoc;
	databuku: banana_csvdoc;
	i, j: integer;
	admin: integer;
	visitor: integer;
	sastra: integer;
	sains: integer;
	manga: integer;
	sejarah: integer;
	programming: integer;
	
procedure statistik;
{Procedure statistik}
{Menampilkan jumlah admin, pengguna, serta kategori buku yang tersimpan}

implementation

procedure statistik;


begin

    {INISIALISASI VARIABEL}
	admin := 0;
	visitor:= 0;
	sastra:=0;
	sains:=0;
	manga:=0;
	sejarah:=0;
	programming:=0;
	
	{LOADING DATA}
	datauser:= load_csv('user_tmp.csv');
	databuku:=load_csv('buku_tmp.csv');
	
	{MENGHITUNG JUMLAH ADMIN DAN PENGUNJUNG}
	for i:= 1 to row_count(datauser) do begin
		if (datauser[i, 5] = 'admin') then begin
			admin := admin+1;
		end else begin
			visitor := visitor+1;
		end;
	end;
	
	{MENGHITUNG JUMLAH BUKU PER KATEGORI}
	for i:= 1 to row_count(databuku) do begin
		if (databuku[i, 6] = 'sastra') then begin
			sastra := sastra+1;
		end else if (databuku[i, 6] = 'sains') then begin
			sains := sains + 1;
		end else if (databuku[i, 6] = 'manga') then begin
			manga := manga+1;
		end else if (databuku[i, 6] = 'sejarah') then begin
			sejarah := sejarah + 1;
		end else begin
			programming := programming + 1;
		end;
	end;
	
	{MENULIS DATA KE LAYAR}
	writeln('Pengguna: ');
	writeln('Admin | ', admin);
	writeln('Pengunjung |  ', visitor);
	writeln('Total | ', admin+visitor);
	writeln('Buku: ');
	writeln('sastra | ', sastra);
	writeln('sains | ', sains);
	writeln('manga | ', manga);
	writeln('sejarah | ', sejarah);
	writeln('programming | ', programming);
	writeln('Total | ', sastra + sains + manga + sejarah + programming);
	
end;
end.
