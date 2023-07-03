#!/usr/local/bin/perl
# by IV 'lost'
use strict;
use warnings;
use MIME::Lite;
use MIME::Base64;
use MIME::Entity;

sub enviar_email {
    my ($sender, $recipient, $subject, $corpo) = @_;

    my $sendmail = '/usr/sbin/sendmail';

    open (SENDMAIL, "| $sendmail -t");
    print SENDMAIL "MIME-Version: 1.0\n";
    print SENDMAIL "Content-type: text/html; charset=UTF-8\n";
    print SENDMAIL "Content-Transfer-Encoding: base64\n";
    print SENDMAIL "Subject: $subject\n";
    print SENDMAIL "From: $sender\n";
    print SENDMAIL "To: $recipient\n";
    print SENDMAIL encode_base64($corpo);
    close (SENDMAIL);
}

sub ler_corpo_do_arquivo {
    my ($arquivo) = @_;

    open(my $fh, '<', $arquivo) or die "Erro ao abrir o arquivo '$arquivo': $!";
    my @linhas = <$fh>;
    close($fh);

    return join("", @linhas);
}

sub main {
    my $ARGC = @ARGV;
    if ($ARGC != 4) {
        die "Uso incorreto. Siga as instruções.\nINSTRUCOES - UND3F1N3D\nperl $0 <mailist> <remetente\@mail.com> <assunto> <corpo.html>\nExemplo: perl $0 lista01.txt meu\@exemplo.com Ola index.html\n";
    }

    my $sender = $ARGV[1];
    my $subject = $ARGV[2];
    my $recipient_file = $ARGV[0];
    my $corpo_file = $ARGV[3];

    my @recipients;
    open (BANDFIT, "$recipient_file") or die "Não foi possível abrir o arquivo '$recipient_file': $!";
    while (<BANDFIT>) {
        my ($ID, $options) = split(/\|/, $_);
        if (!defined $options) {
            die "Erro: A linha lida não contém o caractere '|'. Verifique o conteúdo do arquivo '$recipient_file'.";
        }
        chop($options);
        push @recipients, $ID;
    }
    close(BANDFIT);

    my $corpo = ler_corpo_do_arquivo($corpo_file);

    my $cont = 0;
    foreach my $recipient (@recipients) {
        $cont++;
        printf "$cont * Enviado para > $recipient\n";
        ## Aqui quantos emails por vez == 1
        if ($cont == 1) {
            print "TEMPO DE ENVIO NA VPS!\n";
            $cont = 0;
            ## Aqui quantos segundos ou minutos de pausa (5)
            sleep(5);
            print "VAMOS LA DE NOVO..\n";
        }
        printf "Confirmacao de entrega para $recipient [ Ok Send; $cont ]\n";

        $subject =~ s/%email%/$recipient/g;
        $sender =~ s/%rand4%/$cont/g;

        enviar_email($sender, $recipient, $subject, $corpo);
    }
}

main();
