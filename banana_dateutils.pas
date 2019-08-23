//banana_csvparser unit
//Update : 09/04/2019 10.30 WIB
//v1.4.1

unit banana_dateutils;

(*
 _
//\
V  \
 \  \_
  \,'.`-.
   |\ `. `.       
   ( \  `. `-.                        _,.-:\
    \ \   `.  `-._             __..--' ,-';/
     \ `.   `-.   `-..___..---'   _.--' ,'/
      `. `.    `-._        __..--'    ,' /
        `. `-_     ``--..''       _.-' ,'
          `-_ `-.___        __,--'   ,'
             `-.__  `----"""    __.-'
                  `--..____..--'
______  ___   _   _   ___   _   _   ___  
| ___ \/ _ \ | \ | | / _ \ | \ | | / _ \ 
| |_/ / /_\ \|  \| |/ /_\ \|  \| |/ /_\ \
| ___ \  _  || . ` ||  _  || . ` ||  _  |
| |_/ / | | || |\  || | | || |\  || | | |
\____/\_| |_/\_| \_/\_| |_/\_| \_/\_| |_/

DISCLAIMER : 
Buat tubes Daspro STEI 2018, hak milik kelompok 7 kelas 7. :)
                                         
*)

//-------------------------------------------------------

interface

type
	penanggalan = record
		tanggal : integer;
		bulan : integer;
		tahun : integer;
	end;
	

function tanggal(s:string): integer;
{Output tanggal dari penanggalan}

function bulan(s:string): integer;
{Output bulan dari penanggalan}

function tahun(s:string): integer;
{Output tahun dari penanggalan}

function isKabisat(d : integer): boolean;
{Outpun tahun kabisat atau tidak}

function hari_bulan(d,y: integer): integer;
{mencari jumlah hari di bulan tertentu}

function selisih(d1, d2 : penanggalan): integer;
{mencari selisih hari}

function pengembalian(d: string): string;
{Output pengembalian buku}

//--------------------------------------------------------

implementation

function tanggal(s:string): integer;
{Output tanggal dari penanggalan type integer}

var
	l, i: integer;
	helper : string;
begin
	l := length(s);
	i := 1;
	helper := '';
	
	//Find '/'
	while((ord(s[i]) <> 47) and (i <= l)) do
	begin
		helper := helper + s[i];
		i := i + 1;
	end;
	
	//OUTPUT//
	val(helper, tanggal);
end;

function bulan(s:string): integer;
{Output bulan dari penanggalan type integer}
var
	l, i: integer;
	helper : string;
begin
	l := length(s);
	i := 4;
	helper := '';
	
	//Find '/'
	while((ord(s[i]) <> 47) and (i >= 4) and (i <= l)) do
	begin
		helper := helper + s[i];
		i := i + 1;
	end;
	
	//OUTPUT//
	val(helper, bulan);
end;

function tahun(s:string): integer;
var
	l, i: integer;
	helper : string;
begin
	l := length(s);
	i := 7;
	helper := '';
	
	//Find '/'
	while((ord(s[i]) <> 47) and (i >= 7) and (i <= l)) do
	begin
		helper := helper + s[i];
		i := i + 1;
	end;
	//OUTPUT//
	val(helper, tahun);
end;

function isKabisat(d:integer): boolean;
{Menentukan tahun kabisat}

begin
	if(d mod 4 = 0) then
	begin
		if(d mod 100 = 0) then
		begin
			if(d mod 400 = 0) then
			begin
				isKabisat := True;
			end
			else
			begin
				isKabisat := False;
			end;
		end
		else {d mod 100 <> 0)}
		begin
			isKabisat := True;
		end;
	end
	else {d mod 4 <> 0}
	begin
		isKabisat := False;
	end;
end;

function hari_bulan(d,y: integer): integer;
{mencari jumlah hari di bulan tertentu}

begin
	{bulan dengan hari 31}
	if((d = 1) or (d = 3) or (d = 5) or (d = 7) or (d = 8) or (d = 10) or (d = 12)) then
	begin
		hari_bulan := 31;
	end
	{bulan dengan hari 29}
	else if((d = 2) and (isKabisat(y) = true))then
	begin
		hari_bulan := 29;
	end
	{bulan dengan hari 28}
	else if((d = 2) and (isKabisat(y) = false)) then
	begin
		hari_bulan := 28;
	end
	{bulan dengan hari 30}
	else
	begin
		hari_bulan := 30;
	end;
end;

function selisih(d1,d2: penanggalan): integer;
{Fungsi untuk mencari selisih antara 2 tanggal}
{Asumsi d2 > d1}

var
	i, selisih_tahun, selisih_bulan, selisih_tanggal : integer;
begin
	selisih_tahun := 0;
	selisih_bulan := 0;
	
	{selisih tahun}
	if(d2.tahun >= d1.tahun) then
	begin
		for i := d1.tahun to d2.tahun-1 do
		begin
			if(isKabisat(i) = true) then
			begin
				selisih_tahun := selisih_tahun + 366;
			end
			else
			begin
				selisih_tahun := selisih_tahun + 365;
			end;
		end;
	end
	else
	begin
		for i := d2.tahun to d1.tahun-1 do
		begin
			if(isKabisat(i) = true) then
			begin
				selisih_tahun := selisih_tahun - 366;
			end
			else
			begin
				selisih_tahun := selisih_tahun - 365;
			end;
		end;
	end;
	
	{selisih bulan}
	if(d2.bulan >= d1.bulan) then
	begin
		for i := d1.bulan + 1 to d2.bulan do
		begin
			selisih_bulan := selisih_bulan + hari_bulan(i,d2.tahun);
		end;
	end
	else
	begin
		for i := d2.bulan + 1 to d1.bulan do 
		begin
			selisih_bulan := selisih_bulan - hari_bulan(i,d1.tahun);
		end;
	end;
	
	{selisih hari}
	selisih_tanggal := hari_bulan(d1.bulan,d1.tahun) - d1.tanggal - (hari_bulan(d2.bulan, d2.tahun) - d2.tanggal);
	
	{hasil selisih 2 penanggalan}
	selisih := selisih_tahun + selisih_bulan + selisih_tanggal;
end;
				
function pengembalian(d: string): string;
{Output tanggal pengembalian}

var
	tanggal_balik, bulan_balik, tahun_balik : integer;
	str_tanggal_balik, str_bulan_balik, str_tahun_balik : string;
	
begin
	tanggal_balik := tanggal(d) + 7;
	bulan_balik := bulan(d);
	tahun_balik := tahun(d);
	
	{mengubah bentuk tanggal jika jumlah hari di atas banyaknya hari pada bulan}
	if(tanggal_balik > hari_bulan(bulan(d),tahun(d))) then
	begin
		tanggal_balik := tanggal_balik - (hari_bulan(bulan(d),tahun(d)));
		bulan_balik := bulan_balik + 1;
	end;
	
	{jika jumlah bulan di atas 12}
	if(bulan_balik > 12) then
	begin
		bulan_balik := bulan_balik - 12;
		tahun_balik := tahun_balik + 1;
	end;
		
	//Merubah ke bentuk string
	str(tahun_balik, str_tahun_balik);
	str(bulan_balik, str_bulan_balik);
	str(tanggal_balik, str_tanggal_balik);
		
	//Value dalam bentuk tanggal
	if (tanggal_balik < 10) then
	begin
		if(bulan_balik < 10) then
		begin
			pengembalian := ('0' + str_tanggal_balik + '/0' + str_bulan_balik + '/' + str_tahun_balik);
		end
		else
		begin
			pengembalian := ('0' + str_tanggal_balik + '/' + str_bulan_balik + '/' + str_tahun_balik);
		end
	end
	else
	begin
		if(bulan_balik < 10) then
		begin
			pengembalian := (str_tanggal_balik + '/0' + str_bulan_balik + '/' + str_tahun_balik);
		end
		else
		begin
			pengembalian := (str_tanggal_balik + '/' + str_bulan_balik + '/' + str_tahun_balik);
		end;
	end;
end;

end.
