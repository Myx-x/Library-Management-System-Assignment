//f05_pinjambuku
//Update : 08/04/2019 16.00 WIB
//Dev : Yoga
//v1.0.0

unit f05_pinjambuku;

interface

uses banana_csvparser, banana_dateutils, f02_login;

var
	user_data, user_data_2 : banana_csvdoc;
	ID_Buku, date, str_jumlah_buku,Back,s: string;
	Jumlah_Buku,y,rc,cc,rc_2,cc_2 : integer;
	
	
procedure pinjambuku;
{Memasukkan data pinjam buku}

implementation

procedure pinjambuku;
begin
	
	//Change CSV Form to array
    user_data := load_csv('buku_tmp.csv');
    
	//Get Row and Column    
    rc := row_count(user_data);
    cc := coll_count(user_data);
    
	//-----INPUT-----//
	write('Masukkan ID buku yang ingin dipinjam: ');
    readln(ID_Buku);
    write('Masukkan tanggal hari ini: ');
    readln(date);
    
    //Find ID
    for y:=1 to rc do
	begin
		if(user_data[y,1] = ID_Buku) then
		begin
			//Change  string to integer
			s:= user_data[y,4];
			val(s, Jumlah_Buku);
			break;
		end;
	end;
	
	//-----OUTPUT-----//
    if(Jumlah_Buku = 0) then
    begin
		writeln('Buku ', user_data[y,2], ' sedang habis!');
	end
	else
	begin
		Jumlah_Buku := Jumlah_Buku - 1;
		writeln('Buku ', user_data[y,2], ' berhasil dipinjam!');
		writeln('Tersisa ', Jumlah_Buku, ' buku ', user_data[y,2]);
		writeln('Terima kasih sudah meminjam.');
		//Change Integer to String
		str(Jumlah_Buku, str_Jumlah_buku);
		user_data[y,4] := str_Jumlah_Buku;
		//Change array to csv
		save_csv(user_data,'buku_tmp.csv' , rc, cc);
	end;
	
	//Change CSV form to array
	user_data_2 := load_csv('peminjaman_tmp.csv');
	
	rc_2 := row_count(user_data_2);
	cc_2 := coll_count(user_data_2);
	
	//Insert Data to Array
	if(jumlah_buku > 0) then
	begin
		user_data_2[rc_2+1, 1] := username;
		user_data_2[rc_2+1, 2] := ID_Buku;
		user_data_2[rc_2+1, 3] := date;
		user_data_2[rc_2+1, 4] := pengembalian(date);
		user_data_2[rc_2+1, 5] := 'belum';
	end;	
	//Change array form to array
	save_csv(user_data_2, 'peminjaman_tmp.csv', rc_2 + 1, cc_2);

	
end;

end.
