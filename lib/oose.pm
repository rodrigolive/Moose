package oose;

use strict;
use warnings;

use Class::MOP;

our $VERSION   = '1.05';
$VERSION = eval $VERSION;
our $AUTHORITY = 'cpan:STEVAN';

BEGIN {
    my $package;
    sub import {
        $package = $_[1] || 'Class';
        if ($package =~ /^\+/) {
            $package =~ s/^\+//;
            Class::MOP::load_class($package);
        }
    }
    use Filter::Simple sub { s/^/package $package;\nuse Moose;use Moose::Util::TypeConstraints;\n/; }
}

1;

__END__

=pod

=head1 NAME

oose - syntactic sugar to make Moose one-liners easier

=head1 SYNOPSIS

  # create a Moose class on the fly ...
  perl -Moose=Foo -e 'has bar => ( is=>q[ro], default => q[baz] ); print Foo->new->bar' # prints baz

  # loads an existing class (Moose or non-Moose)
  # and re-"opens" the package definition to make
  # debugging/introspection easier
  perl -Moose=+My::Class -e 'print join ", " => __PACKAGE__->meta->get_method_list'

  # also loads Moose::Util::TypeConstraints to allow subtypes etc
  perl -Moose=Person -e'subtype q[ValidAge] => as q[Int] => where { $_ > 0 && $_ < 78 }; has => age ( isa => q[ValidAge], is => q[ro]); Person->new(age => 90)'

=head1 DESCRIPTION

oose.pm is a simple source filter that adds C<package $name; use Moose;>
to the beginning of your script and was entirely created because typing
C<perl -e'package Foo; use Moose; ...'> was annoying me.

=head1 INTERFACE

oose provides exactly one method and it's automatically called by perl:

=over 4

=item B<import($package)>

Pass a package name to import to be used by the source filter.

=back

=head1 DEPENDENCIES

You will need L<Filter::Simple> and eventually L<Moose>

=head1 INCOMPATIBILITIES

None reported. But it is a source filter and might have issues there.

=head1 BUGS

See L<Moose/BUGS> for details on reporting bugs.

=head1 AUTHOR

Chris Prather  C<< <chris@prather.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2009 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
