#!/user/bin/perl -w
use warnings;
use strict;
my $count = 1;
my $i;
my $line;
my $id;
my $sequenz="";
my @arr;
my @massen;
my $masse;
my $letter;
my $j;
my $massegerundet;
my $idneu;
my $file = "C:/Dokumente und Einstellungen/Maria_Liebl/test.fasta";

open(DATEI,$file) || die ("Fehler: Die Datei test.fasta konnte nicht eingelesen werden") ;

while(<DATEI>)
{
	$line=$_;
	chomp($line); 

	if($line=~/(^>(\w+))|^$/)# entweder anfang neues records oder Ende gleich am Anfang(llere Zeile)
	{
		$idneu=$2;
		if (length($sequenz)==0){
			$id = $2;
			$sequenz = "";
			$count = 0;
		}
		else #anfang eines neuen records erreicht, masse fuer die letzte sequenz berechnen
		{
			$sequenz=~s/R(?!P)/R /g;             #Record an Arginin spalten
			$sequenz=~s/K(?!P)/K /g;		     #Record an Lysin spalten
			@arr=split(" ",$sequenz);
			#print "id: $id\n";
			#print "$sequenz \n";
			@massen=(0) x @arr;#initialisierung
			for($i=0;$i<=$#arr;$i++)
			{
				$masse=0.00;		
				for($j=0;$j<=length($arr[$i]);$j++)
				{
					$letter=substr($arr[$i],$j,1);
					if($letter eq "A"){$masse+=71.07884;}
					elsif($letter eq "B"){$masse+=110.000;}
					elsif($letter eq "C"){$masse+=103.14484;}
					elsif($letter eq "D"){$masse+=115.08864;}
					elsif($letter eq "E"){$masse+=129.11552;}
					elsif($letter eq "F"){$masse+=147.1766;}
					elsif($letter eq "G"){$masse+=57.05196;}
					elsif($letter eq "H"){$masse+=137.1412;}
					elsif($letter eq "I"){$masse+=113.15948;}
					elsif($letter eq "K"){$masse+=128.17416;}
					elsif($letter eq "L"){$masse+=113.15948;}
					elsif($letter eq "M"){$masse+=131.1986;}
					elsif($letter eq "N"){$masse+=114.10392;}
					elsif($letter eq "P"){$masse+=97.11672;}
					elsif($letter eq "Q"){$masse+=128.1308;}
					elsif($letter eq "R"){$masse+=156.18764;}
					elsif($letter eq "S"){$masse+=87.07824;}
					elsif($letter eq "T"){$masse+=101.10512;}
					elsif($letter eq "V"){$masse+=99.1326;}
					elsif($letter eq "W"){$masse+=186.21328;}
					elsif($letter eq "Y"){$masse+=163.176;}
					elsif($letter eq "X"){$masse+=110.000;}
					elsif($letter eq "Z"){$masse+=110.000;}
				}
				#print "masse: $masse\n";
				if($masse >=800 && $masse<=4000)
				{
					$massegerundet=sprintf("%.2f", $masse);
					$massen[$i]=$massegerundet;
					if($massegerundet=~/^1164.33|^1483.73|^1567.79|^1642.94|^1902.09|^2152.49|^2172.47|^2202.56|^2342.64|^2859.09/)
					{
						#print "masse in if: $massegerundet\n";
						$count++;
					}

				}
			}   #End 1. for-Schleife	
			if($count>7)# treffer
			{
				print "ID des gefundenen Proteins : $id\n";
				print "$sequenz \n";
				print "massen: @massen\n";
				print $count;
			}
			$id = $idneu;
			$sequenz = "";
			$count = 0;
			undef(@massen);
		}
	}
	else {
		$sequenz.=$line;
	}
	
}close(DATEI);
