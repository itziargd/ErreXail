#!/usr/bin/perl 
use strict;
use warnings;
use List::Util qw(sum);

#Readability asssesement for Basque
#Hainbat metrika hartuta testu baten datuak atera testu hori konplexua ote den jakiteko
#2013-10-24

my $testuZatiak;
my $hitzKopurua = 0;
my $esaldiKopurua = 0;
my $perpausKopurua = 0;
my $aposizioKopurua = 0;
#kategoriak
my $KatGuztiakKopurua = 0;
my $izenKopurua = 0;
my $izenBereziKopurua = 0;
my $izenLekuKopurua = 0;
my $aditzKopurua = 0;
my $aditzlagKopurua = 0;
my $aditzIzenKopurua = 0;
my $aditzModalKopurua = 0;
my $aditzFakKopurua = 0;
my $aditzNorKopurua = 0;
my $aditzNorkKopurua = 0;
my $aditzNoriKopurua = 0;
my $aditzNorikKopurua = 0;
my $adjKopurua = 0;
my $adbKopurua = 0;
my $lokKopurua = 0;
my $jntKopurua = 0;
my $detKopurua = 0;
my $prtKopurua = 0;
my $iorKopurua = 0;
my $bstKopurua = 0;
my $gradKopurua = 0;
my $itjKopurua = 0;
my $haosKopurua = 0;
my $labKopurua = 0;
my $sigKopurua = 0;
my $snbKopurua = 0;
my $aditzGeroKopurua = 0;
my $aditzBuruKopurua = 0;
my $aditzEzBuruKopurua = 0;
my $aditzPuntKopurua  = 0;
my $lehenaldia = 0;
my $orainaldia = 0;
my $alegialdia = 0;
my $geroaldiArkaikoa = 0;
my $indikatibo = 0;
my $subjuntibo = 0;
my $ahalera = 0;
my $inperatibo = 0;
#mendeko perpausak
my $mendekoPerpausKopurua = 0;
my $konplPerpausKopurua = 0;
my $erltPerpausKopurua = 0;
my $mendekoPerpausADBKopurua = 0;
my $denbPerpausKopurua = 0;
my $modPerpausKopurua = 0;
my $modDenbPerpausKopurua = 0;
my $kausPerpausKopurua = 0;
my $kontPerpausKopurua = 0;
my $baldPerpausKopurua = 0;
my $helbPerpausKopurua = 0;
my $entiKopurua = 0;
#diskurtsoa: lok eta jnt
my $emenLokKopurua = 0;
my $esplLokKopurua = 0;
my $aurkLokKopurua = 0;
my $kausLokKopurua = 0;
my $ondoLokKopurua = 0;
my $modLokKopurua = 0;
my $kontLokKopurua = 0;
my $baldLokKopurua = 0;
my $hautLokKopurua = 0;
my $emenJntKopurua = 0;
my $hautJntKopurua = 0;
my $aurkJntKopurua = 0;
#kasu markak
my $km = 0;
my $kmKomunztadura = 0;
my $kmLekuDenb = 0;
my $abl = 0;
my $abu = 0;
my $abz = 0;
my $ala = 0;
my $soz = 0;
my $dat = 0;
my $des = 0;
my $erg = 0;
my $gel = 0;
my $gen = 0;
my $ine = 0;
my $ins = 0;
my $mot = 0;
my $abs = 0;
my $par = 0;
my $pro = 0;
my $bnk = 0;
my $desk = 0;
#sintagamak
my $sintagmak  = 0;
my $is  = 0;
my $as  = 0;
my $adlg  = 0;
my $komunztaduraSint= 0; 
#elipsia
my $elipsia  = 0;
my $izeelipsia  = 0;
my $adielipsia  = 0;
my $detelipsia  = 0;
my $adbelipsia  = 0;
my $adjelipsia  = 0;
#karaktere kopurua
my @formak;
my @analisia;
my $forma;
my $HitzLuzeraKarakteretan;
my $karaktereKopurua  = 0;
my %hitzakLuzera;

#fitxategia iriki; sarrera fitxategia .aposizioak izan behar da. Hau da, . zatiak-i mugak eta aposizioen gramatikak pasa behar zaizkie
open(FITX,$ARGV[0]) or die("Errorea! Ezin $ARGV[0] fitxategia ireki\n");


#testua analizatu
while ($testuZatiak=<FITX>) { 


    #hitz kopurua kontatu
    if($testuZatiak=~/\"\<.*\>\"/){
    	$hitzKopurua++;
    }


    #esaldi kopurua kontatu
    if($testuZatiak=~/\"\<\$\.\>\"/){
    	$esaldiKopurua++;
    }

    #perpaus kopurua kontatu
    if($testuZatiak=~/\}MUGA/){
    	$perpausKopurua++;
    }

    #aposizio kopurua kontatu
    if($testuZatiak=~/\[APOS2/){  #apos2 jarriata apos2kontra eta apos2sint ere hartu beharko lituzke, konprobatu beste testu batekin
    	$aposizioKopurua++;
     }


####################### KATEGORIAK  (falta direnak eta azpikategoriak gehitu) 

    # izen kopurua
    if($testuZatiak=~/IZE/){
    	$izenKopurua++;
	$KatGuztiakKopurua++;
    }
    
    # izen berezi kopurua
    if($testuZatiak=~/IZB/){
    	$izenBereziKopurua++;
    }
    
    # leku izen berezi kopurua
    if($testuZatiak=~/IZB/){
    	$izenLekuKopurua++;
    }

    # aditz kopurua
    if(($testuZatiak=~/ADI/) || ($testuZatiak=~/ADT/)){
    	$aditzKopurua++;
	$KatGuztiakKopurua++;
    }

    # aditz laguntzaile kopurua
    if($testuZatiak=~/ADL/){
    	$aditzlagKopurua++;
    }

    # aditz izen kopurua
    if($testuZatiak=~/ADIZE/){
    	$aditzIzenKopurua++;
    }
    

        ####Aspektua

    if($testuZatiak=~/GERO/){
    	$aditzGeroKopurua++;
    }

    if($testuZatiak=~/BURU/){
    	$aditzBuruKopurua++;
    }

    if($testuZatiak=~/EZBU/){
    	$aditzEzBuruKopurua++;
    }


    if($testuZatiak=~/PNT/){
    	$aditzPuntKopurua++;
    }

        ####Aldia

    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ B(1|3|5B|5|6|7) /)){
    	$lehenaldia++;
    }

    if(($testuZatiak=~/ AD(L|T) /) && (($testuZatiak=~/ A(1|3|4|5) /) ||($testuZatiak=~/ (B2|C) /))){
    	$orainaldia++;
    }

    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ B(4|5A|8) /)){
    	$alegialdia++;
    }
    
    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ A4 /)){
    	$geroaldiArkaikoa++;
    }
    
    
       ####Modua 

    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ A(1|2) /)){
    	$indikatibo++;
    }

    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ A(3|4) /)){
    	$subjuntibo++;
    }
    
    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ B(5|6)( |A|B) /)){
    	$subjuntibo++;
    }

    if(($testuZatiak=~/ AD(L|T) /) && (($testuZatiak=~/ B(7|8) /) || ($testuZatiak=~/ A5 /))){ 
    	$ahalera++;
    }

    if(($testuZatiak=~/ AD(L|T) /) &&  ($testuZatiak=~/ A5 /)){ 
    	$ahalera++;
    }
  
    if(($testuZatiak=~/ AD(L|T) /) && ($testuZatiak=~/ C /)){
     	$inperatibo++;
     }

        #### Aditz modalak
    if(($testuZatiak=~/ "ahal_izan" /) || ($testuZatiak=~/ "ezin_izan" /)) { 
    	$aditzModalKopurua ++;
    }

        #### Aditz semi modalak
    if(($testuZatiak=~/ "behar_izan" /) || ($testuZatiak=~/ "nahi_izan" /) || ($testuZatiak=~/ "gura_izan" /)) { 
    	$aditzModalKopurua ++;
    }

       ####Aditz faktitiboak
    if($testuZatiak=~/ FAK /){
    	$aditzFakKopurua++;
    }

       ####Aditz mota
    if($testuZatiak=~/ NOR /){
    	$aditzNorKopurua++;
    }

        ####Aditz mota
    if($testuZatiak=~/ NOR_NORK /){
    	$aditzNorkKopurua++;
    }

        ####Aditz mota
    if($testuZatiak=~/ NOR_NORI /){
    	$aditzNoriKopurua++;
    }

        ####Aditz mota
    if($testuZatiak=~/ NOR_NORI_NORK /){
    	$aditzNorikKopurua++;
    }


 
    #adjektibo kopurua
    if($testuZatiak=~/ADJ/){
    	$adjKopurua++;
	$KatGuztiakKopurua++;
    }

    #adberbio kopurua
    if($testuZatiak=~/ADB/){
    	$adbKopurua++;
	$KatGuztiakKopurua++;
    }

    #lokailu kopurua
    if($testuZatiak=~/LOK/){
    	$lokKopurua++;
	$KatGuztiakKopurua++;
    }

    #juntagailu kopurua
    if($testuZatiak=~/JNT/){
    	$jntKopurua++;
	$KatGuztiakKopurua++;
    }
    
    #determinatzaile kopurua
    if($testuZatiak=~/DET/){
    	$detKopurua++;
	$KatGuztiakKopurua++;
	
    }

    #partikula kopurua
    if($testuZatiak=~/PRT/){
    	$prtKopurua++;
	$KatGuztiakKopurua++;
    }

    #izenordain kopurua
    if($testuZatiak=~/IOR/){
    	$iorKopurua++;
	$KatGuztiakKopurua++;
    }

    #bestelakoak kopurua
    if($testuZatiak=~/BST/){
    	$bstKopurua++;
	$KatGuztiakKopurua++;
    }

    #graduatzaile kopurua
    if($testuZatiak=~/ GRAD /){
    	$gradKopurua++;
	$KatGuztiakKopurua++;
    }

    #interjekzio kopurua
    if($testuZatiak=~/ITJ/){
    	$itjKopurua++;
	$KatGuztiakKopurua++;
    }

    #haos kopurua
    if($testuZatiak=~/HAOS/){
    	$haosKopurua++;
	$KatGuztiakKopurua++;
    }
    
    #laburtzapen kopurua ### kategoria guztietara gehitu ala beste kategoria bat dute
    if($testuZatiak=~/ LAB /){
    	$labKopurua++;
    }
    
    #sigla kopurua
    if($testuZatiak=~/ SIG /){
    	$sigKopurua++;
    }

    #sinbolo kopurua
    if($testuZatiak=~/ SNB /){
    	$snbKopurua++;
    }

    
    
  
#############MENDEKO PERPAUSAK
    if($testuZatiak=~/KONPL/){
    $konplPerpausKopurua++;
    $mendekoPerpausKopurua++;
    }

    if($testuZatiak=~/ERLT/){
    $erltPerpausKopurua++;
    $mendekoPerpausKopurua++;
    }

    if($testuZatiak=~/DENB/){
    $denbPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }

    if($testuZatiak=~/MOD/){
    $modPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }
    

    if($testuZatiak=~/MOD\/DENB/){
    $modDenbPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }

    if($testuZatiak=~/KAUS/){
    $kausPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }

    if($testuZatiak=~/KONT/){
    $kontPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }

    if($testuZatiak=~/BALD/){
    $baldPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }
    
    if($testuZatiak=~/HELB/){
    $helbPerpausKopurua++;
    $mendekoPerpausKopurua++;
    $mendekoPerpausADBKopurua++;
    }
    

######### ENTITATEAK   
    if($testuZatiak=~/ENTI/){
    $entiKopurua++;
    }


######### LOKAILU MOTAK (KOHESIOA)

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/EMEN/)){
	$emenLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/ESPL/)){
	$esplLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/AURK/)){
	$aurkLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/KAUS/)){
	$kausLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/ONDO/)){
	$ondoLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/MOD/)){
	$modLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/KONT/)){
	$kontLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/BALD/)){
	$baldLokKopurua++;
    }

    if(($testuZatiak=~/ LOK/) && ($testuZatiak=~/HAUT/)){
	$hautLokKopurua++;
    }
    
 ######### JUNTAGAiLU MOTAK    (KOHESIOA)
    if(($testuZatiak=~/ JNT/) && ($testuZatiak=~/EMEN/)){
	$emenJntKopurua++;
    }

    if(($testuZatiak=~/ JNT/) && ($testuZatiak=~/HAUT/)){
	$hautJntKopurua++;
    }
    
    if(($testuZatiak=~/ JNT/) && ($testuZatiak=~/AURK/)){
	$aurkJntKopurua++;
    }


######### KASU MARKAK   
    if($testuZatiak=~/ ABL /){
    $abl++;
    $km++;
    $kmLekuDenb++;
    }

    if($testuZatiak=~/ ABU /){
    $abu++;
    $km++;
    $kmLekuDenb++;
    }

    if($testuZatiak=~/ ABZ /){
    $abz++;
    $km++;
    $kmLekuDenb++;
    }

    if($testuZatiak=~/ ALA /){
    $ala++;
    $km++;
    $kmLekuDenb++;
    }

    if($testuZatiak=~/ SOZ /){
    $soz++;
    $km++;
    }

    if($testuZatiak=~/ DAT /){
    $dat++;
    $km++;
    $kmKomunztadura++;
    }

    if($testuZatiak=~/ DES /){
    $des++;
    $km++;
    }
    
    if($testuZatiak=~/ ERG /){
    $erg++;
    $km++;
    $kmKomunztadura++;
    }

    if($testuZatiak=~/ GEL /){
    $gel++;
    $km++;
    }

    if($testuZatiak=~/ GEN /){
    $gen++;
    $km++;
    }

    if($testuZatiak=~/ INE /){
    $ine++;
    $km++;
    $kmLekuDenb++;
    }

    if($testuZatiak=~/ INS /){
    $ins++;
    $km++;
    }

    if($testuZatiak=~/ MOT /){
    $mot++;
    $km++;
    }

    if($testuZatiak=~/ ABS /){
    $abs++;
    $km++;
    $kmKomunztadura++;
    }

    if($testuZatiak=~/ PAR /){
    $par++;
    $km++;
    $kmKomunztadura++;
    }

    if($testuZatiak=~/ PRO /){
    $pro++;
    $km++;
    }

    if($testuZatiak=~/ BNK /){
    $bnk++;
    $km++;
    }

    if($testuZatiak=~/ DESK /){
    $desk++;
    $km++;
    }


    ##############SINTAGMAK

    #izen sintagmak
    if(($testuZatiak=~/ %SIB /)|| ($testuZatiak=~/ %SINT /)){
    $is++;
    $sintagmak++;
    }

    #aditz sintagmak
    if(($testuZatiak=~/ADIKAT /)|| ($testuZatiak=~/ADIKATHAS /)){
    $as++;
    $sintagmak++;
    }

#### AZTERTZEKO
    # #aditzlaguna
    # if($testuZatiak=~/ .ADLG /){
    # $adlg++;
    # }

    # #komunztadura sintagmak
    # if(($testuZatiak=~/  \@SUBJ/) || ($testuZatiak=~/ \@OBJ /) || ($testuZatiak=~/ \@ZOBJ /)){
    # $komunztaduraSint++;
    # }
    
#######Elipsia (jarri balditza bat soilik kalkulatzeko elipsia badago, if elisia != O RATIOA kalkulatu
    if($testuZatiak=~/ IZE_IZEELI /){
    $izeelipsia++;
    $elipsia++;
    }

    if($testuZatiak=~/ DET_IZEELI /){
    $detelipsia++;
    $elipsia++;
    }

    if(($testuZatiak=~/ ADL_IZEELI /) ||($testuZatiak=~/ ADT_IZEELI /) ){
    $adielipsia++;
    $elipsia++;
    }

    if($testuZatiak=~/ ADJ_IZEELI /){
    $adjelipsia++;
    $elipsia++;
    }

    if($testuZatiak=~/ ADB_IZEELI /){
    $adbelipsia++;
    $elipsia++;
    }

############
#karaktereak kontatzeko (analisia eta formak bereiztuz)


 #fitxategia garbitu (falta diren puntuzio markak gehitu)
    $testuZatiak=~ s/<HAS_MAI>"/ /;
    $testuZatiak=~ s/S:.*/ /;
    $testuZatiak=~ s/<HAUL_EDBL>"/ /;
    $testuZatiak=~ s/<DEN_MAI>"/ /;
    $testuZatiak=~ s/<DEN_MAI_DEK>"/ /;
    $testuZatiak=~ s/<ZEN>"/ /;
    $testuZatiak=~ s/<ZEN_DEK>"/ /;
    $testuZatiak=~ s/<PUNT_PUNT>"/ /;
    $testuZatiak=~ s/<PUNT_KOMA>"/ /;
    $testuZatiak=~ s/<PUNT_BI_PUNT>"/ /;
    $testuZatiak=~ s/<BEREIZ>"/ /;
    $testuZatiak=~s/<ERROM>"/ /;

    # analisia eta formak bereiztu
    #forma jaso
    if ($testuZatiak =~ /^\"\<.*\>/){
	push (@formak,$testuZatiak); 
	#komillak kendu formei
	foreach $forma(@formak){
	    $forma=~ s/"</ /;
	    $forma=~ s/>"/ /;
	    $forma=~ s/\n/ /;# chomp($forma);
	    $forma=~ s/\s//g;
	    
	    
	    #karaktere kopurua kontatu
	    $HitzLuzeraKarakteretan = length($forma);
	    #print "$forma hitzak $HitzLuzeraKarakteretan karaktere ditu\n";
	    #hash batean sartu
	    $hitzakLuzera{$forma}=$HitzLuzeraKarakteretan;
	    # $hitzakLuzera{$HitzLuzeraKarakteretan}=$forma;
	}

    }

    #analisia jaso
    if ($testuZatiak !~ /^\"</){
	push (@analisia,$testuZatiak); 
    }



}# while

$karaktereKopurua = sum values %hitzakLuzera;
close(FITX);

#$mendekoPerpausKopurua = $konplPerpausKopurua + $erltPerpausKopurua + $denbPerpausKopurua +  $modPerpausKopurua +  $modDenbPerpausKopurua + $kausPerpausKopurua +  $kontPerpausKopurua +  $baldPerpausKopurua + $helbPerpausKopurua;

print "KOPURUAK:\n";
#Orokorrak
print "Hitz kopurua: $hitzKopurua\n";
print "Karaktere kopurua: $karaktereKopurua\n";
print "Esaldi kopurua: $esaldiKopurua\n";
print "Perpaus kopurua: $perpausKopurua\n";
print "Aposizio kopurua: $aposizioKopurua\n";
#######Kategoriak
print "Kategoriak:\n" ;  #kategoria guztien batuketa eman  $KatGuztiakKopurua gaizki
print "\t Izen kopurua: $izenKopurua\n";
print "\t\t Izen berezi kopurua: $izenBereziKopurua\n";
print "\t\t Leku izen berezi kopurua: $izenLekuKopurua\n";
print "\t Aditz kopurua: $aditzKopurua\n";
print "\t\t Aditz laguntzaile kopurua: $aditzlagKopurua\n";
print "\t\t Aditz-izen kopurua: $aditzIzenKopurua\n";
print "\t\t Aditz modal eta semi modal kopurua: $aditzModalKopurua\n";
print "\t\t Aditz faktitibo kopurua: $aditzFakKopurua\n";
print "\t\t Nor aditzen kopurua: $aditzNorKopurua\n";
print "\t\t Nor-nork aditzen kopurua: $aditzNorkKopurua\n";
print "\t\t Nor-nori aditzen kopurua: $aditzNoriKopurua\n";
print "\t\t Nor-nori-nork aditzen kopurua: $aditzNorikKopurua\n";
print "\t\t Geroaldiko aspektua duten aditzen kopurua: $aditzGeroKopurua\n";
print "\t\t Aspektu burutua duten aditzen kopurua: $aditzBuruKopurua\n";
print "\t\t Aspektu ez burutua duten aditzen kopurua: $aditzEzBuruKopurua\n";
print "\t\t Aspektu puntukaria duten aditzen kopurua (aditz trikoak): $aditzPuntKopurua\n";
print "\t\t Orainaldiko aditzen kopurua: $orainaldia\n";
print "\t\t Lehenaldiko aditzen kopurua: $lehenaldia\n";
print "\t\t Alegialdiko aditzen kopurua: $alegialdia\n";
print "\t\t Geroaldi arkaikoa (suposotiboa) duten aditzen kopurua: $geroaldiArkaikoa\n";
print "\t\t Indikatiboko aditzen kopurua: $indikatibo\n";
print "\t\t Subjuntiboko aditzen kopurua: $subjuntibo\n";
print "\t\t Ahalerazko aditzen kopurua: $ahalera\n";
print "\t\t Inperatibozko aditzen kopurua: $inperatibo\n";
print "\t Adjektibo kopurua: $adjKopurua\n";
print "\t Adberbio kopurua: $adbKopurua\n";
print "\t Lokailu kopurua: $lokKopurua\n";
print "\t \t Emendiozko lokailu kopurua: $emenLokKopurua\n";
print "\t \t Azalpenezko lokailu kopurua: $esplLokKopurua\n";
print "\t \t Aurkaritzako lokailu kopurua: $aurkLokKopurua\n";
print "\t \t Kausazko lokailu kopurua: $kausLokKopurua\n";
print "\t \t Ondoriozko lokailu kopurua: $ondoLokKopurua\n";
print "\t \t Moduzko lokailu kopurua: $modLokKopurua\n";
print "\t \t Kontzesiozko lokailu kopurua: $kontLokKopurua\n";
print "\t \t Hautakarizko lokailu kopurua: $hautLokKopurua\n";
print "\t Juntagailu kopurua: $jntKopurua\n";
print "\t \t Emendiozko juntagailu kopurua: $emenJntKopurua\n";
print "\t \t Hautakarizko juntagailu kopurua: $hautJntKopurua\n";
print "\t \t Aurkaritzako juntagailu kopurua: $aurkJntKopurua\n";
print "\t Determinatzaile kopurua: $detKopurua\n";
print "\t Partikula kopurua: $prtKopurua\n";
print "\t Izenordain kopurua: $iorKopurua\n";
print "\t Bestelakoen kopurua: $bstKopurua\n";
print "\t Graduatzaileen kopurua: $gradKopurua\n";
print "\t Interjekzioen kopurua: $itjKopurua\n";
print "\t Haos kopurua: $haosKopurua\n";
print "\t Laburtzapen kopurua: $labKopurua\n";
print "\t Sigla kopurua: $sigKopurua\n";
print "\t Sinbolo kopurua: $snbKopurua\n";
####### Mendeko perpausak
print "Mendeko perpaus kopurua: $mendekoPerpausKopurua. Horietatik adberbialak:  $mendekoPerpausADBKopurua\n";
print "\t Perpaus osagarrien kopurua: $konplPerpausKopurua\n";
print "\t Erlatibozko perpausen kopurua: $erltPerpausKopurua\n";
print "\t Denbora perpausen kopurua: $denbPerpausKopurua\n";
print "\t Modu perpausen kopurua: $modPerpausKopurua\n";
print "\t Modu-denbora perpausen kopurua: $modDenbPerpausKopurua\n";
print "\t Kausa perpausen kopurua: $kausPerpausKopurua\n";
print "\t Kontzesio perpausen kopurua: $kontPerpausKopurua\n";
print "\t Baldintza perpausen kopurua: $baldPerpausKopurua\n";
print "\t Helburu perpausen kopurua: $helbPerpausKopurua\n";
#entitateak
print "Entitate kopurua: $entiKopurua\n";
####### Kasu markak: 
print "Kasu marka kopurua: $km. Horietatik komunztadura markak $kmKomunztadura  dira eta  leku-denbora markak $kmLekuDenb.\n";
print "\t Ablatibo kopurua: $abl\n";
print "\t Adlatibo bukatuzko kopurua: $abu\n";
print "\t Adlatibo bide zuzeneko kopurua: $abz\n";
print "\t Adlatibo kopurua: $ala\n";
print "\t Soziatibo kopurua: $soz\n";
print "\t Datibo kopurua: $dat\n";
print "\t Destinabo kopurua: $des\n";
print "\t Ergatibo kopurua: $erg\n";
print "\t Leku denborazko genitibo kopurua: $gel\n";
print "\t Genitibo kopurua: $gen\n";
print "\t Inesibo kopurua: $ine\n";
print "\t Instrumental kopurua: $ins\n";
print "\t Motibatibo kopurua: $mot\n";
print "\t Absolutibo kopurua: $abs\n";
print "\t Partitibo kopurua: $par\n";
print "\t Prolatibo kopurua: $pro\n";
print "\t Banakari kopurua: $bnk\n";
print "\t Deskribatzaile kopurua: $desk\n";
####### Sintagmak
print "Sintagma kopurua: $sintagmak\n";
print "\t Izen sintagma kopurua: $is\n";
print "\t Aditz sintagma kopurua: $as\n";
#print "\t Aditzlagun kopurua: $adlg\n";
#print "\t Komunztaduradun sintagma kopurua:  $komunztaduraSint\n";
####### Elipsia
print "Elipsi kopurua: $elipsia\n";
print "\t Izen elipsi kopurua: $izeelipsia\n";
print "\t Aditz elipsi kopurua: $adielipsia\n";
print "\t Determinaltzaile elipsi kopurua: $detelipsia\n";
print "\t Adberbio elipsi kopurua: $adbelipsia\n";
print "\t Adjektibo elipsi kopurua: $adjelipsia\n";
######## RATIOAK
#orokorrak
my $batazbesteHitzEsaldiko;
#my $batazbesteHitzEsaldiko = $hitzKopurua /  $esaldiKopurua;
if ($esaldiKopurua!= 0){
    $batazbesteHitzEsaldiko = $hitzKopurua /  $esaldiKopurua;
}
else {
$batazbesteHitzEsaldiko = 0;
}

my $batazbestePerpausEsaldiko;
#my $batazbestePerpausEsaldiko = $perpausKopurua /  $esaldiKopurua;
if ($esaldiKopurua!= 0){
    $batazbestePerpausEsaldiko = $perpausKopurua /  $esaldiKopurua;
}
else {
$batazbestePerpausEsaldiko = 0;
}

my $batazbesteMendekoPerpausEsaldiko;
#my $batazbesteMendekoPerpausEsaldiko = $mendekoPerpausKopurua /  $esaldiKopurua;
if ($esaldiKopurua!= 0){
    $batazbesteMendekoPerpausEsaldiko =$mendekoPerpausKopurua /  $esaldiKopurua;
}
else {
$batazbesteMendekoPerpausEsaldiko = 0;
}

my $batazbesteMendekoPerpausPerpauseko;
#my $batazbesteMendekoPerpausPerpauseko = $mendekoPerpausKopurua /  $perpausKopurua;
if ($perpausKopurua!= 0){
    $batazbesteMendekoPerpausPerpauseko =$mendekoPerpausKopurua /  $perpausKopurua;
}
else {
$batazbesteMendekoPerpausPerpauseko = 0;
}

my $KaraktereHitzRatioa = $karaktereKopurua / $hitzKopurua; 
#kategoriak
my $IzeHitzRatioa = $izenKopurua / $hitzKopurua;
my $IzeIzenBereziRatioa = ($izenLekuKopurua +  $izenBereziKopurua) /$izenKopurua;
my $EntiRatioa = $entiKopurua  /$izenKopurua;
my $AditzHitzRatioa = $aditzKopurua / $hitzKopurua;
my $AdizeAditzRatioa;
my $AdiModalAditzRatioa;
my $AdiFakAditzRatioa;
my $AdinorAditzRatioa;
my $AdinorkAditzRatioa;
my $AdinoriAditzRatioa;
my $AdinorikAditzRatioa;
my $GeroAditzRatioa;
my $BuruAditzRatioa;
my $EzBuruAditzRatioa;
my $PuntAditzRatioa;
my $OrainAditzRatioa;
my $LehenAditzRatioa;
my $AlegiAditzRatioa;
my $GeroArkAditzRatioa;
my $IndAditzRatioa;
my $SubjAditzRatioa;
my $AhalAditzRatioa;
my $InpAditzRatioa;

if ($aditzKopurua!= 0){
    $AdizeAditzRatioa =$aditzIzenKopurua /  $aditzKopurua;
    $AdiModalAditzRatioa = $aditzModalKopurua /  $aditzKopurua;
    $AdiFakAditzRatioa = $aditzFakKopurua /  $aditzKopurua;
    $AdinorAditzRatioa = $aditzNorKopurua /  $aditzKopurua;
    $AdinorkAditzRatioa = $aditzNorkKopurua /  $aditzKopurua;
    $AdinoriAditzRatioa = $aditzNoriKopurua /  $aditzKopurua;
    $AdinorikAditzRatioa = $aditzNorikKopurua /  $aditzKopurua;
    $GeroAditzRatioa = $aditzGeroKopurua /  $aditzKopurua;
    $BuruAditzRatioa = $aditzBuruKopurua /  $aditzKopurua;
    $EzBuruAditzRatioa = $aditzEzBuruKopurua /  $aditzKopurua;
    $PuntAditzRatioa = $aditzPuntKopurua /  $aditzKopurua;
    $OrainAditzRatioa = $orainaldia /  $aditzKopurua;
    $LehenAditzRatioa = $lehenaldia /  $aditzKopurua;
    $AlegiAditzRatioa = $alegialdia /  $aditzKopurua;
    $GeroArkAditzRatioa = $geroaldiArkaikoa /  $aditzKopurua;
    $IndAditzRatioa = $indikatibo /  $aditzKopurua;
    $SubjAditzRatioa = $subjuntibo /  $aditzKopurua;
    $AhalAditzRatioa = $ahalera /  $aditzKopurua;
    $InpAditzRatioa = $inperatibo /  $aditzKopurua;
}
else {
$AdizeAditzRatioa = 0;
$AdiModalAditzRatioa= 0;
$AdiFakAditzRatioa= 0;
$AdinorAditzRatioa= 0;
$AdinorkAditzRatioa= 0;
$AdinoriAditzRatioa= 0;
$AdinorikAditzRatioa= 0;
$GeroAditzRatioa= 0;
$BuruAditzRatioa= 0;
$EzBuruAditzRatioa= 0;
$PuntAditzRatioa= 0;
$OrainAditzRatioa= 0;
$LehenAditzRatioa= 0;
$AlegiAditzRatioa= 0;
$GeroArkAditzRatioa= 0;
$IndAditzRatioa= 0;
$SubjAditzRatioa= 0;
$AhalAditzRatioa= 0;
$InpAditzRatioa= 0;
}
#my $AdizeAditzRatioa = $aditzIzenKopurua /  $aditzKopurua;
#my $AdiModalAditzRatioa = $aditzModalKopurua /  $aditzKopurua;
#my $AdiFakAditzRatioa = $aditzFakKopurua /  $aditzKopurua;
#my $AdinorAditzRatioa = $aditzNorKopurua /  $aditzKopurua;
#my $AdinorkAditzRatioa = $aditzNorkKopurua /  $aditzKopurua;
#my $AdinoriAditzRatioa = $aditzNoriKopurua /  $aditzKopurua;
#my $AdinorikAditzRatioa = $aditzNorikKopurua /  $aditzKopurua;
#my $GeroAditzRatioa = $aditzGeroKopurua /  $aditzKopurua;
#my $BuruAditzRatioa = $aditzBuruKopurua /  $aditzKopurua;
#my $EzBuruAditzRatioa = $aditzEzBuruKopurua /  $aditzKopurua;
#my $PuntAditzRatioa = $aditzPuntKopurua /  $aditzKopurua;
#my $OrainAditzRatioa = $orainaldia /  $aditzKopurua;
#my $LehenAditzRatioa = $lehenaldia /  $aditzKopurua;
#my $AlegiAditzRatioa = $alegialdia /  $aditzKopurua;
#my $GeroArkAditzRatioa = $geroaldiArkaikoa /  $aditzKopurua;
#my $IndAditzRatioa = $indikatibo /  $aditzKopurua;
#my $SubjAditzRatioa = $subjuntibo /  $aditzKopurua;
#my $AhalAditzRatioa = $ahalera /  $aditzKopurua;
#my $InpAditzRatioa = $inperatibo /  $aditzKopurua;

my $IzeAditzHitzRatioa = ($izenKopurua +  $aditzKopurua) / $hitzKopurua;
my $AdjHitzRatioa = $adjKopurua / $hitzKopurua;
my $AdbHitzRatioa = $adbKopurua / $hitzKopurua;
my $LokHitzRatioa = $lokKopurua / $hitzKopurua;
my $JntHitzRatioa = $jntKopurua / $hitzKopurua;
my $DetHitzRatioa = $detKopurua / $hitzKopurua;
my $PrtHitzRatioa = $prtKopurua / $hitzKopurua;
my $IorHitzRatioa = $iorKopurua / $hitzKopurua;
my $BstHitzRatioa = $bstKopurua / $hitzKopurua;
my $GradHitzRatioa = $gradKopurua / $hitzKopurua;
my $ItjHitzRatioa = $itjKopurua / $hitzKopurua;
my $HaosHitzRatioa = $haosKopurua / $hitzKopurua;
my $LabHitzRatioa = $labKopurua / $hitzKopurua;
my $SigHitzRatioa = $sigKopurua / $hitzKopurua;
my $SnbHitzRatioa = $snbKopurua / $hitzKopurua;
# mendeko perpausak
# my $AdbMendPerpausRatioa = $mendekoPerpausADBKopurua  /  $mendekoPerpausKopurua;
# my $KonplMendPerpausRatioa = $konplPerpausKopurua /  $mendekoPerpausKopurua;
# my $ErltMendPerpausRatioa = $erltPerpausKopurua /  $mendekoPerpausKopurua;
# my $DenbMendPerpausRatioa = $denbPerpausKopurua /  $mendekoPerpausKopurua;
# my $ModMendPerpausRatioa = $modPerpausKopurua /  $mendekoPerpausKopurua;
# my $ModDenbMendPerpausRatioa = $modDenbPerpausKopurua /  $mendekoPerpausKopurua;
# my $KausMendPerpausRatioa = $kausPerpausKopurua /  $mendekoPerpausKopurua;
# my $KontMendPerpausRatioa = $kontPerpausKopurua /  $mendekoPerpausKopurua;
# my $BaldMendPerpausRatioa = $baldPerpausKopurua /  $mendekoPerpausKopurua;
# my $HelbMendPerpausRatioa = $helbPerpausKopurua /  $mendekoPerpausKopurua;
my $AdbMendPerpausRatioa;
my $KonplMendPerpausRatioa;
my $ErltMendPerpausRatioa;
my $DenbMendPerpausRatioa;
my $ModMendPerpausRatioa;
my $ModDenbMendPerpausRatioa;
my $KausMendPerpausRatioa;
my $KontMendPerpausRatioa;
my $BaldMendPerpausRatioa;
my $HelbMendPerpausRatioa;

if  ($mendekoPerpausKopurua != 0){
$AdbMendPerpausRatioa = $mendekoPerpausADBKopurua  /  $mendekoPerpausKopurua;
$KonplMendPerpausRatioa = $konplPerpausKopurua /  $mendekoPerpausKopurua;
$ErltMendPerpausRatioa = $erltPerpausKopurua /  $mendekoPerpausKopurua;
$DenbMendPerpausRatioa = $denbPerpausKopurua /  $mendekoPerpausKopurua;
$ModMendPerpausRatioa = $modPerpausKopurua /  $mendekoPerpausKopurua;
$ModDenbMendPerpausRatioa = $modDenbPerpausKopurua /  $mendekoPerpausKopurua;
$KausMendPerpausRatioa = $kausPerpausKopurua /  $mendekoPerpausKopurua;
$KontMendPerpausRatioa = $kontPerpausKopurua /  $mendekoPerpausKopurua;
$BaldMendPerpausRatioa = $baldPerpausKopurua /  $mendekoPerpausKopurua;
$HelbMendPerpausRatioa = $helbPerpausKopurua /  $mendekoPerpausKopurua;
}
else {
$AdbMendPerpausRatioa = 0;
$KonplMendPerpausRatioa =  0;
$ErltMendPerpausRatioa =  0;
$DenbMendPerpausRatioa =  0;
$ModMendPerpausRatioa = 0;
$ModDenbMendPerpausRatioa =  0;
$KausMendPerpausRatioa =  0;
$KontMendPerpausRatioa = 0;
$BaldMendPerpausRatioa =  0;
$HelbMendPerpausRatioa =  0;
}



###### Lok eta Jnt (zatiketak 0 eman du)
# my $EmenLokRatioa = $emenLokKopurua  / $lokKopurua;
# my $EsplLokRatioa = $esplLokKopurua  / $lokKopurua;
# my $AurkLokRatioa = $aurkLokKopurua  / $lokKopurua;
# my $KausLokRatioa = $kausLokKopurua  / $lokKopurua;
# my $OndoLokRatioa = $ondoLokKopurua  / $lokKopurua;
# my $ModLokRatioa = $modLokKopurua  / $lokKopurua;
# my $KontLokRatioa = $kontLokKopurua  / $lokKopurua;
# my $BaldLokRatioa = $baldLokKopurua  / $lokKopurua;
# my $HautLokRatioa = $hautLokKopurua  / $lokKopurua;
# my $EmenJntRatioa = $emenJntKopurua  / $jntKopurua;
# my $HautJntRatioa = $hautJntKopurua  / $jntKopurua;
# my $AurkJntRatioa = $aurkJntKopurua  / $jntKopurua;
###### Lok eta Jnt (zatiketak 0 eman du)
my $EmenLokRatioa;
my $EsplLokRatioa;
my $AurkLokRatioa;
my $KausLokRatioa;
my $OndoLokRatioa;
my $ModLokRatioa;
my $KontLokRatioa;
my $BaldLokRatioa;
my $HautLokRatioa;
my $EmenJntRatioa;
my $HautJntRatioa;
my $AurkJntRatioa;

if  ($lokKopurua != 0){
$EmenLokRatioa = $emenLokKopurua  / $lokKopurua;
$EsplLokRatioa = $esplLokKopurua  / $lokKopurua;
$AurkLokRatioa = $aurkLokKopurua  / $lokKopurua;
$KausLokRatioa = $kausLokKopurua  / $lokKopurua;
$OndoLokRatioa = $ondoLokKopurua  / $lokKopurua;
$ModLokRatioa = $modLokKopurua  / $lokKopurua;
$KontLokRatioa = $kontLokKopurua  / $lokKopurua;
$BaldLokRatioa = $baldLokKopurua  / $lokKopurua;
$HautLokRatioa = $hautLokKopurua  / $lokKopurua;
}

else {
$EmenLokRatioa = 0;
$EsplLokRatioa = 0;
$AurkLokRatioa = 0;
$KausLokRatioa = 0;
$OndoLokRatioa = 0;
$ModLokRatioa = 0;
$KontLokRatioa = 0;
$BaldLokRatioa = 0;
$HautLokRatioa = 0;

}

if  ($jntKopurua != 0){
$EmenJntRatioa = $emenJntKopurua  / $jntKopurua;
$HautJntRatioa = $hautJntKopurua  / $jntKopurua;
$AurkJntRatioa = $aurkJntKopurua  / $jntKopurua;
}
else {
$EmenJntRatioa = 0;
$HautJntRatioa = 0;
$AurkJntRatioa = 0;
}

###### Kasu markak
my $AblKmRatioa =  $abl / $km;
my $AbuKmRatioa =  $abu / $km;
my $AbzKmRatioa =  $abz / $km;
my $AlaKmRatioa =  $ala / $km;
my $SozKmRatioa =  $soz / $km;
my $DatKmRatioa =  $dat / $km;
my $DesKmRatioa =  $des / $km;
my $ErgKmRatioa =  $erg / $km;
my $GelKmRatioa =  $gel / $km;
my $GenKmRatioa =  $gen / $km;
my $IneKmRatioa =  $ine / $km;
my $InsKmRatioa =  $ins / $km;
my $MotKmRatioa =  $mot / $km;
my $AbsKmRatioa =  $abs / $km;
my $ParKmRatioa =  $par / $km;
my $ProKmRatioa =  $pro / $km;
my $BnkKmRatioa =  $bnk / $km;
my $DeskKmRatioa =  $desk / $km;  
####### Elipsia
# my $ElipsiHitzRatioa = $elipsia / $hitzKopurua;
# my $IzeElipsiHitzRatioa = $izeelipsia / $elipsia;
# my $AdiElipsiHitzRatioa = $adielipsia / $elipsia;
# my $DetElipsiHitzRatioa = $detelipsia / $elipsia;
# my $AdbElipsiHitzRatioa = $adbelipsia / $elipsia;
# my $AdjElipsiHitzRatioa = $adjelipsia / $elipsia;

my $ElipsiHitzRatioa;
my $IzeElipsiHitzRatioa; 
my $AdiElipsiHitzRatioa;
my $DetElipsiHitzRatioa; 
my $AdbElipsiHitzRatioa;
my $AdjElipsiHitzRatioa; 

if  ($elipsia != 0){  #(jarritako balditza bat soilik kalkulatzeko elipsia badago, bestela errorea emanten du 0rekin zatiketa egitean

$ElipsiHitzRatioa = $elipsia / $hitzKopurua;
$IzeElipsiHitzRatioa = $izeelipsia / $elipsia;
$AdiElipsiHitzRatioa = $adielipsia / $elipsia;
$DetElipsiHitzRatioa = $detelipsia / $elipsia;
$AdbElipsiHitzRatioa = $adbelipsia / $elipsia;
$AdjElipsiHitzRatioa = $adjelipsia / $elipsia;
}

else {
$ElipsiHitzRatioa = 0;
$IzeElipsiHitzRatioa = 0;
$AdiElipsiHitzRatioa = 0;
$DetElipsiHitzRatioa = 0;
$AdbElipsiHitzRatioa = 0;
$AdjElipsiHitzRatioa = 0;
}

#moforsintasiko ratioak
my $ApoSintRatioa; 
my $ISSintRatioa; 
my $ASSintRatioa;
my $ApoISRatioa; 
my $ISEsaldiRatioa;
#my $esaldiKopurua;

if  ($sintagmak!= 0){ 
$ApoSintRatioa=    $aposizioKopurua / $sintagmak;
$ISSintRatioa=    $is / $sintagmak;
$ASSintRatioa=    $as / $sintagmak;
}

else { 
$ApoSintRatioa=   0;
$ISSintRatioa=   0; 
$ASSintRatioa=   0;
}


if  ($is!= 0){ 
$ApoISRatioa =  $aposizioKopurua / $is;
}
else {
$ApoISRatioa = 0;
}


if  ($esaldiKopurua!= 0){
$ISEsaldiRatioa= $is / $esaldiKopurua;
}

else{
$ISEsaldiRatioa= 0;
}


          
print "RATIOAK:\n Testu honi dagozkion ratioak ondorengo hauek dira.\n";

#Orokorrak
print "Orokorrak:\n";
print "Esaldien batazbesteko hitz kopurua $batazbesteHitzEsaldiko da.\n";
#print "Esaldien batazbesteko perpaus kopurua $batazbestePerpausEsaldiko da.\n";
print "Esaldien batazbesteko mendeko perpaus kopurua $batazbestePerpausEsaldiko da.\n";
#print "Perpausen batazbesteko mendeko perpaus kopurua $batazbestePerpausEsaldiko da.\n";
print "Hitzen batazbesteko karaktere kopurua $KaraktereHitzRatioa da.\n";
#######Kategoriak
print "Kategorien emaitzak:\n";
print "Izenen eta hitz guztien arteko ratioa $IzeHitzRatioa da.\n";
print "\t Izen berezien eta izen arrunten arteko ratioa $IzeIzenBereziRatioa da.\n";
print "\t Entitateen eta izen arrunten arteko ratioa $EntiRatioa da.\n";
print "Aditzen eta hitz guztien arteko ratioa $AditzHitzRatioa da.\n";
print "\t Aditz-izenen eta aditz guztien arteko ratioa $AdizeAditzRatioa da.\n";
print "\t Aditz modalen eta aditz guztien arteko ratioa $AdiModalAditzRatioa da.\n";
print "\t Aditz faktitiboen eta aditz guztien arteko ratioa $AdiFakAditzRatioa da.\n";
print "\t Nor aditzen eta aditz guztien arteko ratioa $AdinorAditzRatioa da.\n";
print "\t Nor-nork aditzen eta aditz guztien arteko ratioa $AdinorkAditzRatioa da.\n";
print "\t Nor-nori aditzen eta aditz guztien arteko ratioa $AdinoriAditzRatioa da.\n";
print "\t Nor-nori-nork aditzen eta aditz guztien arteko ratioa $AdinorikAditzRatioa da.\n";
print "\t Geroaldiko aspektua duten aditzen eta aditz guztien arteko ratioa $GeroAditzRatioa da.\n";
print "\t Aspektu burutua duten aditzen eta aditz guztien arteko ratioa $BuruAditzRatioa da.\n";
print "\t Aspektu ez burutua duten aditzen eta aditz guztien arteko ratioa $EzBuruAditzRatioa da.\n";
print "\t Aspektu puntukaria duten aditzen eta aditz guztien arteko ratioa $PuntAditzRatioa da.\n";
#aditzaren aldia eta modua
print "\t Orainaldiko aditzen eta aditz guztien arteko ratioa $OrainAditzRatioa da.\n";
print "\t Lehenaldiko aditzen eta aditz guztien arteko ratioa $LehenAditzRatioa da.\n";
print "\t Alegialdiko aditzen eta aditz guztien arteko ratioa $AlegiAditzRatioa da.\n";
print "\t Geroaldi arkaikoa (suposotiboa) duten aditzen eta aditz guztien arteko ratioa $GeroArkAditzRatioa da.\n";
print "\t Indikatiboko aditzen eta aditz guztien arteko ratioa $IndAditzRatioa da.\n";
print "\t Subjuntiboko aditzen eta aditz guztien arteko ratioa $SubjAditzRatioa da.\n";
print "\t Ahalerazko aditzen eta aditz guztien arteko ratioa $AhalAditzRatioa da.\n";
print "\t Inperatibo aditzen eta aditz guztien arteko ratioa $InpAditzRatioa da.\n"; 
print "Izenen  eta aditzen batuketaren eta hitz guztien arteko ratioa $IzeAditzHitzRatioa da.\n";
print "Adjektiboen eta hitz guztien arteko ratioa $AdjHitzRatioa da.\n";
print "Adberbioen eta hitz guztien arteko ratioa $AdbHitzRatioa da.\n";
print "Lokailuen eta hitz guztien arteko ratioa $LokHitzRatioa da.\n";
print "Juntagailuen eta hitz guztien arteko ratioa $JntHitzRatioa da.\n";
print "Determinatzaileen eta hitz guztien arteko ratioa $DetHitzRatioa da.\n";
print "Partikulen eta hitz guztien arteko ratioa $PrtHitzRatioa da.\n";
print "Izenordainen eta hitz guztien arteko ratioa $IorHitzRatioa da.\n";
print "Bestelakoen eta hitz guztien arteko ratioa $BstHitzRatioa da.\n";
print "Graduatzaileen eta hitz guztien arteko ratioa $GradHitzRatioa da.\n";
print "Interjekzioen eta hitz guztien arteko ratioa $ItjHitzRatioa da.\n";
print "Haosen eta hitz guztien arteko ratioa $HaosHitzRatioa da.\n";
print "Laburtzapenen eta hitz guztien arteko ratioa $LabHitzRatioa da.\n";
print "Siglen eta hitz guztien arteko ratioa $SigHitzRatioa da.\n";
print "Sinboloen eta hitz guztien arteko ratioa $SnbHitzRatioa da.\n";

####### Mendeko perpausak
print "Mendeko perpausak:\n";
print "Mendeko perpaus adberbialen eta mendeko perpaus guztien arteko ratioa   $AdbMendPerpausRatioa da.\n";
print "Perpaus konpletiboen eta mendeko perpaus guztien arteko ratioa $KonplMendPerpausRatioa da.\n";
print "Erlatibozko perpausen eta mendeko perpaus guztien arteko ratioa $ErltMendPerpausRatioa da.\n";
print "Denbora perpausen eta mendeko perpaus guztien arteko ratioa $DenbMendPerpausRatioa da.\n";
print "Modu perpausen eta mendeko perpaus guztien arteko ratioa $ModMendPerpausRatioa da.\n";
print "Modu-denbora perpausen eta mendeko perpaus guztien arteko ratioa $ModDenbMendPerpausRatioa da.\n";
print "Kausa perpausen eta mendeko perpaus guztien arteko ratioa $KausMendPerpausRatioa da.\n";
print "Kontzesio perpausen eta mendeko perpaus guztien arteko ratioa $KontMendPerpausRatioa da.\n";
print "Baldintza perpausen eta mendeko perpaus guztien arteko ratioa $BaldMendPerpausRatioa da.\n";
print "Helburu perpausen eta mendeko perpaus guztien arteko ratioa $HelbMendPerpausRatioa da.\n";
###### Lok eta Jnt
print "Kohesioa (lokailuak eta juntagailuak):\n";
print "Emediozko lokailuen eta lokailu guztien arteko ratioa $EmenLokRatioa da.\n";
print "Azalpenezko lokailuen eta lokailu guztien arteko ratioa $EsplLokRatioa da.\n";
print "Aurkaritzako lokailuen eta lokailu guztien arteko ratioa $AurkLokRatioa da.\n";
print "Kausazko lokailuen eta lokailu guztien arteko ratioa $KausLokRatioa da.\n";
print "Ondoriozko lokailuen eta lokailu guztien arteko ratioa $OndoLokRatioa da.\n";
print "Moduzko lokailuen eta lokailu guztien arteko ratioa $ModLokRatioa da.\n";
print "Kontzesiozko lokailuen eta lokailu guztien arteko ratioa $KontLokRatioa da.\n";
print "Baldintzazko lokailuen eta lokailu guztien arteko ratioa $BaldLokRatioa da.\n";
print "Lokailu hautakarien eta lokailu guztien arteko ratioa $HautLokRatioa da.\n";
print "Emediozko juntagailuen eta juntagailu guztien arteko ratioa $EmenJntRatioa da.\n";
print "Juntagailu hautakarien eta juntagailu guztien arteko ratioa $HautJntRatioa da.\n";
print "Aurkaritzako juntagailuen eta juntagailu guztien arteko ratioa $AurkJntRatioa da.\n";
###### Kasu markak
print "Kasu markak:\n";
print "Ablatiboaren eta kasu marka guztien arteko ratioa $AblKmRatioa da.\n";
print "Adlatibo bukatuzkoaren eta kasu marka guztien arteko ratioa $AbuKmRatioa da.\n";
print "Adlatibo bide zuzenekoaren eta kasu marka guztien arteko ratioa $AbzKmRatioa da.\n";
print "Adlatiboaren eta kasu marka guztien arteko ratioa $AlaKmRatioa da.\n";
print "Soziatiboaren eta kasu marka guztien arteko ratioa $SozKmRatioa da.\n";
print "Datiboaren eta kasu marka guztien arteko ratioa $DatKmRatioa da.\n";
print "Destinatiboaren eta kasu marka guztien arteko ratioa $DesKmRatioa da.\n";
print "Ergatiboaren eta kasu marka guztien arteko ratioa $ErgKmRatioa da.\n";
print "Leku denborazko genitiboaren eta kasu marka guztien arteko ratioa $GelKmRatioa da.\n";
print "Genitiboaren eta kasu marka guztien arteko ratioa $GenKmRatioa da.\n";
print "Inesiboaren eta kasu marka guztien arteko ratioa $IneKmRatioa da.\n";
print "Instrumentalaren eta kasu marka guztien arteko ratioa $InsKmRatioa da.\n";
print "Motibatiboaren eta kasu marka guztien arteko ratioa $MotKmRatioa da.\n";
print "Absolutiboaren eta kasu marka guztien arteko ratioa $AbsKmRatioa da.\n";
print "Partitiboaren eta kasu marka guztien arteko ratioa $ParKmRatioa da.\n";
print "Prolatiboaren eta kasu marka guztien arteko ratioa $ProKmRatioa da.\n";
print "Banakariaren eta kasu marka guztien arteko ratioa $BnkKmRatioa da.\n";
print "Deskribatzailearen eta kasu marka guztien arteko ratioa $DeskKmRatioa da.\n";
####### Elipsia
print "Elipsia:\n";
print "Elipsidun hitzen eta hitz guztien arteko ratioa $ElipsiHitzRatioa da.\n";
print "Elipsidun izenen eta elipsidun hitz guztien arteko ratioa $IzeElipsiHitzRatioa da.\n";
print "Elipsidun aditzen eta elipsidun hitz guztien arteko ratioa $AdiElipsiHitzRatioa da.\n";
print "Elipsidun determinatzaileen eta elipsidun hitz guztien arteko ratioa $DetElipsiHitzRatioa da.\n";
print "Elipsidun adberbioen eta elipsidun hitz guztien arteko ratioa $AdbElipsiHitzRatioa da.\n";
print "Elipsidun adjektiboen eta elipsidun hitz guztien arteko ratioa $AdjElipsiHitzRatioa da.\n";
####### Morfosintaxia 
print "Morfosintaxia:\n";
print "Aposizioen eta sintagmen arteko ratioa $ApoSintRatioa da.\n";
print "Izen sintagmen eta sintagmen arteko ratioa $ISSintRatioa da.\n";
print "Aditz sintagmen eta sintagmen arteko ratioa $ASSintRatioa da.\n";
print "Aposizioen eta izen sintagmen arteko ratioa $ApoISRatioa da.\n";
print "Izen sintagmen eta esaldien arteko ratioa $ISEsaldiRatioa da.\n";

