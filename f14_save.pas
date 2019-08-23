unit f14_save;

interface
uses banana_csvparser;

procedure save();

implementation
procedure save();
var
    buku,user,peminjaman,pengembalian,kehilangan:banana_csvdoc;
    buku_filename,user_filename,peminjaman_filename,pengembalian_filename,kehilangan_filename:string;
    rc,cc:integer;
begin
    write('Masukkan nama File Buku: ');
    readln(buku_filename);
    write('Masukkan nama File User: ');
    readln(user_filename);
    write('Masukkan nama File Peminjaman: ');
    readln(peminjaman_filename);
    write('Masukkan nama File Pengembalian: ');
    readln(pengembalian_filename);
    write('Masukkan nama File Buku Hilang: ');
    readln(kehilangan_filename);

    buku:=load_csv('buku_tmp.csv');
    user:=load_csv('user_tmp.csv');
    peminjaman:=load_csv('peminjaman_tmp.csv');
    pengembalian:=load_csv('pengembalian_tmp.csv');
    kehilangan:=load_csv('kehilangan_tmp.csv');
    
    rc:=row_count(buku);
    cc:=coll_count(buku);
    save_csv(buku, buku_filename, rc,cc);

    rc:=row_count(user);
    cc:=coll_count(user);
    save_csv(user, user_filename, rc,cc);

    rc:=row_count(peminjaman);
    cc:=coll_count(peminjaman);
    save_csv(peminjaman, peminjaman_filename, rc,cc);

    rc:=row_count(pengembalian);
    cc:=coll_count(pengembalian);
    save_csv(pengembalian, pengembalian_filename, rc,cc);

    rc:=row_count(kehilangan);
    cc:=coll_count(kehilangan);
    save_csv(kehilangan, kehilangan_filename, rc,cc);
    
    writeln();
    writeln('Data berhasil disimpan!');

end;
end.
