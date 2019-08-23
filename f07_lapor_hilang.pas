//f07_lapor_hilang
//Update : 09/04/2019 16.30 WIB
//Dev : Jovan
//v1.0.0

unit f07_lapor_hilang;

interface

uses banana_csvparser;

var
	username:string;

procedure laporhilang(username:string);
{Lapor kehilangan}

implementation

procedure laporhilang(username:string);

var
	id_buku_hilang,tanggal_laporan :string;
	user_data : banana_csvdoc;
	rc,cc : integer;
begin
	//----- Prompt input -----
	write('Masukkan id buku: ');
    readln(id_buku_hilang);
    write('Masukkan judul buku: ');
    readln();
    write('Masukkan tanggal pelaporan: ');
    readln(tanggal_laporan);
   
    //----- Insert data -----

    //Change CSV form to array
    user_data:=load_csv('kehilangan_tmp.csv');
    
    //Get row and coll count
    rc:=row_count(user_data);
    cc:=coll_count(user_data);
    
     //Insert data to array
    user_data[rc+1,1]:= username;//pengunjung yang sedang login
    user_data[rc+1,2]:= id_buku_hilang;
    user_data[rc+1,3]:= tanggal_laporan;
  

	//Change array form to CSV
    save_csv(user_data,'kehilangan_tmp.csv',rc+1,cc);
    
    //Success message
    writeln();
    writeln('Laporan berhasil diterima.');
end;

end.
	
