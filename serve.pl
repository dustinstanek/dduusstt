#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;
use File::Basename;
use Cwd 'abs_path';

my $port = $ARGV[0] || 8899;
my $root = dirname(abs_path($0));

my %mime = (
    html => 'text/html',
    css  => 'text/css',
    js   => 'application/javascript',
    json => 'application/json',
    png  => 'image/png',
    jpg  => 'image/jpeg',
    jpeg => 'image/jpeg',
    gif  => 'image/gif',
    svg  => 'image/svg+xml',
    woff => 'font/woff',
    woff2=> 'font/woff2',
    ico  => 'image/x-icon',
);

my $server = IO::Socket::INET->new(
    LocalPort => $port,
    Type      => SOCK_STREAM,
    Reuse     => 1,
    Listen    => 10,
) or die "Cannot start server on port $port: $!\n";

print "Serving $root on http://localhost:$port\n";
$| = 1;

while (my $client = $server->accept()) {
    my $request = <$client>;
    next unless $request;

    # Read and discard headers
    while (my $header = <$client>) {
        last if $header =~ /^\r?\n$/;
    }

    my ($method, $path) = $request =~ /^(\w+)\s+(\S+)/;
    $path =~ s/\?.*//;            # strip query string
    $path =~ s/%20/ /g;           # basic URL decode
    $path =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/ge;

    # Default to preview.html
    $path = '/preview.html' if $path eq '/';

    my $file = "$root$path";

    if (-f $file) {
        open my $fh, '<:raw', $file or do {
            print $client "HTTP/1.0 500 Internal Server Error\r\n\r\n";
            close $client;
            next;
        };
        my $data = do { local $/; <$fh> };
        close $fh;

        my ($ext) = $file =~ /\.(\w+)$/;
        my $type = $mime{lc($ext || '')} || 'application/octet-stream';

        print $client "HTTP/1.0 200 OK\r\n";
        print $client "Content-Type: $type; charset=utf-8\r\n";
        print $client "Content-Length: " . length($data) . "\r\n";
        print $client "Access-Control-Allow-Origin: *\r\n";
        print $client "\r\n";
        print $client $data;
    } else {
        print $client "HTTP/1.0 404 Not Found\r\n\r\n";
        print $client "404 Not Found: $path\n";
    }
    close $client;
}
