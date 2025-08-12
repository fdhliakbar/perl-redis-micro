use strict;
use warnings;

my %vault;  # Hash untuk simpan key-value

print "🦜 Perl Vault 1.0 (Ctrl+D to exit)\n";
print ">> ";

while (<STDIN>) {
    chomp;
    my ($cmd, $key, $val) = split /\s+/, $_, 3;

    if ($cmd eq "SET" && $key && defined $val) {
        $vault{$key} = $val;
        print "OK\n>> ";
    } 
    elsif ($cmd eq "GET" && $key) {
        print "$vault{$key}\n>> ";
    }
    elsif ($cmd eq "DEL" && $key) {
        delete $vault{$key};
        print "OK\n>> ";
    }
    elsif ($cmd eq "LIST") {
        print join("\n", keys %vault) . "\n>> ";
    }
    else {
        print "? SET key value | GET key | DEL key | LIST\n>> ";
    }
}
