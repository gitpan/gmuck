# $Id: gmuck.spec,v 1.12 2003/09/04 21:27:51 scop Exp $

Name:           gmuck
Version:        1.09
Release:        1
Epoch:          0
Summary:        gmuck, the Generated MarkUp ChecKer

License:        GPL or Artistic
Group:          Development/Tools
Vendor:         Ville Skyttä <ville.skytta@iki.fi>
URL:            http://gmuck.sourceforge.net/
Source:         http://download.sourceforge.net/gmuck/gmuck-1.09.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildArch:      noarch
BuildRequires:  perl >= 0:5.00503, perl-HTML-Tagset >= 3.03
Requires:       perl >= 0:5.00503, perl-HTML-Tagset >= 3.03

%description
gmuck assists you in generating valid (X)HTML by examining the source code
that generates it.  It is not a replacement for real validation tools, but
is handy in quick checks and in situations where validation of the actual
markup is troublesome.


%prep
%setup -q


%build
CFLAGS="$RPM_OPT_FLAGS" perl Makefile.PL INSTALLDIRS=vendor
make OPTIMIZE="$RPM_OPT_FLAGS"
# not just yet: make test


%install
rm -rf $RPM_BUILD_ROOT
make install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT
find $RPM_BUILD_ROOT -type f -a \( -name perllocal.pod -o -name .packlist \
  -o \( -name '*.bs' -a -empty \) \) -exec rm -f {} ';'
find $RPM_BUILD_ROOT -type d -depth -exec rmdir {} 2>/dev/null ';'
chmod -R u+w $RPM_BUILD_ROOT/*


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc BUGS README TODO
%{_bindir}/gmuck
%{_libdir}/perl*/*
%{_mandir}/man?/*


%changelog
* Thu Sep  4 2003 Ville Skyttä <ville.skytta at iki.fi>
- See ChangeLog.
