#! /usr/bin/perl
################################################################################
## task - a command line task list manager.
##
## Copyright 2006 - 2009, Paul Beckingham.
## All rights reserved.
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 2 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
## FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, write to the
##
##     Free Software Foundation, Inc.,
##     51 Franklin Street, Fifth Floor,
##     Boston, MA
##     02110-1301
##     USA
##
################################################################################

use strict;
use warnings;
use Test::More tests => 7;

# Create the rc file.
if (open my $fh, '>', 'color.rc')
{
  print $fh "data.location=.\n",
            "color.pri.H=red\n",
            "color.pri.M=green\n",
            "color.pri.L=blue\n",
            "color.pri.none=yellow\n",
            "_forcecolor=1\n";
  close $fh;
  ok (-r 'color.rc', 'Created color.rc');
}

# Test the add command.
qx{../task rc:color.rc add priority:H red};
qx{../task rc:color.rc add priority:M green};
qx{../task rc:color.rc add priority:L blue};
qx{../task rc:color.rc add yellow};
my $output = qx{../task rc:color.rc list};

like ($output, qr/ \033\[31m .* red    .* \033\[0m /x, 'color.pri.H');
like ($output, qr/ \033\[32m .* green  .* \033\[0m /x, 'color.pri.M');
like ($output, qr/ \033\[34m .* blue   .* \033\[0m /x, 'color.pri.L');
like ($output, qr/ \033\[33m .* yellow .* \033\[0m /x, 'color.pri.none');

# Cleanup.
unlink 'pending.data';
ok (!-r 'pending.data', 'Removed pending.data');

unlink 'color.rc';
ok (!-r 'color.rc', 'Removed color.rc');

exit 0;
