//f04_caritahunterbit
//Update : 08/04/2019 16.00 WIB
//Dev : Yoga
//v1.0.0

unit f04_caritahunterbit;

interface

uses banana_csvparser;

procedure caritahun;
{cari berdasarkan tahun}

function compare(x, y: string; param: string): boolean;
{cari parameter}

implementation

function compare(x, y: string; param:string):boolean;
begin
    if(param='>') then
        compare:=x>y
    else if(param='<') then
        compare:=x<y
    else if(param='>=') then
        compare:=x>=y
    else if(param='<=') then
        compare:=x<=y
    else if(param='=') then
        compare:=x=y;
    
end;

procedure caritahun;

var
	user_data : banana_csvdoc;
	y, count : integer;
	kategori, tahun : string;
	
begin
	//Change CSV Form to array
	user_data := load_csv('buku_tmp.csv');
	
	//Sort the data based on the title
	sort_data(user_data,row_count(user_data),6,2);
	
	//-----INPUT-----//
	write('Masukkan tahun: ');
	readln(tahun);
	write('Masukkan kategori: ');
	readln(kategori);
	
	writeln();
	count := 0;
	//Find Year based on input
	writeln('Buku yang terbit ', kategori, ' ', tahun, ':');
	for y:= 1 to row_count(user_data) do
	begin
		if (compare(user_data[y, 5], tahun, kategori) = True) then
		begin
			count := 1;
			writeln(user_data[y,1], ' | ', user_data[y,2], ' | ', user_data[y,3]);
		end;
	end;
	
	if(count = 0) then
	begin
		writeln('Tidak ada buku dalam kategori ini');
	end;
end;

end.
