#GCC filter script
#Converts GCC error messages into a format compatible with Visual Studio
#This file is provided "as is" under the BSD license

#To debug binaries produced by GCC with Visual Studio debugger, try VisualGDB:
# 						http://visualgdb.com/

sub unix2winpath
{
	my $fp = $_[0];
	if (substr($fp,1,1) eq ':')
	{
		$fp =~ s/\//\\/g;
		return $fp;
	}
	if (substr($fp,0,1) ne '/')
	{
		$fp =~ s/\//\\/g;
		return "$mydir\\$fp";
	}
	foreach(keys %MOUNTS)
	{
		if ($fp =~ /^$_\/(.*)$/)
		{
			my $suffix = $1;
			$suffix =~ s/\//\\/g;
			return "$MOUNTS{$_}\\$suffix";
		}
	}
	$fp =~ s/\//\\/g;
	return $ROOTMOUNT.$fp;
}

foreach(`mount`)
{
	if (/^([^ \t]+) on ([^ \t]+) /)
	{
		if ($2 eq '/')
		{
			$ROOTMOUNT = $1;
		}
		else
		{
			$MOUNTS{$2} = $1;
		}
	}
}

$mydir = `cmd /c cd`;
chomp $mydir;

foreach (<STDIN>)
{
	if (/^([^ ]+):([0-9]+):([0-9]+): (.*)$/)
	{
		print unix2winpath($1)."($2,$3) : $4\n";
	}
	elsif (/^(In file included from )([^ ]+):([0-9]+):([0-9]+):$/)
	{
		print unix2winpath($2)."($3,$4) : <==== Included from here (double-click to go to line)\n";
	}
	else
	{
		print "$_";
	}
}