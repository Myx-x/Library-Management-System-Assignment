Program main;
uses crt, grantadminaccess, f01_register, f02_login, f03_cari, f04_caritahunterbit, f05_pinjambuku, f06_kembalikan_buku, f07_lapor_hilang, f08_lihat_laporan, f09_tambah_buku, f10_tambah_jumlah_buku, f11_riwayat, f12_statistik, f13_load, f14_save, f15_carianggota, f16_exit;

var
    query,user : string;
    admin, loggedin: boolean;
begin
    admin:=false;
    loggedin:=false;
    user:='';
    while(true) do
    begin
        highvideo;
        textcolor(yellow);
        if(admin) then
        begin
            textcolor(red);
            write('admin@');
        end;
        if(loggedin) then write(user,'~');
        write('$ ');
        textcolor(white);

        readln(query);
        
        lowvideo;
        if(query='load') then 
            load()
        else if(query='login') then 
        begin
            login();
            loggedin:=login_feedback;
            if(loggedin) then
            begin
                admin:=grantaccess(login_row);
                user:=return_user(login_row);
            end;
        end;
        
        if(loggedin) then
        begin
            if(query='register') then
            begin
                if(admin=true) then register()
                else accessdenied();
            end
            else if(query='cari') then 
                cari()
            else if(query='caritahunterbit') then 
                caritahun()
            else if(query='pinjam_buku') then 
                pinjambuku()
            else if(query='kembalikan_buku') then 
                kembalikanbuku(user)
            else if(query='lapor_hilang') then 
                laporhilang(user)
            else if(query='lihat_laporan') then 
            begin
                if(admin=true) then lihatlaporan()
                else accessdenied();
            end
            else if(query='tambah_buku') then 
            begin
                if(admin=true) then tambah_buku()
                else accessdenied();
            end
            else if(query='tambah_jumlah_buku') then 
            begin
                if(admin=true) then tambah_jumlah_buku()
                else accessdenied();
            end
            else if(query='riwayat') then 
            begin
                if(admin=true) then riwayat()
                else accessdenied();
            end
            else if(query='statistik') then 
            begin
                if(admin=true) then statistik()
                else accessdenied();
            end
            else if(query='save') then 
                save()
            else if(query='cari_anggota') then 
            begin
                if(admin=true) then carianggota()
                else accessdenied();
            end
            else if(query='exit') then 
            begin
                keluar();
                exit;
            end;
        end
        else if(query='load') then
        begin
			write();
		end
		else
        begin
            write('Silakan login terlebih dahulu menggunakan [');
            textcolor(green);
            write('login');
            textcolor(white);
            writeln('].');
        end;
    end;
end.
