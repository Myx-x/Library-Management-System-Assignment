//f01_register unit
//Update : 08/04/2019 10.30 WIB
//Dev : mk
//v1.0.0

unit f01_register;

interface

uses banana_csvparser,passwordhash;

procedure register;
{Register user}

implementation

procedure register;

var
    name,address,username,password:string;
    user_data : banana_csvdoc;
    rc,cc: integer;

begin
    //----- Prompt input -----
    write('Masukkan nama pengunjung: ');
    readln(name);
    write('Masukkan alamat pengunjung: ');
    readln(address);
    write('Masukkan username pengunjung: ');
    readln(username);
    write('Masukkan password pengunjung: ');
    readln(password);

    //----- Insert data -----

    //Change CSV form to array
    user_data:=load_csv('user.csv');
    
    //Get row and coll count
    rc:=row_count(user_data);
    cc:=coll_count(user_data);

    //Insert data to array
    user_data[rc+1,1]:=name;
    user_data[rc+1,2]:=address;
    user_data[rc+1,3]:=username;
    user_data[rc+1,4]:=hash(username,password);
    user_data[rc+1,5]:='pengunjung';
    
    //Change array form to CSV
    save_csv(user_data,'user_tmp.csv',rc+1,cc);

    //Success message
    writeln();
    writeln('Pengunjung ',name, ' berhasil didaftarkan sebagai user.');

end;

end.
