#!/usr/bin/perl
use strict;
use warnings;
use JSON::PP;  # Module untuk save/load data
use Term::ANSIColor;  # Module buat warna

my %vault;
my %ttl;  # Simpan waktu expiry key
my $data_file = "vault_data.json";

# Load data saat start
load_data();

print color("bold cyan"), "🔑 PerlMiniRedis 1.0\n", color("reset");
print "Type ", color("yellow"), "HELP", color("reset"), " for commands\n";
print ">> ";

while (<STDIN>) {
    chomp;
    my ($cmd, $key, $val, $ttl_val) = split /\s+/, $_, 4;

    if ($cmd eq "SET" && $key && defined $val) {
        $vault{$key} = $val;
        $ttl{$key} = time + $ttl_val if $ttl_val;
        print color("green"), "OK\n", color("reset"), ">> ";
    } 
    elsif ($cmd eq "GET" && $key) {
        if (exists $ttl{$key} && time > $ttl{$key}) {
            delete $vault{$key};
            delete $ttl{$key};
            print "(nil)\n>> ";
        } else {
            print color("blue"), "$vault{$key}\n", color("reset"), ">> ";
        }
    }
    elsif ($cmd eq "DEL" && $key) {
        delete $vault{$key};
        delete $ttl{$key};
        print color("green"), "OK\n", color("reset"), ">> ";
    }
    elsif ($cmd eq "TTL" && $key) {
        if (exists $ttl{$key}) {
            my $remaining = $ttl{$key} - time;
            print "$remaining seconds\n>> ";
        } else {
            print "(no TTL)\n>> ";
        }
    }
    elsif ($cmd eq "LIST") {
        print join("\n", keys %vault) . "\n>> ";
    }
    elsif ($cmd eq "HELP") {
        print <<"END_HELP";
COMMANDS:
  SET <key> <value> [TTL]  # Set key with optional expiry (seconds)
  GET <key>                # Get value by key
  DEL <key>                # Delete key
  TTL <key>                # Check remaining TTL
  LIST                     # List all keys
  SAVE                     # Force save to disk
  HELP                     # Show this help
END_HELP
        print ">> ";
    }
    elsif ($cmd eq "SAVE") {
        save_data();
        print color("green"), "Data saved!\n", color("reset"), ">> ";
    }
    else {
        print color("red"), "? Invalid command. Type HELP\n", color("reset"), ">> ";
    }
}

# Auto-save saat exit
END {
    save_data();
}

sub save_data {
    my %data = (vault => \%vault, ttl => \%ttl);
    open my $fh, ">", $data_file or die "Cannot save data: $!";
    print $fh encode_json(\%data);
    close $fh;
}

sub load_data {
    if (-e $data_file) {
        open my $fh, "<", $data_file or die "Cannot load data: $!";
        my $json = do { local $/; <$fh> };
        my %data = %{ decode_json($json) };
        %vault = %{ $data{vault} };
        %ttl = %{ $data{ttl} };
        close $fh;
    }
}