#!/usr/bin/perl
# Move from newpic to html
# if snap doesn't exist drop random file in
# Built 2022-08-28

my @oldpics = glob('/home/divellc/oldpics/*.jpg');
my $ra = $a[ int rand @oldpics ];
my $randpic = $oldpics[$ra];
#my $day = `date +%Y-%m`;
my $stamp = `date +%s`;
chomp $stamp;
open(LG, '>>', '/root/run.log');
my $fi;
my @outr = glob('/home/divellc/outrot/*.jpg');
my $ornum = @outr;
#my $daydir = "/home/divellc/arch/$day";

#if (-e $daydir) {
	# } else {
	  #	$md = `mkdir $daydir`;
	#}	

if ($outr > 40) {
	$mz = `mv /home/divellc/outrot/*.jpg /home/divellc/oldpics/`;
	$ch = `chown divellc:divellc /home/divellc/oldpics/*.jpg`;
	}

#if (-e '/home/divellc/newpic/snapshot.jpg') {
if (-e '/home/divellc/newpic/snapshot.jpg') {
	print "newpic file exists..\n";
	$md5 = `md5sum /home/divellc/newpic/snapshot.jpg`;
	chomp $md5;
	$fi = `file /home/divellc/newpic/snapshot.jpg`;
	#$xcpy = `cp /home/divellc/newpic/snapshot.jpg $daydir/$stamp.jpg`;
	$m = `mv /home/divellc/newpic/snapshot.jpg /var/www/html/thedive/snapshot.jpg`;
	print "photo mv from new to html\n";
	 if ($fi =~ /JPEG/) {
	    print LG "$stamp: JPEG $md5 mv from new to html\n";
	   } else {
            print LG "$stamp: NOJPEG $md5 mv from new to html\n";
           }
        } else {
	$mm = `cp $randpic /var/www/html/thedive/snapshot.jpg`;
	$or = `mv $randpic /home/divellc/outrot/`;
	print "copied random oldpic to html\n";
	print LG "$stamp: (array = $ornum) copied rand oldpic to html\n";
	}	


