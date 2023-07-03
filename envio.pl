#!/usr/local/bin/perl
#by IV ' lost
use MIME::Lite;
use MIME::Base64;
use MIME::Entity;

$ARGC=@ARGV;
if ($ARGC !=4) {
   printf "Voc  digitou de uma forma errada. Siga as instru  es.\n";
   printf "INSTRUCOES - UND3F1N3D\n";
   printf "perl $0 <mailist> <remetente\@mail.com> <assunto> <corpo.html>\n";
   printf "Exemplo: perl $0 lista01.txt peu\@msn.com Ola index.html\n";
   exit(1);
}
$sendmail = '/usr/sbin/sendmail';

$sender = $ARGV[1];

$subject = $ARGV[2];

$efile = $ARGV[0];

$emar = $ARGV[0];

open(FOO, $ARGV[3]);

@foo = <FOO>;

open (BANDFIT, "$emar") || die "Can't Open $emar";

$cont=0;

while(<BANDFIT>)        {
($ID,
 $options) = split(/\|/,$_);
chop($options);
  foreach ($ID) {
$r2 = int(rand(99));
$r3 = int(rand(999));
$r4 = int(rand(9999));
$r5 = int(rand(99999));
$r6 = int(rand(999999));
$r7 = int(rand(9999999));
$r8 = int(rand(99999999));
$r9 = int(rand(999999999));
$recipient = $ID;
$corpox = join("\n", @foo);
$corpox =~ s/%email%/$ID/g;
$corpox =~ s/%rand1%/$r1/g;
$corpox =~ s/%rand2%/$r2/g;
$corpox =~ s/%rand3%/$r3/g;
$corpox =~ s/%rand4%/$r4/g;
$corpox =~ s/%rand5%/$r5/g;
$corpox =~ s/%rand6%/$r6/g;
$corpox =~ s/%rand7%/$r7/g;
$corpox =~ s/%rand8%/$r8/g;
$corpox =~ s/%rand9%/$r9/g;
$corpo = encode_base64($corpox);

$subject =~ s/%email%/$ID/g;
$subject =~ s/%rand1%/$r1/g;
$subject =~ s/%rand2%/$r2/g;
$subject =~ s/%rand3%/$r3/g;
$subject =~ s/%rand4%/$r4/g;
$subject =~ s/%rand5%/$r5/g;
$subject =~ s/%rand6%/$r6/g;
$subject =~ s/%rand7%/$r7/g;
$subject =~ s/%rand8%/$r8/g;
$subject =~ s/%rand9%/$r9/g;

$sender =~ s/%rand4%/$r4/g;

open (SENDMAIL, "| $sendmail -t");
print SENDMAIL "MIME-Version: 1.0\n";
print SENDMAIL "Content-type:  text/html; charset=UTF-8\n";
print SENDMAIL "Content-Transfer-Encoding: base64\n";
#print SENDMAIL "$mailtype\n";
print SENDMAIL "Subject: $subject\n";
print SENDMAIL "From: $sender\n";
print SENDMAIL "To: $recipient\n";
print SENDMAIL "$corpo\n\n";
close (SENDMAIL);

$cont=$cont+1;
printf "$cont * Enviado para > $recipient";

	   	   ## this changes =>>> ### 
### send 5 email of list.txt, and pause 5 seconds, continue.. ### 
#aqui quantos emails por vez == 1
if ( $count == 1 ) { 
print("TEMPO DE ENVIO NA VPS!\n"); 
$count = 0; 
#aqui quantos segundos ou minutos de pausa (5)
sleep(5); 
print("VAMOS LA DE NOVO..\n"); 
} 
printf "Confirmacao de entrega para $recipient [ Ok Send; $count ]"; 
$count++; 

  }

 }
close(BANDFIT);
