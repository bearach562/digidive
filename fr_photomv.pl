#!/usr/bin/perl
# Move from newpic to html
# if snap doesn't exist drop random file in
# Built 2022-08-28
#  Does the new snapshot exist is it a real file
#  if so, hash it, log it, add logo and move it to correct location future mk a copy
#  if not, get random pic, hash/log and add logo and mv to web


my $www = '/var/www/html/thedive/';
my @oldpics = glob('/home/divellc/oldpics/*.jpg');
my $idx = rand @oldpics;
my $randpic = $oldpics[$idx];
#print "My random pic = $randpic\n";
my $day = `date +%Y-%m-%d`;
my $stamp = `date +%s`;
chomp $stamp;
my $archpic = $stamp . '.jpg';
open(LG, '>>', '/root/run.log');
my $fi;
my @outr = glob('/home/divellc/outrot/*.jpg');
my $ornum = @outr;
my $daydir = "/home/divellc/arch/$day/";

if (-d $daydir) {
	print "$daydir directory exists\n";
} else {
	$rr = `mkdir /home/divellc/arch/$day/`;
	print "CREATING $daydir \n";
}



sub NPT {
	# Test new pic for
	# JPG and hash
	my $pic = $_[0];
	my $fl = `file $pic`;
	chomp $fl;
	   if ($fl =~ /empty/) {
		   $fl = 'empty'
		   # run sub oldpic
		   &rot();
	   } else {
		   if ($fl =~ /JPEG/) {
			   $fl = 'JPEG';
			   $arch = `cp /home/divellc/newpic/snapshot.jpg /home/divellc/arch/$day/`;
			   $arch = `mv /home/divellc/arch/$day/snapshot.jpg /home/divellc/arch/$day/$archpic`;
			   # add logo, mv and hash, log
			   &lmhl();
		   }
	    }
	print "sub NPT Is $fl, rm'g old file\n";
	$ren = `rm -f /home/divellc/newpic/snapshot.jpg`;

}

sub rot {
	# Rotate stock photo
        $im = `convert $randpic /root/bin/output.png -gravity southeast -geometry +15+15 -composite /home/divellc/oldpics/snapshotrd.jpg`;
	print "Added logo to randpic\n";
	sleep 1;
	$md5 = `md5sum /home/divellc/oldpics/snapshotrd.jpg`;
	chomp $md5;
	print LG "$stamp RP | MD5 $md5 \n";
	print "$stamp RP | MD5 $md5 \n";
	# future copy for time lapse
	#$xcpy = `cp /home/divellc/newpic/snapshot.jpg $daydir/$stamp.jpg`;
	$m = `mv /home/divellc/oldpics/snapshotrd.jpg /var/www/html/thedive/snapshot.jpg`;
}


sub lmhl {
	# $pix = $_[0];
       #my $dt = `date +%c`;
       #chomp $dt;
	# Add logo
	$im = `convert /home/divellc/newpic/snapshot.jpg /root/bin/output.png -gravity southeast -geometry +15+15 -composite /home/divellc/newpic/snapshotim.jpg`;
	print "Added logo to new snapshot\n";
	sleep 1;
	# Add date
	#$id = `convert /home/divellc/newpic/snapshotim.jpg -pointsize 24 -fill white -undercolor '#00000080' -gravity NorthWest -annotate +0+5 $dt /home/divellc/newpic/snapshotid.jpg`;
	$md5 = `md5sum /home/divellc/newpic/snapshotim.jpg`;       
	chomp $md5;
	print LG "$stamp NP | MD5 $md5 \n";
	print "$stamp NP | MD5 $md5 \n";
	# future copy for time lapse
	#$xcpy = `cp /home/divellc/newpic/snapshot.jpg $daydir/$stamp.jpg`;
	$m = `mv /home/divellc/newpic/snapshotim.jpg /var/www/html/thedive/snapshot.jpg`;
}

	
if (-e '/home/divellc/newpic/snapshot.jpg') {
	&NPT('/home/divellc/newpic/snapshot.jpg');
	print "New pic found\n";
        } else {
	print "No new pic, mv to randome\n";
	&rot();
	}	

