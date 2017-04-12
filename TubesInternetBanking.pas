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
             jenis : string;
             matauang : string;
             saldo : integer;
             setoran:integer;
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




