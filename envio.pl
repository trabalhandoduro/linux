#!/usr/local/bin/perl
use MIME::Lite;
use MIME::Base64;
#use MIME::Entity;

#my $random_number = int(rand(912247050214287735))+9999999999999;
#my $random_number2 = int(rand(765982796313649823))+9999999999999;

$ARGC=@ARGV;
if ($ARGC !=4) {
   printf "Você digitou de uma forma errada. Siga as instruções.\n";
   printf "INSTRUÇÕES - UND3F1N3D\n";
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
$corpo = join("\n", @foo);
open (BANDFIT, "$emar") || die "Can't Open $emar";
$cont=0;

while(<BANDFIT>) {
   ($ID,$options) = split(/\|/,$_);
   chop($options);
   foreach ($ID) {
      $recipient = $ID;
        $msg = MIME::Lite->new(
                         From     => $sender,
                         To       => $recipient,
                         Subject  => $subject,
                         Type     => 'multipart/mixed'
                         );

        # Add your text message.
        $msg->attach(Type         => 'text/html',
                     Data         => $corpo
                    );

        # Specify your file as attachement.
        $msg->attach(Type        => 'text/html', #Mimetype do arquivo
                     Path        => '/var/www/html/1.html', #Pasta do arquivo
                     Filename    => '1.html', #Nome do arquivo
                     Disposition => 'attachment'
                    );  

        # Specify your file as attachement.
        $msg->attach(Type        => 'arquivo/zip', #Mimetype do arquivo
                     Path        => '/var/www/html/arquivo.zip', #Pasta do arquivo
                     Filename    => 'arquivo.zip', #Nome do arquivo
                     Disposition => 'attachment'
                    );       
     
        $msg->send;

      $cont=$cont+1;
      printf "$cont Enviado para $recipient";
	  
	    ## this changes =>>> ### 
### send 5 email of list.txt, and pause 5 seconds, continue.. ### 
if ( $count == 1 ) { 
print("TEMPO DE ENVIO NA VPS!\n"); 
$count = 0; 
sleep(5); 
print("VAMOS LA DE NOVO..\n"); 
} 
printf "Confirmacao de entrega para $recipient [ Ok Send; $count ]"; 
$count++; 

   }
}
close(BANDFIT);