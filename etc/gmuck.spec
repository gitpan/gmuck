# $Id: gmuck.spec,v 1.14 2004/08/08 00:05:30 scop Exp $

%{!?perl_vendorlib: %define perl_vendorlib %(eval "`%{__perl} -V:installvendorlib`"; echo $installvendorlib)}

Name:           gmuck
Version:        1.10
Release:        1
Epoch:          0
Summary:        gmuck, the Generated MarkUp ChecKer

License:        GPL or Artistic
Group:          Development/Tools
Vendor:         Ville Skyttä <ville.skytta@iki.fi>
URL:            http://gmuck.sourceforge.net/
Source:         http://download.sourceforge.net/gmuck/gmuck-1.10.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildArch:      noarch
BuildRequires:  perl >= 1:5.6.1

%description
gmuck assists you in generating valid (X)HTML by examining the source code
that generates it.  It is not a replacement for real validation tools, but
is handy in quick checks and in situations where validation of the actual
markup is troublesome.


%prep
%setup -q


%build
%{__perl} Makefile.PL INSTALLDIRS=vendor
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
make pure_install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT
find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
find $RPM_BUILD_ROOT -type d -depth -exec rmdir {} 2>/dev/null ';'
chmod -R u+w $RPM_BUILD_ROOT/*


%check || :
make test


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc BUGS ChangeLog README SPECS TODO
%{_bindir}/gmuck
%{perl_vendorlib}/HTML
%{_mandir}/man[13]/*.[13]*


%changelog
* Sun Aug  8 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:1.10-1
- Update to 1.10.
- Install into vendor install dirs.

* Thu Sep  4 2003 Ville Skyttä <ville.skytta at iki.fi>
- See ChangeLog.
