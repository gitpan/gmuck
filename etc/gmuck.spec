# $Id: gmuck.spec,v 1.5 2002/05/12 16:51:06 scop Exp $

Summary:        gmuck, the Generated MarkUp ChecKer
Name:           gmuck
Version:        1.06
Release:        1
License:        Artistic / GPL
Group:          Development/Tools
Vendor:         Ville Skyttä <ville.skytta@iki.fi>
URL:            http://gmuck.sourceforge.net/
Source:         http://download.sourceforge.net/gmuck/%{name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-root
Requires:       perl >= 0:5.00503, perl-HTML-Tagset >= 3.03
BuildRequires:  perl >= 0:5.00503, perl-HTML-Tagset >= 3.03
BuildArch:      noarch

%description
gmuck assists you in generating valid (X)HTML by examining the source code
that generates it.  It is not a replacement for real validation tools, but
is handy in quick checks and in situations where validation of the actual
markup is troublesome.

%prep
%setup -q

%build
CFLAGS="$RPM_OPT_FLAGS" perl Makefile.PL
make OPTIMIZE="$RPM_OPT_FLAGS"
# not just yet: make test

%install
rm -rf $RPM_BUILD_ROOT
eval `perl '-V:installarchlib'`
mkdir -p $RPM_BUILD_ROOT/$installarchlib
make PREFIX=$RPM_BUILD_ROOT%{_prefix} install

[ -x /usr/lib/rpm/brp-compress ] && /usr/lib/rpm/brp-compress

find $RPM_BUILD_ROOT%{_prefix} -type f -print | \
	sed "s@^$RPM_BUILD_ROOT@@g" | \
	grep -v perllocal.pod | \
	grep -v "\.packlist" > %{name}-%{version}-filelist
if [ "$(cat %{name}-%{version}-filelist)X" = "X" ] ; then
    echo "ERROR: EMPTY FILE LIST"
    exit -1
fi

%clean
rm -rf $RPM_BUILD_ROOT

%files -f %{name}-%{version}-filelist
%defattr(-,root,root,-)

%changelog
* Wed Apr 17 2002 Ville Skyttä <ville . skytta @ iki . fi>
- First spec file.
