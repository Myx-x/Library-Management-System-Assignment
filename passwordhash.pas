//passwordhash unit
//Update : 12/04/2019 20.00 WIB
//Dev : mk
//v1.0.0


unit passwordhash;

interface

function numConv(n:integer):char;
{Konversi angka [0..61] menjadi [a..z,A..Z,0..9]}

function hash(user,pass:string):string;
{Mengembalikan password yang sudah di-hash}

implementation
function numConv(n:integer):char;
begin
    if(n>=0) and (n<26) then
        numConv:=chr(97+n)
    else if(n>=26) and (n<52) then
        numConv:=chr(65+n-26)
    else if(n>=52) and (n<62) then
        numConv:=chr(48+n-52);
end;

function hash(user,pass:string):string;
var
    salted,tmp,res:string;
    i,x:integer;
begin
    //Inisialisasi string
    salted:='';
    res:='';

    //Konversi panjang password ke stirng
    str(length(pass),tmp);

    //Melakukan 'Salting' pada password dengan username
    for i:=1 to length(pass) do salted:=salted+user[((i-1) mod length(user))+1]+pass[i];
    
    //Menambahkan satu character dari username apabila panjang password yang di-salt kelipatan dari panjang username
    if(length(salted) mod length(pass)=0) then salted:=salted+user[1];

    //Menambahkan panjang password ke password yang di-salt
    salted:=salted+tmp;

    //Melakukan algoritma hashing dengan xor agar dibentuk 64 character
    for i:=1 to 64 do
    begin
        x:=ord(salted[((i-1) mod length(salted))+1]) xor ord(user[((i-1) mod length(user))+1]);
        if(i mod 2=1) then res:=res+numConv((x+31) mod 62)
        else if(i mod 2=0) then res:=res+numConv(x mod 62);
    end;

    //Return result string
    hash:=res;
end;
end.