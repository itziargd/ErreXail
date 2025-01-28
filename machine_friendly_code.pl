#!/usr/bin/perl 
use strict;
use warnings;
use List::Util qw(sum);

#Readability asssesement for Basque
#Hainbat metrika hartuta testu baten datuak atera testu hori konplexua ote den jakiteko
#2015-05-25
#metriken izenak laburutta, eta lexical density gehituta

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

    #us kopurua kontatu
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
    #amaieran zeuden zuriuneak kenduta (2015-05-26)
    #izen sintagmak
    if(($testuZatiak=~/ %SIB/)|| ($testuZatiak=~/ %SINT/)){
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

$mendekoPerpausKopurua = $konplPerpausKopurua + $erltPerpausKopurua + $denbPerpausKopurua +  $modPerpausKopurua +  $modDenbPerpausKopurua + $kausPerpausKopurua +  $kontPerpausKopurua +  $baldPerpausKopurua + $helbPerpausKopurua;

# print "KOPURUAK:\n";
# #Orokorrak
# print "Hitz kopurua: $hitzKopurua\n";
# print "Karaktere kopurua: $karaktereKopurua\n";
# print "Esaldi kopurua: $esaldiKopurua\n";
# print "Perpaus kopurua: $perpausKopurua\n";
# print "Aposizio kopurua: $aposizioKopurua\n";
# #######Kategoriak
# print "Kategoriak:\n" ;  #kategoria guztien batuketa eman  $KatGuztiakKopurua gaizki
# print "\t Izen kopurua: $izenKopurua\n";
# print "\t\t Izen berezi kopurua: $izenBereziKopurua\n";
# print "\t\t Leku izen berezi kopurua: $izenLekuKopurua\n";
# print "\t Aditz kopurua: $aditzKopurua\n";
# print "\t\t Aditz laguntzaile kopurua: $aditzlagKopurua\n";
# print "\t\t Aditz-izen kopurua: $aditzIzenKopurua\n";
# print "\t\t Aditz modal eta semi modal kopurua: $aditzModalKopurua\n";
# print "\t\t Aditz faktitibo kopurua: $aditzFakKopurua\n";
# print "\t\t Nor aditzen kopurua: $aditzNorKopurua\n";
# print "\t\t Nor-nork aditzen kopurua: $aditzNorkKopurua\n";
# print "\t\t Nor-nori aditzen kopurua: $aditzNoriKopurua\n";
# print "\t\t Nor-nori-nork aditzen kopurua: $aditzNorikKopurua\n";
# print "\t\t Geroaldiko aspektua duten aditzen kopurua: $aditzGeroKopurua\n";
# print "\t\t Aspektu burutua duten aditzen kopurua: $aditzBuruKopurua\n";
# print "\t\t Aspektu ez burutua duten aditzen kopurua: $aditzEzBuruKopurua\n";
# print "\t\t Aspektu puntukaria duten aditzen kopurua (aditz trikoak): $aditzPuntKopurua\n";
# print "\t\t Orainaldiko aditzen kopurua: $orainaldia\n";
# print "\t\t Lehenaldiko aditzen kopurua: $lehenaldia\n";
# print "\t\t Alegialdiko aditzen kopurua: $alegialdia\n";
# print "\t\t Geroaldi arkaikoa (suposotiboa) duten aditzen kopurua: $geroaldiArkaikoa\n";
# print "\t\t Indikatiboko aditzen kopurua: $indikatibo\n";
# print "\t\t Subjuntiboko aditzen kopurua: $subjuntibo\n";
# print "\t\t Ahalerazko aditzen kopurua: $ahalera\n";
# print "\t\t Inperatibozko aditzen kopurua: $inperatibo\n";
# print "\t Adjektibo kopurua: $adjKopurua\n";
# print "\t Adberbio kopurua: $adbKopurua\n";
# print "\t Lokailu kopurua: $lokKopurua\n";
# print "\t \t Emendiozko lokailu kopurua: $emenLokKopurua\n";
# print "\t \t Azalpenezko lokailu kopurua: $esplLokKopurua\n";
# print "\t \t Aurkaritzako lokailu kopurua: $aurkLokKopurua\n";
# print "\t \t Kausazko lokailu kopurua: $kausLokKopurua\n";
# print "\t \t Ondoriozko lokailu kopurua: $ondoLokKopurua\n";
# print "\t \t Moduzko lokailu kopurua: $modLokKopurua\n";
# print "\t \t Kontzesiozko lokailu kopurua: $kontLokKopurua\n";
# print "\t \t Hautakarizko lokailu kopurua: $hautLokKopurua\n";
# print "\t Juntagailu kopurua: $jntKopurua\n";
# print "\t \t Emendiozko juntagailu kopurua: $emenJntKopurua\n";
# print "\t \t Hautakarizko juntagailu kopurua: $hautJntKopurua\n";
# print "\t \t Aurkaritzako juntagailu kopurua: $aurkJntKopurua\n";
# print "\t Determinatzaile kopurua: $detKopurua\n";
# print "\t Partikula kopurua: $prtKopurua\n";
# print "\t Izenordain kopurua: $iorKopurua\n";
# print "\t Bestelakoen kopurua: $bstKopurua\n";
# print "\t Graduatzaileen kopurua: $gradKopurua\n";
# print "\t Interjekzioen kopurua: $itjKopurua\n";
# print "\t Haos kopurua: $haosKopurua\n";
# print "\t Laburtzapen kopurua: $labKopurua\n";
# print "\t Sigla kopurua: $sigKopurua\n";
# print "\t Sinbolo kopurua: $snbKopurua\n";
# ####### Mendeko perpausak
# print "Mendeko perpaus kopurua: $mendekoPerpausKopurua. Horietatik adberbialak:  $mendekoPerpausADBKopurua\n";
# print "\t Perpaus osagarrien kopurua: $konplPerpausKopurua\n";
# print "\t Erlatibozko perpausen kopurua: $erltPerpausKopurua\n";
# print "\t Denbora perpausen kopurua: $denbPerpausKopurua\n";
# print "\t Modu perpausen kopurua: $modPerpausKopurua\n";
# print "\t Modu-denbora perpausen kopurua: $modDenbPerpausKopurua\n";
# print "\t Kausa perpausen kopurua: $kausPerpausKopurua\n";
# print "\t Kontzesio perpausen kopurua: $kontPerpausKopurua\n";
# print "\t Baldintza perpausen kopurua: $baldPerpausKopurua\n";
# print "\t Helburu perpausen kopurua: $helbPerpausKopurua\n";
# #entitateak
# print "Entitate kopurua: $entiKopurua\n";
# ####### Kasu markak: 
# print "Kasu marka kopurua: $km. Horietatik komunztadura markak $kmKomunztadura  dira eta  leku-denbora markak $kmLekuDenb.\n";
# print "\t Ablatibo kopurua: $abl\n";
# print "\t Adlatibo bukatuzko kopurua: $abu\n";
# print "\t Adlatibo bide zuzeneko kopurua: $abz\n";
# print "\t Adlatibo kopurua: $ala\n";
# print "\t Soziatibo kopurua: $soz\n";
# print "\t Datibo kopurua: $dat\n";
# print "\t Destinabo kopurua: $des\n";
# print "\t Ergatibo kopurua: $erg\n";
# print "\t Leku denborazko genitibo kopurua: $gel\n";
# print "\t Genitibo kopurua: $gen\n";
# print "\t Inesibo kopurua: $ine\n";
# print "\t Instrumental kopurua: $ins\n";
# print "\t Motibatibo kopurua: $mot\n";
# print "\t Absolutibo kopurua: $abs\n";
# print "\t Partitibo kopurua: $par\n";
# print "\t Prolatibo kopurua: $pro\n";
# print "\t Banakari kopurua: $bnk\n";
# print "\t Deskribatzaile kopurua: $desk\n";
# ####### Sintagmak
# print "Sintagma kopurua: $sintagmak\n";
# print "\t Izen sintagma kopurua: $is\n";
# print "\t Aditz sintagma kopurua: $as\n";
# #print "\t Aditzlagun kopurua: $adlg\n";
# #print "\t Komunztaduradun sintagma kopurua:  $komunztaduraSint\n";
# ####### Elipsia
# print "Elipsi kopurua: $elipsia\n";
# print "\t Izen elipsi kopurua: $izeelipsia\n";
# print "\t Aditz elipsi kopurua: $adielipsia\n";
# print "\t Determinaltzaile elipsi kopurua: $detelipsia\n";
# print "\t Adberbio elipsi kopurua: $adbelipsia\n";
# print "\t Adjektibo elipsi kopurua: $adjelipsia\n";


# ######## RATIOAK
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

my $KaraktereHitzRatioa;
my $IzeHitzRatioa;
my $IzeIzenBereziRatioa;
my $EntiRatioa;
my $AditzHitzRatioa;

if  ($hitzKopurua != 0){
 $KaraktereHitzRatioa = $karaktereKopurua / $hitzKopurua; 
#kategoriak
 $IzeHitzRatioa = $izenKopurua / $hitzKopurua;
 $AditzHitzRatioa = $aditzKopurua / $hitzKopurua;
}

else{
$KaraktereHitzRatioa =0;
$IzeHitzRatioa = 0;
$AditzHitzRatioa =0;
}


if  ($izenKopurua != 0){
$IzeIzenBereziRatioa = ($izenLekuKopurua +  $izenBereziKopurua) /$izenKopurua;
$EntiRatioa = $entiKopurua  /$izenKopurua;
}

else{
$IzeIzenBereziRatioa = 0;
$EntiRatioa = 0;
}

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



# my $IzeAditzHitzRatioa = ($izenKopurua +  $aditzKopurua) / $hitzKopurua;
# my $LexicalDensity = ($izenKopurua +  $aditzKopurua + $adjKopurua + $adbKopurua) / $hitzKopurua; #2015-05-26 gehituta
# my $AdjHitzRatioa = $adjKopurua / $hitzKopurua;
# my $AdbHitzRatioa = $adbKopurua / $hitzKopurua;
# my $LokHitzRatioa = $lokKopurua / $hitzKopurua;
# my $JntHitzRatioa = $jntKopurua / $hitzKopurua;
# my $DetHitzRatioa = $detKopurua / $hitzKopurua;
# my $PrtHitzRatioa = $prtKopurua / $hitzKopurua;
# my $IorHitzRatioa = $iorKopurua / $hitzKopurua;
# my $BstHitzRatioa = $bstKopurua / $hitzKopurua;
# my $GradHitzRatioa = $gradKopurua / $hitzKopurua;
# my $ItjHitzRatioa = $itjKopurua / $hitzKopurua;
# my $HaosHitzRatioa = $haosKopurua / $hitzKopurua;
# my $LabHitzRatioa = $labKopurua / $hitzKopurua;
# my $SigHitzRatioa = $sigKopurua / $hitzKopurua;
# my $SnbHitzRatioa = $snbKopurua / $hitzKopurua;
 

my $IzeAditzHitzRatioa; 
my $LexicalDensity; 
my $AdjHitzRatioa; 
my $AdbHitzRatioa;
my $LokHitzRatioa; 
my $JntHitzRatioa; 
my $DetHitzRatioa; 
my $PrtHitzRatioa; 
my $IorHitzRatioa; 
my $BstHitzRatioa; 
my $GradHitzRatioa; 
my $ItjHitzRatioa; 
my $HaosHitzRatioa; 
my $LabHitzRatioa; 
my $SigHitzRatioa; 
my $SnbHitzRatioa; 



if  ($hitzKopurua != 0){

$IzeAditzHitzRatioa = ($izenKopurua +  $aditzKopurua) / $hitzKopurua;
$LexicalDensity = ($izenKopurua +  $aditzKopurua + $adjKopurua + $adbKopurua) / $hitzKopurua;
$AdjHitzRatioa = $adjKopurua / $hitzKopurua;
$AdbHitzRatioa = $adbKopurua / $hitzKopurua;
 $LokHitzRatioa = $lokKopurua / $hitzKopurua;
 $JntHitzRatioa = $jntKopurua / $hitzKopurua;
 $DetHitzRatioa = $detKopurua / $hitzKopurua;
 $PrtHitzRatioa = $prtKopurua / $hitzKopurua;
 $IorHitzRatioa = $iorKopurua / $hitzKopurua;
 $BstHitzRatioa = $bstKopurua / $hitzKopurua;
 $GradHitzRatioa = $gradKopurua / $hitzKopurua;
 $ItjHitzRatioa = $itjKopurua / $hitzKopurua;
 $HaosHitzRatioa = $haosKopurua / $hitzKopurua;
 $LabHitzRatioa = $labKopurua / $hitzKopurua;
 $SigHitzRatioa = $sigKopurua / $hitzKopurua;
 $SnbHitzRatioa = $snbKopurua / $hitzKopurua;

}

else {
$IzeAditzHitzRatioa = 0;
$LexicalDensity = 0;
$AdjHitzRatioa = 0;
$AdbHitzRatioa = 0;
 $LokHitzRatioa = 0;
 $JntHitzRatioa = 0;
 $DetHitzRatioa = 0;
 $PrtHitzRatioa = 0;
 $IorHitzRatioa = 0;
 $BstHitzRatioa = 0;
 $GradHitzRatioa = 0;
 $ItjHitzRatioa = 0;
 $HaosHitzRatioa = 0;
 $LabHitzRatioa = 0;
 $SigHitzRatioa = 0;
 $SnbHitzRatioa = 0;

}



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






# ###### Kasu markak
# my $AblKmRatioa =  $abl / $km;
# my $AbuKmRatioa =  $abu / $km;
# my $AbzKmRatioa =  $abz / $km;
# my $AlaKmRatioa =  $ala / $km;
# my $SozKmRatioa =  $soz / $km;
# my $DatKmRatioa =  $dat / $km;
# my $DesKmRatioa =  $des / $km;
# my $ErgKmRatioa =  $erg / $km;
# my $GelKmRatioa =  $gel / $km;
# my $GenKmRatioa =  $gen / $km;
# my $IneKmRatioa =  $ine / $km;
# my $InsKmRatioa =  $ins / $km;
# my $MotKmRatioa =  $mot / $km;
# my $AbsKmRatioa =  $abs / $km;
# my $ParKmRatioa =  $par / $km;
# my $ProKmRatioa =  $pro / $km;
# my $BnkKmRatioa =  $bnk / $km;
# my $DeskKmRatioa =  $desk / $km;  


my $AblKmRatioa;
my $AbuKmRatioa;
my $AbzKmRatioa;
my $AlaKmRatioa;
my $SozKmRatioa;
my $DatKmRatioa;
my $DesKmRatioa;
my $ErgKmRatioa;
my $GelKmRatioa;
my $GenKmRatioa;
my $IneKmRatioa;
my $InsKmRatioa;
my $MotKmRatioa;
my $AbsKmRatioa;
my $ParKmRatioa;
my $ProKmRatioa;
my $BnkKmRatioa;
my $DeskKmRatioa;


if  ($km!= 0){
 $AblKmRatioa =  $abl / $km;
 $AbuKmRatioa =  $abu / $km;
 $AbzKmRatioa =  $abz / $km;
 $AlaKmRatioa =  $ala / $km;
 $SozKmRatioa =  $soz / $km;
 $DatKmRatioa =  $dat / $km;
 $DesKmRatioa =  $des / $km;
 $ErgKmRatioa =  $erg / $km;
 $GelKmRatioa =  $gel / $km;
 $GenKmRatioa =  $gen / $km;
 $IneKmRatioa =  $ine / $km;
 $InsKmRatioa =  $ins / $km;
 $MotKmRatioa =  $mot / $km;
 $AbsKmRatioa =  $abs / $km;
 $ParKmRatioa =  $par / $km;
 $ProKmRatioa =  $pro / $km;
 $BnkKmRatioa =  $bnk / $km;
 $DeskKmRatioa =  $desk / $km; 
}

else {
 $AblKmRatioa =  0;
 $AbuKmRatioa =  0;
 $AbzKmRatioa = 0;
 $AlaKmRatioa =  0;
 $SozKmRatioa =  0;
 $DatKmRatioa =  0;
 $DesKmRatioa = 0;
 $ErgKmRatioa =  0;
 $GelKmRatioa =  0;
$GenKmRatioa =  0;
 $IneKmRatioa =  0;
 $InsKmRatioa =  0;
 $MotKmRatioa =  0;
 $AbsKmRatioa =  0;
$ParKmRatioa =  0;
 $ProKmRatioa =  0;
 $BnkKmRatioa =  0;
 $DeskKmRatioa = 0;
}



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


          
#print "RATIOAK:\n Testu honi dagozkion ratioak ondorengo hauek dira.\n";

#Orokorrak
#print "Orokorrak:\n";
print "WordPerSentence:\t$batazbesteHitzEsaldiko\n";
#print "Esaldien batazbesteko perpaus kopurua $batazbestePerpausEsaldiko da.\n";
print "ClausePerSentence:\t$batazbestePerpausEsaldiko\n";
#print "Perpausen batazbesteko mendeko perpaus kopurua $batazbestePerpausEsaldiko da.\n";
print "CharPerWord:\t$KaraktereHitzRatioa\n";
#######Kategoriak
#print "Kategorien emaitzak:\n";
print "NounsWords:\t$IzeHitzRatioa\n";
print "ProperNounsCommomNouns:\t$IzeIzenBereziRatioa\n";
print "NamedEntitiesCommonNouns:\t$EntiRatioa\n";
print "VerbsNouns:\t$AditzHitzRatioa\n";
print "VerbalNounsVerbs:\t$AdizeAditzRatioa\n";
print "ModalVerbsVerbs:\t$AdiModalAditzRatioa\n";
print "FakVerbsVerbs:\t$AdiFakAditzRatioa\n";
print "NorVerbsVerbs:\t$AdinorAditzRatioa\n";
print "Nor-norkVerbsVerbs:\t$AdinorkAditzRatioa\n";
print "Nor-noriVerbVerbs:\t$AdinoriAditzRatioa\n";
print "Nor-nori-norkVerbsVerbs:\t$AdinorikAditzRatioa\n";
print "GeroVerbsVerbs:\t$GeroAditzRatioa\n";
print "BuruVerbsVerbs:\t$BuruAditzRatioa\n";
print "EzbuVerbsVerbs:\t$EzBuruAditzRatioa\n";
print "PuntVerbsVerbs:\t$PuntAditzRatioa\n";
#aditzaren aldia eta modua
print "PresVerbsVerbs:\t$OrainAditzRatioa\n";
print "PastVerbsVerbs:\t$LehenAditzRatioa\n";
print "CondVerbsVerbs:\t$AlegiAditzRatioa\n";
print "SuposVerbVerbs:\t$GeroArkAditzRatioa\n";
print "IndVerbsVerbs:\t$IndAditzRatioa\n";
print "SubjVerbsVerb:\t$SubjAditzRatioa\n";
print "PotVerbVerbs:\t$AhalAditzRatioa\n";
print "ImpVerbsVerbs:\t$InpAditzRatioa\n"; 
print "Nouns+VerbsWords:\t$IzeAditzHitzRatioa\n";
print "LexicalDensity:\t$LexicalDensity\n"; #2015-05-26 gehituta
print "AdjsWords:\t$AdjHitzRatioa\n";
print "AdvsWords:\t$AdbHitzRatioa\n";
print "LoksWords:\t$LokHitzRatioa\n";
print "JntsWords:\t$JntHitzRatioa\n";
print "DetsWords:\t$DetHitzRatioa\n";
print "PrtsWords:\t$PrtHitzRatioa\n";
print "PrnsWords:\t$IorHitzRatioa\n";
print "OthsWords:\t$BstHitzRatioa\n";
print "GradsWords:\t$GradHitzRatioa\n";
print "ItjsWords:\t$ItjHitzRatioa\n";
print "HaosWords:\t$HaosHitzRatioa\n";
print "LabsWords:\t$LabHitzRatioa\n";
print "SiglsWords:\t$SigHitzRatioa\n";
print "SinbsWords:\t$SnbHitzRatioa\n";

####### Mendeko perpausak
#print "Mendeko perpausak:\n";
print "AdvsSubs:\t$AdbMendPerpausRatioa\n";
print "KonplsSubs:\t$KonplMendPerpausRatioa\n";
print "RelsSubs:\t$ErltMendPerpausRatioa\n";
print "TempsAdvs:\t$DenbMendPerpausRatioa\n";
print "ModsAdvs:\t$ModMendPerpausRatioa\n";
print "ModTempsAdvs:\t$ModDenbMendPerpausRatioa\n";
print "CausAdvs:\t$KausMendPerpausRatioa\n";
print "ConcsAdvs:\t$KontMendPerpausRatioa\n";
print "CondsAdvs:\t$BaldMendPerpausRatioa\n";
print "FinsAdvs:\t$HelbMendPerpausRatioa\n";
###### Lok eta Jnt
#print "Kohesioa (lokailuak eta juntagailuak):\n";
print "EmeLoksLoks:\t$EmenLokRatioa\n";
print "AzaLoksLoks:\t$EsplLokRatioa\n";
print "AurkLoksLoks:\t$AurkLokRatioa\n";
print "KausLoksLoks:\t$KausLokRatioa\n";
print "OndoLoksLoks:\t$OndoLokRatioa\n";
print "ModsLoksLoks:\t$ModLokRatioa\n";
print "KontLoksLoks:\t$KontLokRatioa\n";
print "BaldLoksLoks:\t$BaldLokRatioa\n";
print "HautLoksLoks:\t$HautLokRatioa\n";
print "EmeJntsJnts:\t$EmenJntRatioa\n";
print "HautJntsJnts:\t$HautJntRatioa\n";
print "AurkJntsJnts:\t$AurkJntRatioa\n";
###### Kasu markak
#print "Kasu markak:\n";
print "AblsKms:\t$AblKmRatioa\n";
print "AdlusKms:\t$AbuKmRatioa\n";
print "AdlbzsKms:\t$AbzKmRatioa\n";
print "AlasKms:\t$AlaKmRatioa\n";
print "SozsKms:\t$SozKmRatioa\n";
print "DatsKms:\t$DatKmRatioa\n";
print "DessKms:\t$DesKmRatioa\n";
print "ErgsKms:\t$ErgKmRatioa\n";
print "GelsKms:\t$GelKmRatioa\n";
print "GensKms:\t$GenKmRatioa\n";
print "InesKms:\t$IneKmRatioa\n";
print "InssKms:\t$InsKmRatioa\n";
print "MotsKms:\t$MotKmRatioa\n";
print "AbssKms:\t$AbsKmRatioa\n";
print "PartsKms:\t$ParKmRatioa\n";
print "ProlsKms:\t$ProKmRatioa\n";
print "BanaksKms:\t$BnkKmRatioa\n";
print "DesksKms:\t$DeskKmRatioa\n";
####### Elipsia
#print "Elipsia:\n";
print "EliWordsWords:\t$ElipsiHitzRatioa\n";
print "EliNounsEliWords:\t$IzeElipsiHitzRatioa\n";
print "EliVerbsEliWords:\t$AdiElipsiHitzRatioa\n";
print "EliDetsEliWords:\t$DetElipsiHitzRatioa\n";
print "EliAdvsEliWords:\t$AdbElipsiHitzRatioa\n";
print "EliAdjsEliWords:\t$AdjElipsiHitzRatioa\n";
####### Morfosintaxia 
#print "Morfosintaxia:\n";
print "AposPhrases:\t$ApoSintRatioa\n";
print "NPsPhrases:\t$ISSintRatioa\n";
print "VPsPhrases:\t$ASSintRatioa\n";
print "AposNSs:\t$ApoISRatioa\n";
print "NSsSentences:\t$ISEsaldiRatioa\n";

