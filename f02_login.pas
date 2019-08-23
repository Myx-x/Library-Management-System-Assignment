//f02_login unit
//Update : 08/04/2019 14.10 WIB
//Dev : mk
//v1.0.0

unit f02_login;

interface
uses banana_csvparser,passwordhash;

var
	username, password: string;
	login_row: integer;
	login_feedback: boolean;

procedure login;
{Login user}

implementation

procedure login;

var
    user_data : banana_csvdoc;
    rc, i: integer;

begin
    //----- Prompt Input ------
    write('Masukkan username: ');
    readln(username);
    write('Masukkan password pengunjung: ');
    readln(password);

    login_feedback:=false;

    //----- Read the data -----
    
    //Change CSV form to array
    user_data:=load_csv('user_tmp.csv');

    //Get row 
    rc:=row_count(user_data);

    for i:=1 to rc do
    begin
        if(user_data[i,3]=username) and (user_data[i,4]=hash(username,password)) then
        begin
            login_feedback:=true;
            login_row:=i;
            break;
        end;
    end;

    if(login_feedback) then 
    begin
        writeln();
        writeln('Selamat datang, ',user_data[login_row,1],'!');
    end
    else 
    begin
        writeln();
        writeln('Username / password salah! Silakan coba lagi.');
    end;

end;

end.
