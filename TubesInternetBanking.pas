program InternetBanking;

{Kamus}
const Nmax = 50;
type                            //setelah dipikir", semua file eksternal berarti harus dibuat tipe bentukannya
    tanggal = record
            d : integer;
            m : integer;
            y : integer;
            end;
    nasabah = record
            nonas : string;
            nama : string;
            alamat : string;
            kota : string;
            email :string;
            notelp : integer;
            id : string;
            pass : string;
            status : string;
            end;
    anasabah = array [1..Nmax] of nasabah;
    rekening = record
             noak : string;
             nonas : string;
             jenis : string;
             matauang : string;
             saldo : longint;
             setoran : longint;
             auto : string;
             jangka : integer;
             tglmulai : tanggal;
             end;
    arekening = array [1..Nmax] of rekening;
    transaksi = record
              noak : string;
              jenis : string;
              matauang : string;
              jumlah : integer;
              saldo : integer ;
              tgl : tanggal;
              end;
    atransaksi = array [1..Nmax] of transaksi;
    transfer = record
             noakasal : string;
             noaktuj : string;
             jenis : string;
             namabank : string;
             matauang : string;
             jumlah : integer;
             saldo : integer;
             tgl : tanggal;
             end;
    atransfer = array [1..Nmax] of transfer;
    pembayaran = record
               noak : string;
               jenis : string;
               rek : string;
               matauang : string;
               jumlah : integer;
               saldo : integer;
               tgl : tanggal;
               end;
    apembayaran = array [1..Nmax] of pembayaran;
    pembelian = record
              noak : string;
              jenis : string;
              penyedia : string;
              notuj : integer;
              matauang : string;
              jumlah : integer;
              saldo : integer;
              tgl : tanggal;
              end;
    apembelian = array [1..Nmax] of pembelian;
    nilaitukar = record
               nkursasal : integer;
               kursasal : string;
               nkurstuj : integer;
               kurstuj : string;
               end;
    anilaitukar = array [1..Nmax] of nilaitukar;
    databarang = record
               jenis : string;
               penyedia : string;
               harga : integer;
               end;
     adatabarang = array [1..Nmax] of databarang;

var
     //data yg dipake dalem    |    data array yg isinya       | jumlah efektif array yg isinya
     //program utama ini       |    data" dari file eksternal  | data dari file eksternal tadi
     tgl        : tanggal;
     nas        : nasabah;         anas       : anasabah;         neffanas     : integer;
     rek        : rekening ;       arek       : arekening;        neffarek     : integer;
     transa     : transaksi;       atransa    : atransaksi;       neffatransa  : integer;
     transf     : transfer;        atransf    : atransfer;        neffatransf  : integer;
     pemba      : pembayaran;      apemba     : apembayaran;      neffapemba   : integer;
     pembe      : pembelian;       apembe     : apembelian;       neffapembe   : integer;
     ntukar     : nilaitukar;      antukar    : anilaitukar;      neffantukar  : integer;
     datab      : databarang;      adatab     : adatabarang;      neffadatab   : integer;

     //Varibel setiap file eksternal yang dipakai
     fnas       : file of nasabah;      //ternyata bisa lho file of TipeBentukan !
     frek       : file of rekening;
     ftransa    : file of transaksi;
     ftransf    : file of transfer;
     fpemba     : file of pembayaran;
     fpembe     : file of pembelian;
     fntukar    : file of nilaitukar;
     fdatab     : file of databarang;

     i : integer; stop : boolean;
	 temp1 : string; temp2 : string; coba:integer;
	 
     menu : string; x:integer;
procedure login(neffanas : integer;var anas:anasabah; var nas:nasabah;var coba:integer);
begin
		write('> username: '); readln(temp1);
		write('> password: '); readln(temp2);
		stop:=false; i:=1;
		while((i<=neffanas)and(not(stop))) do
		begin
			if((anas[i].id=temp1)and(anas[i].pass=temp2)) then
			begin
				if(anas[i].status='aktif') then
				begin
					nas.nonas:=anas[i].nonas;
					nas.nama:=anas[i].nama;
					nas.alamat:=anas[i].alamat;
					nas.kota:=anas[i].kota;
					nas.email:=anas[i].email;
					nas.notelp:=anas[i].notelp;
					nas.id:=anas[i].id;
					nas.pass:=anas[i].pass;
					stop:=True;
					writeln('> Login berhasil. Selamat datang ',nas.nama,' !');
					coba:=3;
				end else
				begin
					writeln('> username tersebut sudah inaktif');
				end;
			end;
			i:=i+1
		end;
		i:=1;
		if(stop=false)then
		begin
			if(coba>0)then
			begin
				writeln('> Username atau password tidak tepat. Silahkan coba lagi. Anda hanya memiliki ',coba,' kesempatan lagi.');
			end else 
			begin
				while((i<=neffanas)and(not(stop))) do
				begin
					if((anas[i].id=temp1)and(anas[i].pass<>temp2)) then
					begin
						anas[i].status:='inaktif';
					end;
					i:=i+1;
				end;
			end;				
		end;			
end;

//F6 
procedure pembuatanRekening (neffarek : integer; nas :nasabah; var rek : rekening; var arek : arekening; tgl : tanggal);
var
        jenrek : integer;
        x,y : integer;
        stopp : boolean;
        noauto : integer;
begin
        //no akun
        writeln ('> Buat Nomor Akun : '); readln (rek.noak);
        rek.nonas := nas.nonas;
        //jenis tabungan
        writeln ('> 1. Tabungan Mandiri');
        writeln ('> 2. Deposito');
        writeln ('> 3. Tabungan Rencana');
        write ('> Pilih jenis tabungan (1,2, atau 3) : '); readln (jenrek);
        while ((jenrek<1) or (jenrek>3)) do
        begin
                writeln ('> Pilihan salah.');
                write ('> Pilih jenis tabungan (1,2, atau 3) : '); readln (jenrek);
        end;
        if (jenrek=1) then
        begin
                rek.jenis := 'tabungan mandiri';
                rek.matauang := 'IDR';
                writeln ('> Mata uang Tabungan Mandiri hanya tersedia dalam IDR.');
                //jml saldo
                write ('> Masukkan jumlah saldo (dalam IDR) yang ingin ditabungkan (min.50000) :'); readln (rek.saldo);
                while (rek.saldo<50000) do
                begin
                        writeln ('> Jumlah saldo kurang. Saldo minimal 50000 IDR');
                        write ('> Masukkan jumlah saldo (dalam IDR) yang ingin ditabungkan (min.50000) :'); readln (rek.saldo);                
                end;
                rek.setoran := 0;
                rek.auto := '-';
                rek.jangka := 0;
                rek.tglmulai := tgl;
        end else if (jenrek=2) then
        begin
                rek.jenis := 'deposito';
                //matauang
                write ('> Pilih jenis mata uang (IDR, USD, atau EUR) : '); readln (rek.matauang);
                while (rek.matauang<>'IDR') or (rek.matauang<>'USD') or (rek.matauang<>'EUR') do
                begin
                        writeln ('> Jenis mata uang tidak tersedia.');
                        write ('> Harap masukkan IDR, USD, atau EUR : '); readln (rek.matauang);
                end;
                //jml saldo
                if (rek.matauang = 'IDR') then
                begin
                        write ('> Masukkan jumlah saldo (dalam IDR) yang ingin didepositokan (min.8000000) :'); readln (rek.saldo);
                        while (rek.saldo<8000000) do
                        begin
                                writeln ('> Jumlah saldo kurang. Saldo minimal 8000000 IDR');
                                write ('> Masukkan jumlah saldo (dalam IDR) yang ingin didepositokan (min.8000000) :'); readln (rek.saldo);                
                        end;  
                end else if (rek.matauang = 'USD') then
                begin
                        write ('> Masukkan jumlah saldo (dalam USD) yang ingin didepositokan (min.600) :'); readln (rek.saldo);
                        while (rek.saldo<600) do
                        begin
                                writeln ('> Jumlah saldo kurang. Saldo minimal 600 USD');
                                write ('> Masukkan jumlah saldo (dalam USD) yang ingin didepositokan (min.600) :'); readln (rek.saldo);                
                        end;
                end else if (rek.matauang = 'EUR') then
                begin
                        write ('> Masukkan jumlah saldo (dalam EUR) yang ingin didepositokan (min.550) :'); readln (rek.saldo);
                        while (rek.saldo<550) do
                        begin
                                writeln ('> Jumlah saldo kurang. Saldo minimal 550 USD');
                                write ('> Masukkan jumlah saldo (dalam EUR) yang ingin didepositokan (min.550) :'); readln (rek.saldo);                
                        end;
                end;
                rek.setoran := 0;
                
                //jangka waktu tabungan
                writeln ('> Kami memiliki 4 jangka waktu tabungan, yakni 1 bulan, 3 bulan, 6 bulan, dan 12 bulan.');
                write ('> Pilih jangka waktu tabungan (1, 3, 6, atau 12 : '); readln(rek.jangka);
                while (rek.jangka<>1) and (rek.jangka<>3) and (rek.jangka<>6) and (rek.jangka<>12) do
                begin
                        writeln ('> Pilihan salah.');
                        write ('> Pilih jangka waktu tabungan (1, 3, 6, atau 12 : '); readln(rek.jangka);
                end;

                //autodebet
                stop:=false; i:=1; x:=0; y:=0;
		while((i<=neffarek)and(not(stop))) do
		begin
                        if (arek[i].nonas = rek.nonas) then
                        begin
                                if (arek[i].jenis = 'tabungan mandiri') then
                                begin
                                        stop := true;
                                        x := i;
                                        stopp := false;
                                        while((i<=neffarek)and(not(stopp))) do
                                        begin
                                                if (arek[i].nonas = rek.nonas) then
                                                begin
                                                        if (arek[i].jenis = 'tabungan mandiri') then
                                                        begin
                                                                stopp := true;
                                                                y := i;
                                                        end;
                                                end;
                                                inc(i);
                                        end;
                                end;
                        end;
                        inc(i);
                end;                                                                
                if (x<>0) and (arek[x].saldo>=rek.saldo) then
                begin
                        if (y<>0) and (arek[y].saldo>=rek.saldo) then
                        begin
                                writeln ('> Anda memiliki 2 buah tabungan mandiri dengan saldo yang mencukupi.');
                                writeln ('> Pilih tabungan untuk autodebet : ');
                                writeln ('> 1. ', arek[x].noak);
                                writeln ('> 2. ', arek[y].noak);
                                writeln ('> 3. Tidak ingin autodebet.');
                                write ('> Pilihan (1,2, atau 3) : ');  readln (noauto);
                                while ((noauto<1) or (noauto>3)) do
                                begin
                                        writeln ('> Pilihan salah.');
                                        write ('> Pilihan (1,2, atau 3) : ');  readln (noauto);
                                end;
                                if (noauto=1) then
                                begin
                                        rek.auto := arek[x].noak;
                                end else if (noauto=2) then
                                begin
                                        rek.auto := arek[y].noak;
                                end;
                        end else
                        begin
                                writeln ('> Anda memiliki 1 buah tabungan mandiri dengan saldo yang mencukupi.');
                                writeln ('> Pilih tabungan untuk autodebet : ');
                                writeln ('> 1. ', arek[x].noak);
                                writeln ('> 2. Tidak ingin autodebet.');
                                write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                                while ((noauto<1) or (noauto>2)) do
                                begin
                                        writeln ('> Pilihan salah.');
                                        write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                                end;
                                if (noauto=1) then
                                begin
                                        rek.auto := arek[x].noak;
                                end;
                        end;  
                end else if (y<>0) and (arek[y].saldo>=rek.saldo) then
                begin
                        writeln ('> Anda memiliki 1 buah tabungan mandiri dengan saldo yang mencukupi.');
                        writeln ('> Pilih tabungan untuk autodebet : ');
                        writeln ('> 1. ', arek[y].noak);
                        writeln ('> 2. Tidak ingin autodebet.');
                        write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                        while ((noauto<1) or (noauto>2)) do
                        begin
                                writeln ('> Pilihan salah.');
                                write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                        end;
                        if (noauto=1) then
                        begin
                                rek.auto := arek[y].noak;
                        end;
                end else
                begin
                        rek.auto := '-';
                end;
                rek.tglmulai := tgl;                                                                              
        end else if (jenrek=3) then
        begin
                rek.jenis := 'tabungan rencana';
                rek.matauang := 'IDR';
                writeln ('> Mata uang Tabungan Rencana hanya tersedia dalam IDR.');

                //jml saldo
                write ('> Masukkan jumlah saldo (dalam IDR) yang ingin ditabungkan :'); readln (rek.saldo);
                while (rek.saldo<0) do
                begin
                        writeln ('> Jumlah saldo tidak valid.');
                        write ('> Masukkan jumlah saldo (dalam IDR) yang ingin ditabungkan :'); readln (rek.saldo);                
                end;

                //setoran bulanan
                writeln ('> Untuk pembuatan Tabungan Rencana, terdapat setoran bulanan dengan jumlah minimal 500000 IDR.');
                write ('> Masukkan jumlah setoran bulanan yang anda inginkan (min. 500000: '); readln (rek.setoran);
                while (rek.setoran<500000) do
                begin
                        writeln ('> Jumlah setoran kurang.');
                        write ('> Masukkan jumlah setoran bulanan (dalam IDR) (min. 500000) :'); readln (rek.setoran);                
                end;

                //jangka waktu
                writeln ('> Jangka waktu Tabungan Rencana minimal 1 tahun dan maksimal 20 tahun.');
                write ('> Pilih jangka waktu tabungan (dalam tahun) : '); readln(rek.jangka);
                while ((rek.jangka<1) and (rek.jangka>12)) do
                begin
                        writeln ('> Pilihan salah.');
                        write ('> Pilih jangka waktu tabungan (dalam tahun) : '); readln(rek.jangka);
                end;

                //autodebet
                stop:=false; i:=1; x:=0; y:=0;
		while((i<=neffarek)and(not(stop))) do
		begin
                        if (arek[i].nonas = rek.nonas) then
                        begin
                                if (arek[i].jenis = 'tabungan mandiri') then
                                begin
                                        stop := true;
                                        x := i;
                                        stopp := false;
                                        while((i<=neffarek)and(not(stopp))) do
                                        begin
                                                if (arek[i].nonas = rek.nonas) then
                                                begin
                                                        if (arek[i].jenis = 'tabungan mandiri') then
                                                        begin
                                                                stopp := true;
                                                                y := i;
                                                        end;
                                                end;
                                                inc(i);
                                        end;
                                end;
                        end;
                        inc(i);
                end;                                                                
                if (x<>0) and (arek[x].saldo>=rek.jangka) then
                begin
                        if (y<>0) and (arek[y].saldo>=rek.jangka) then
                        begin
                                writeln ('> Anda memiliki 2 buah tabungan mandiri dengan saldo yang mencukupi.');
                                writeln ('> Pilih tabungan untuk autodebet : ');
                                writeln ('> 1. ', arek[x].noak);
                                writeln ('> 2. ', arek[y].noak);
                                writeln ('> 3. Tidak ingin autodebet.');
                                write ('> Pilihan (1,2, atau 3) : ');  readln (noauto);
                                while ((noauto<1) or (noauto>3)) do
                                begin
                                        writeln ('> Pilihan salah.');
                                        write ('> Pilihan (1,2, atau 3) : ');  readln (noauto);
                                end;
                                if (noauto=1) then
                                begin
                                        rek.auto := arek[x].noak;
                                end else if (noauto=2) then
                                begin
                                        rek.auto := arek[y].noak;
                                end;
                        end else
                        begin
                                writeln ('> Anda memiliki 1 buah tabungan mandiri dengan saldo yang mencukupi.');
                                writeln ('> Pilih tabungan untuk autodebet : ');
                                writeln ('> 1. ', arek[x].noak);
                                writeln ('> 2. Tidak ingin autodebet.');
                                write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                                while ((noauto<1) or (noauto>2)) do
                                begin
                                        writeln ('> Pilihan salah.');
                                        write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                                end;
                                if (noauto=1) then
                                begin
                                        rek.auto := arek[x].noak;
                                end;
                        end;  
                end else if (y<>0) and (arek[y].saldo>=rek.jangka) then
                begin
                        writeln ('> Anda memiliki 1 buah tabungan mandiri dengan saldo yang mencukupi.');
                        writeln ('> Pilih tabungan untuk autodebet : ');
                        writeln ('> 1. ', arek[y].noak);
                        writeln ('> 2. Tidak ingin autodebet.');
                        write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                        while ((noauto<1) or (noauto>2)) do
                        begin
                                writeln ('> Pilihan salah.');
                                write ('> Pilihan (1 atau 2) : ');  readln (noauto);
                        end;
                        if (noauto=1) then
                        begin
                                rek.auto := arek[y].noak;
                        end;
                end else
                begin
                        rek.auto := '-';
                end;
                rek.tglmulai := tgl;                                     
        end;
       { jenis : string;
             matauang : string;
             saldo : longint;
             setoran : longint;
             auto : string;
             jangka : integer;
             tglmulai : tanggal;}
        inc (neffarek);
        arek[neffarek].noak := rek.noak;
        arek[neffarek].nonas := rek.nonas;
        arek[neffarek].jenis := rek.jenis;
        arek[neffarek].matauang := rek.matauang;
        arek[neffarek].saldo := rek.saldo;
        arek[neffarek].setoran := rek.setoran;
        arek[neffarek].auto := rek.auto;
        arek[neffarek].jangka := rek.jangka;
        arek[neffarek].tglmulai := rek.tglmulai;
end;

{Algoritma}
begin
     assign(fnas,'Data Nasabah.dat');
///////////////////////////////////////// KALO  PERTAMA KALINYA COBA PROGRAM INI, BAGIAN { ..... } di bawah jgn dihapus dulu, soalnya gabisa "reset" file kalo filenya belom ada di komputer kalian
//////// Jadi, kalo seudah pertama minimal skali ngeisi data nasabah di komputer kalian sampe selesai, baru tanda { .... } nya dihapus


     reset(fnas);                   //Baca file Data Nasabah buat dimasukkin ke array di program utama kita
     neffanas:=0;                    //Nanti harusnya bagian load ini dibuat prosedurnya sendiri, nanti ya tapi
     while(not(EOF(fnas))) do
     begin
          neffanas:=neffanas+1;
          read(fnas,anas[neffanas]);        //ternyata kalo tipe datanya sama, cara read nya tinggal kaya gitu bisa lho !
     end;
	 rewrite(fnas);
     write('Tanggal Hari ini (d m y) : '); readln(tgl.d,tgl.m,tgl.y); writeln('Tanggal hari ini yaitu ',tgl.d,'-',tgl.m,'-',tgl.y);
     writeln('Pilih Menu :'); writeln('1 = Buat data nasabah baru, sekaligus dipakai langsung datanya');
	 writeln('2 = Login');writeln('ketik "exit" untuk keluar');
     write('> ');readln(menu);
	 coba:=3;
	 while((menu<>'exit')and(coba>0)) do			//Selama pengguna belum mengetik 'Exit', maka program akan terus berjalan
	begin
		if(menu='1') then x:=1 else if(menu='2') then x:=2;  //bentuk Case-Of hanya bisa Integer, jadi ubah dlu data menu ke variabel integer;
		case x of
			1 : begin
						// rewrite(fnas);
						write('Nomor Nasabah : ');readln(nas.nonas);
						write('Nama Nasabah : ');readln(nas.nama);
						write('Alamat Nasabah : ');readln(nas.alamat);
						write('Kota Nasabah : ');readln(nas.kota);
						write('E-Mail Nasabah : ');readln(nas.email);
						write('Nomor Telepon Nasabah : ');readln(nas.notelp);
						write('Username Nasabah : ');readln(nas.id);
						write('Password Nasabah : ');readln(nas.pass);
						nas.status:='aktif';							
						//Algoritma buat nge save data" sebelumnya ke file eksternal
						//Kali ini nge save data nasabah dulu aja ya
						
						neffanas:=neffanas+1;
						anas[neffanas]:=nas;
						for i:=1 to neffanas do
						begin
							write(fnas,anas[i]);
						end;
					end;
			2 : begin
                        coba:=coba-1;
						login(neffanas,anas,nas,coba);
			
					end;
		end;
	
		
	    if(coba>0) then
		begin
			write('> '); readln(menu);
		end;
	end;
    // anas[neffanas]:=nas;
	    for i:=1 to neffanas do
	    begin
	         write(fnas,anas[i]);
        end;

	
end.




