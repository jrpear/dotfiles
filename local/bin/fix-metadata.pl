#!/usr/bin/env perl

use v5.36;

use Image::ExifTool ('ImageInfo');

sub isTarget {
	my $file = $_;
	my $exifTool = Image::ExifTool->new();
	$exifTool->ExtractInfo($file);
	my $date = $exifTool->GetValue('CreateDate');
	return (!defined $date || $date eq '0000:00:00 00:00:00');
}

sub findTargets {
	my $dir = $_[0];
	my @files = <$dir/*>;
	return grep(isTarget, @files);
}

sub askForDateTime {
	my $file = $_[0];
	system("xdg-open '$file' >/dev/null 2>&1 >/dev/null");
	print("Enter date for '$file' (time will be 00:00:00): ");
	my $date = <STDIN>;
	chomp $date;
	unless ($date =~ /[0-9]{4}-[0-9]{2}-[0-9]{2}/) {
		die("date is wrong form");
	}
	return "$date 00:00:00";
}

sub fixFile {
	my $file = $_[0];
	my $dateTime = askForDateTime($file);
	my $exifTool = Image::ExifTool->new();
	$exifTool->SetNewValue('AllDates', $dateTime);
	$exifTool->WriteInfo($file);
}

sub fixEachTarget {
	my $dir = $_[0];
	my @targets = findTargets($dir);
	map {fixFile($_)} @targets;
}

sub main {
	my $dir = $ARGV[0];
	fixEachTarget($dir);
}

main();

