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
use Test::More tests => 41;

# Create the rc file.
if (open my $fh, '>', 'period.rc')
{
  print $fh "data.location=.\n";
  close $fh;
  ok (-r 'period.rc', 'Created period.rc');
}

=pod
http://github.com/pbeckingham/task/blob/857f813a24f7ce15fea9f2c28aadad84cb5c8847/src/task.cpp
619  // If the period is an 'easy' one, add it to current, and we're done.
620  int days = convertDuration (period);

Date getNextRecurrence (Date& current, std::string& period)

starting at line 509 special cases several possibilities for period, '\d\s?m'
'monthly', 'quarterly', 'semiannual', 'bimonthly', 'biannual', 'biyearly'.
Everything else falls through with period being passed to convertDuration.
convertDuration doesn't know about 'daily' though so it seems to be returning 0.

Confirmed:
  getNextRecurrence  convertDuration
  -----------------  ---------------
                     daily
                     day
                     weekly
                     sennight
                     biweekly
                     fortnight
  monthly            monthly
  quarterly          quarterly
  semiannual         semiannual
  bimonthly          bimonthly
  biannual           biannual
  biyearly           biyearly
                     annual
                     yearly
  *m                 *m
  *q                 *q
                     *d
                     *w
                     *y
=cut

my $output = qx{../task rc:period.rc add daily due:tomorrow recur:daily};
like ($output, qr/^$/, 'recur:daily');

$output = qx{../task rc:period.rc add day due:tomorrow recur:day};
like ($output, qr/^$/, 'recur:day');

$output = qx{../task rc:period.rc add weekly due:tomorrow recur:weekly};
like ($output, qr/^$/, 'recur:weekly');

$output = qx{../task rc:period.rc add sennight due:tomorrow recur:sennight};
like ($output, qr/^$/, 'recur:sennight');

$output = qx{../task rc:period.rc add biweekly due:tomorrow recur:biweekly};
like ($output, qr/^$/, 'recur:biweekly');

$output = qx{../task rc:period.rc add fortnight due:tomorrow recur:fortnight};
like ($output, qr/^$/, 'recur:fortnight');

$output = qx{../task rc:period.rc add monthly due:tomorrow recur:monthly};
like ($output, qr/^$/, 'recur:monthly');

$output = qx{../task rc:period.rc add quarterly due:tomorrow recur:quarterly};
like ($output, qr/^$/, 'recur:quarterly');

$output = qx{../task rc:period.rc add semiannual due:tomorrow recur:semiannual};
like ($output, qr/^$/, 'recur:semiannual');

$output = qx{../task rc:period.rc add bimonthly due:tomorrow recur:bimonthly};
like ($output, qr/^$/, 'recur:bimonthly');

$output = qx{../task rc:period.rc add biannual due:tomorrow recur:biannual};
like ($output, qr/^$/, 'recur:biannual');

$output = qx{../task rc:period.rc add biyearly due:tomorrow recur:biyearly};
like ($output, qr/^$/, 'recur:biyearly');

$output = qx{../task rc:period.rc add annual due:tomorrow recur:annual};
like ($output, qr/^$/, 'recur:annual');

$output = qx{../task rc:period.rc add yearly due:tomorrow recur:yearly};
like ($output, qr/^$/, 'recur:yearly');

$output = qx{../task rc:period.rc add 2d due:tomorrow recur:2d};
like ($output, qr/^$/, 'recur:2m');

$output = qx{../task rc:period.rc add 2w due:tomorrow recur:2w};
like ($output, qr/^$/, 'recur:2q');

$output = qx{../task rc:period.rc add 2m due:tomorrow recur:2m};
like ($output, qr/^$/, 'recur:2d');

$output = qx{../task rc:period.rc add 2q due:tomorrow recur:2q};
like ($output, qr/^$/, 'recur:2w');

$output = qx{../task rc:period.rc add 2y due:tomorrow recur:2y};
like ($output, qr/^$/, 'recur:2y');

# Verify that the recurring task instances get created.  One of each.
$output = qx{../task rc:period.rc list};
like ($output, qr/\bdaily\b/,      'verify daily');
like ($output, qr/\bday\b/,        'verify day');
like ($output, qr/\bweekly\b/,     'verify weekly');
like ($output, qr/\bsennight\b/,   'verify sennight');
like ($output, qr/\bbiweekly\b/,   'verify biweekly');
like ($output, qr/\bfortnight\b/,  'verify fortnight');
like ($output, qr/\bmonthly\b/,    'verify monthly');
like ($output, qr/\bquarterly\b/,  'verify quarterly');
like ($output, qr/\bsemiannual\b/, 'verify semiannual');
like ($output, qr/\bbimonthly\b/,  'verify bimonthly');
like ($output, qr/\bbiannual\b/,   'verify biannual');
like ($output, qr/\bbiyearly\b/,   'verify biyearly');
like ($output, qr/\bannual\b/,     'verify annual');
like ($output, qr/\byearly\b/,     'verify yearly');
like ($output, qr/\b2d\b/,         'verify 2d');
like ($output, qr/\b2w\b/,         'verify 2w');
like ($output, qr/\b2m\b/,         'verify 2m');
like ($output, qr/\b2q\b/,         'verify 2q');
like ($output, qr/\b2y\b/,         'verify 2y');

# Cleanup.
unlink 'pending.data';
ok (!-r 'pending.data', 'Removed pending.data');

unlink 'period.rc';
ok (!-r 'period.rc', 'Removed period.rc');

exit 0;
