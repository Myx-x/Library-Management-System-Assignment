//f09_tambah_buku
//Dev : Sandra
//v1.0.0

unit f09_tambah_buku;

interface 

uses banana_csvparser;

procedure tambah_buku;
//prosedur untuk menambah buku baru ke dalam list 
//input berupa data buku dari user 
//output berupa data baru 

type 
	buku_baru = record
		b_id : string;
		b_judul : string; 
		b_author : string; 
		b_jumlah : string; 
		b_tahun : string; 
		b_kategori : string; 
	end;
	
var 
	t : text; 
	c : char; 
	n,baris,kol : integer; 
	buku : buku_baru;
	tabel : banana_csvdoc;
	
implementation 

procedure tambah_buku;
begin 
	//input user 
	writeln ('Masukkan informasi buku yang ditambahkan:'); 
	write('Masukkan ID buku : ');readln(buku.b_id); 
	write('Masukkan judul buku : '); readln(buku.b_judul); 
	write('Masukkan pengarang buku : '); readln(buku.b_author); 
	write('Masukkan jumlah buku : '); readln(buku.b_jumlah); 
	write('Masukkan tahun terbit buku : '); readln(buku.b_tahun); 
	write('Masukkan kategori buku : '); readln(buku.b_kategori); 
	
	//load data 
	tabel := load_csv('buku_tmp.csv'); 
	baris := row_count(tabel);
	kol := coll_count(tabel); 
	
	//memasukkan ke array data yang baru diinput 
	tabel[baris+1,1] := buku.b_id; 
	tabel[baris+1,2] := buku.b_judul; 
	tabel[baris+1,3] := buku.b_author; 
	tabel[baris+1,4] := buku.b_jumlah; 
	tabel[baris+1,5] := buku.b_tahun; 
	tabel[baris+1,6] := buku.b_kategori; 

	//save
	save_csv(tabel,'buku_tmp.csv',baris+1,kol); 
	
	//Success message
	writeln();
	writeln('Buku berhasil ditambahkan ke dalam sistem!'); 

	end;
end.
	
