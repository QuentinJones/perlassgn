#!/usr/bin/perl
#Extract the records from lastlog
$recs = "";
while (<>) {$recs .= $_};
$uid = 0;
#use diagnostics -verbose;
foreach (split(/(.{292})/s,$recs)) {
	next if length($_) == 0;
	my ($time,$line,$host) = $_ =~/(.{4})(.{32})(.{256})/;
	if (defined $line && $line =~ /\w/) {
		$line =~ s/\x00+//g;
		$host =~ s/\x00+//g;
		
		printf("%5d %s %8s %s\n",$uid,scalar(gmtime(unpack("I4",$time))),$line,$host)
		if (unpack("C4",$host) !~ m/:0/ ) {
			@hostOrIp = split(/\./, $host);
			if (is_ipv4($host)){
				print("Found an IP");
			}	
		}
 	}$uid++
 }
 print"\n" 
 
