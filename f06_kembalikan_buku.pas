//f06_kembalikan_buku
//Update : 22/04/2019 16.00 WIB
//Dev : Jovan
//v1.0.0

unit f06_kembalikan_buku;

interface

uses banana_csvparser,banana_dateutils;

var
	y,rc,cc,rc_2,cc_2,rc_3,cc_3,i: integer;
	idbuku,judul,username,tanggalpeminjaman, tanggalbataspengembalian, tanggaltoday,s:string;
	databuku,historypeminjaman,historypengembalian: banana_csvdoc;
	d1,d2: penanggalan;
	
	
procedure kembalikanbuku(username:string);
{pengembalian buku}

implementation

procedure kembalikanbuku(username:string);
begin
	//-----    Input    -----
	write('Masukkan id buku yang dikembalikan :');
	readln(idbuku);
	
	//Change CSV form to array
	databuku := load_csv('buku_tmp.csv');
	historypeminjaman := load_csv('peminjaman_tmp.csv');
	historypengembalian:=load_csv('pengembalian_tmp.csv');
	
	//Find Judul Buku and plus one jumlah buku
	for y:=1 to row_count(databuku) do
	begin
		if(databuku[y,1] = idbuku) then
		begin 
			judul := databuku[y,2];
			s:= databuku[y,4];
			val(s, i);
			i:= i + 1;
			str(i,s);
			databuku[y,4]:=s;
		end;
	end;
	
	//Find tanggal peminjaman, tanggalbataspengembalian, and change 'belum' to 'sudah'
	for y:=1 to row_count(historypeminjaman) do
	begin
		if((historypeminjaman[y,2] = idbuku)and(historypeminjaman[y,1]=username)and (historypeminjaman[y,5]='belum')) then
		begin 
			tanggalpeminjaman  := historypeminjaman[y,3];
			tanggalbataspengembalian  := historypeminjaman[y,4];
			historypeminjaman[y,5]:='sudah';
			break;
		end;
	end;
	
	//------ Output -----
	writeln('Data Peminjaman:');
	writeln('Username: ',username);
	writeln('Judul buku: ',judul);
	writeln('Tanggal peminjaman: ',tanggalpeminjaman);
	writeln('Tanggal batas pengembalian: ',tanggalbataspengembalian);
	
	//------ Input ------
	writeln('Masukkan tanggal hari ini : ');
	readln(tanggaltoday);
	
	//----- Insert data -----
    
    //Get row and coll count
    rc:=row_count(historypengembalian);
    cc:=coll_count(historypengembalian);
    rc_2:=row_count(historypeminjaman);
	cc_2:=coll_count(historypeminjaman);
	rc_3:=row_count(databuku);
	cc_3:=coll_count(databuku);

    //Insert data to array
    historypengembalian[rc+1,1]:=username;
    historypengembalian[rc+1,2]:=idbuku;
    historypengembalian[rc+1,3]:=tanggaltoday;

	//Change array form to CSV
    save_csv(historypengembalian,'pengembalian_tmp.csv',rc+1,cc);
	save_csv(historypeminjaman, 'peminjaman_tmp.csv', rc_2,cc_2);
	save_csv(databuku, 'buku_tmp.csv', rc_3,cc_3);

	//Check if it's late or not
	d1.tahun := tahun(tanggalbataspengembalian);
	d1.bulan := bulan(tanggalbataspengembalian);
	d1.tanggal := tanggal(tanggalbataspengembalian);
 
	d2.tahun := tahun(tanggaltoday);
	d2.bulan := bulan(tanggaltoday);
	d2.tanggal := tanggal(tanggaltoday);
	
	if(selisih(d1,d2)<=0)then
	begin
		writeln('Terima kasih sudah meminjam.');
	end else
	begin
		writeln('Anda terlambat mengembalikan buku.');
		writeln('Denda= Rp.',selisih(d1,d2)*2000);
	end;		
end;
end.
