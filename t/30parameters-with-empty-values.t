#!/usr/bin/perl

use strict;
use warnings;

# This test file tests:
#
# https://rt.cpan.org/Public/Bug/Display.html?id=68554
#
# << Parameters with empty values not written to file >>

use Test::More tests => 1;

use Config::IniFiles;

use lib "./t/lib";

use Config::IniFiles::TestPaths;

sub slurp
{
    my ($filename)=@_;

    local *SLURP;

    open(SLURP, '<', $filename) or die "Cannot open $filename: $!";

    local $/;
    my $retval = <SLURP>;
    close(SLURP);

    return $retval;
}

{
    my $filename = t_file('params_30.ini');

    unlink($filename);

    my $ini = Config::IniFiles->new();

    $ini->newval('MySection', 'MyParam', '');

    $ini->WriteConfig($filename);

    my $contents = slurp($filename);

    unlink($filename);

    # TEST
    like ($contents, qr{^MyParam=$}ms, 'Empty parameter was written.');
}

=head1 COPYRIGHT & LICENSE

Copyright 2011 by Shlomi Fish

This program is distributed under the MIT (X11) License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut
