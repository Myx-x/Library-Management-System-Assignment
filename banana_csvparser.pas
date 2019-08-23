//banana_csvparser unit
//Update : 11/04/2019 20.00 WIB
//Dev : mk
//v1.3.2

unit banana_csvparser;

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
BANANA ©
Buat tubes Daspro STEI 2018, hak milik kelompok 7 kelas 7. :)
                                         
*)

//-------------------------------------------------------
interface

type 
    banana_csvdoc = array[1..100, 1..100] of string;

function load_csv(filename:string):banana_csvdoc;
{Load CSV to 2 dimensional string matrix}

procedure save_csv(data:banana_csvdoc;filename:string;nrow,ncoll:integer);
{Save 2 dimensional string matrix to CSV}

function strcmp(s1,s2:string):integer;
{Compare 2 string}

procedure sort_data(var data:banana_csvdoc;nrow,ncoll,row_param:integer);
{Sort data based on row using selection sort}

function row_count(data:banana_csvdoc):integer;
{Returns row count}

function coll_count(data:banana_csvdoc):integer;
{Returns coll count}

//-------------------------------------------------------

implementation

{load_csv implementation}
function load_csv(filename:string):banana_csvdoc;
var
    data:banana_csvdoc;
    i,j:integer;
    t:text;
    c:char;
    s:string;
    
begin

    //----Clean data----
    for i:=1 to 100 do
        for j:=1 to 100 do
            data[i,j]:='';


    //----Load CSV file in read mode----
    assign(t, filename);
    reset(t);

    //Set array index
    i:=1;
    j:=1;
    c:='~';

    while(not eof(t)) do
    begin
        s:='';    
        read(t,c);        

        //Append c to s as long as not new line || comma || eof
        while(c<>',') and (ord(c)<>26) and(ord(c)<>13) do
        begin
            s:=s+c;
            read(t,c);
        end;
        //Set array to s
        data[i,j]:=s;

        //New line detection
        if(ord(c)=13) then read(t,c);
        if(ord(c)=10) then
        begin
            i:=i+1;
            j:=1;
        end
        else
            j:=j+1;
        
    end;

    close(t);
    //Return modified array
    load_csv:=data;
end;

{Save_csv implementation}
procedure save_csv(data:banana_csvdoc;filename:string;nrow,ncoll:integer);
var
    i,j:integer;
    t:text;
begin

    //----Load CSV file in write mode----
    assign(t,filename);
    rewrite(t);
    
    //----Write CSV formatting----
    for i:=1 to nrow do
    begin
        for j:=1 to ncoll do
        begin
            if(j=ncoll) then write(t,data[i,j])
            else write(t,data[i,j],',')
        end;
        writeln(t);
    end;

    close(t);
end;

{strcmp implementation}
function strcmp(s1,s2:string):integer;
var
    l1,l2,i:integer;
begin
    //Initialize string length
    l1:=length(s1);
    l2:=length(s2);

    //Initialize char index
    i:=1;

    //While char different and still under length
    while(ord(s1[i])=ord(s2[i])) and (i<=l1) and (i<=l2) do
        i:=i+1;
    
    //Returns positive if s1>s2 lexicographically
    //Returns negative if s1<s2 lexicographically
    strcmp:=ord(s1[i])-ord(s2[i]);

end;

{sort_array implementation}
procedure sort_data(var data:banana_csvdoc;nrow,ncoll,row_param:integer);
var
    minrow,i,j:integer;
    temp:string;
begin

    //Selection sort
    for i:=1 to nrow-1 do
    begin
        minrow:=i;
        for j:=i+1 to nrow do
        begin
            //Finding smallest lexicographic order
            if(strcmp(data[minrow,row_param],data[j,row_param])>0) then
                minrow:=j;
        end;

        //Swap row
        if(minrow<>i)then
            for j:=1 to ncoll do
            begin
                temp:=data[i,j];
                data[i,j]:=data[minrow,j];
                data[minrow,j]:=temp;
            end;
    end;
end;

{row_count implementation}
function row_count(data:banana_csvdoc):integer;
var
    i:integer;
begin
    i:=0;
    while(data[i+1][1]<>'') do
        i:=i+1;
    row_count:=i;
end;

{row_count implementation}
function coll_count(data:banana_csvdoc):integer;
var
    i:integer;
begin
    i:=0;
    while(data[1][i+1]<>'') do
        i:=i+1;
    coll_count:=i;
end;

end.