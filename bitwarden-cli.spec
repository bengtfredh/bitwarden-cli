Packager: Bengt Fredh <bengt@fredhs.net> 

%define name bitwarden-cli
%define version 2023.3.0
%define releasebuild 1
%define release %{releasebuild}%{?dist}

Summary: The Bitwarden command-line interface (CLI)
Name: %{name}
Version: %{version}
Release: %{release}
License: APL 2.0
URL: https://bitwarden.com/help/cli/
Source0: https://github.com/bitwarden/clients/releases/download/cli-v%{version}/bw-linux-%{version}.zip

%global debug_package %{nil}

%description
The Bitwarden command-line interface (CLI)

%prep
%setup -c -T
unzip $RPM_SOURCE_DIR/bw-linux-%{version}.zip

%build

%install
install -d -p %{buildroot}%{_bindir}
install -p -m 0755 bw %{buildroot}%{_bindir}/bw

%files
%{_bindir}/bw

%post

%preun

%changelog
%autochangelog
