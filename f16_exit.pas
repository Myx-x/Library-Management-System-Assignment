unit f16_exit; 

interface
uses f14_save; 

procedure keluar; 
//prosedur di mana pengguna memasukkan Y/N 
//jika Y yang dimasukkan, maka file akan disave, temporary file didelete, 
//dan pengguna keluar dari program 

var 
	temp : text; 
	ans : string; 

procedure delete_file(filename : string); 
//prosedur untuk men-delete temporary file dari disk 
//parameter berupa nama file yang akan dihapus
	
implementation

Procedure delete_file (filename : string); 
begin 
	assign(temp,filename); 
	erase(temp); 
end; 

procedure keluar;
begin 
	//input user 
	write('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ? '); 
	readln(ans); 
	
	//input yang diberikan user, disimpan atau tidak 
	if (ans = 'Y') or (ans ='y') then 
	begin 
		save; 
		delete_file('buku_tmp.csv'); delete_file('user_tmp.csv'); 
		delete_file('peminjaman_tmp.csv'); delete_file('pengembalian_tmp.csv');
		delete_file('kehilangan_tmp.csv'); 
		exit; 
	end else 
	begin 
		delete_file('buku_tmp.csv'); delete_file('user_tmp.csv'); 
		delete_file('peminjaman_tmp.csv'); delete_file('pengembalian_tmp.csv');
		delete_file('kehilangan_tmp.csv'); 
		exit; 
	end;
end;  
end.
