//f10_tambah_jumlah_buku
//Dev : Sandra
//v1.0.0

unit f10_tambah_jumlah_buku; 

interface 

uses banana_csvparser; 

procedure tambah_jumlah_buku;
//prosedur untuk menambahkan jumlah buku dengan id tertentu
//input : id dan jumlah buku 
//output : jumlah buku bertambah dari sebelumnya   

type 
	buku_baru = record
		b_id : string;
		b_jumlah : integer; 
	end; 
		
var 
	data : banana_csvdoc; 
	k,baris,kol : integer; 
	i : integer;  
	buku : buku_baru; 
	helper : string;
	helper2 : string;   
	
implementation 

procedure tambah_jumlah_buku; 
begin 
	
	//load data 
	data := load_csv('buku_tmp.csv');
	baris := row_count(data); 
	kol := coll_count(data);
    
    //input 
    write('Masukkan ID buku : '); readln(buku.b_id); 
    write('Masukkan jumlah buku yang ditambahkan : '); readln(buku.b_jumlah); 
    
    //mencari data 
    k:=1;
    while (buku.b_id <> data[k,1]) do 
    begin 
		k := k+1; 
    end;
    
    //mengubah data 
    helper := data[k,4]; 
    val(helper,i); 
    i := i + buku.b_jumlah;
    str(i,helper2);  
    data[k,4] := helper2; 

    //save
	  save_csv(data,'buku_tmp.csv', baris,kol); 

    //success message
    writeln();
    writeln('Pembaharuan jumlah buku berhasil dilakukan, total buku ',data[k,2],' di perpustakaan menjadi ',data[k,4]); 

end;
end.   
    
