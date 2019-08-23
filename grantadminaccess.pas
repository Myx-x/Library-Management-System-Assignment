//grantadminaccess unit
//Update : 08/04/2019 10.30 WIB
//Dev : mk
//v1.0.0


unit grantadminaccess;

interface
uses banana_csvparser;
var
    user_data:banana_csvdoc;

function grantaccess(row:integer):boolean;
//Mengembalikan nilai true bila username merupakan admin, dan sebaliknya

procedure accessdenied();
//Mengeluarkan pesan error bila pengunjung hendak mengakses function admin

function return_user(row:integer):string;
//Mengembalikan username yang bersesuaian dengan kolom yang dipilih

implementation
function grantaccess(row:integer):boolean;
begin
    //Load CSV
    user_data:=load_csv('user_tmp.csv');
    
    //Return true/false berdasarkan flag admin
    if(user_data[row,5]='admin') then grantaccess:=true
    else grantaccess:=false; 
end;
procedure accessdenied();
begin
    //Mengeluarkan pesan
    writeln('Access Denied!');
    writeln('Hubungi admin untuk informasi lebih lanjut.');
end;

function return_user(row:integer):string;
begin
    //Load CSV
    user_data:=load_csv('user_tmp.csv');
    
    //Return username di row tersebut
    return_user:=user_data[row,3];
end;

end.