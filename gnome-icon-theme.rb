class GnomeIconTheme < Formula
  desc "Icons for the GNOME project"
  homepage "https://developer.gnome.org"
  url "https://download.gnome.org/sources/adwaita-icon-theme/3.18/adwaita-icon-theme-3.18.0.tar.xz"
  sha256 "5e9ce726001fdd8ee93c394fdc3cdb9e1603bbed5b7c62df453ccf521ec50e58"

  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "jessevdk/gnome/gtk+3" => :build # for gtk3-update-icon-cache
  depends_on "icon-naming-utils" => :build
  depends_on "intltool" => :build
  depends_on "jessevdk/gnome/librsvg" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "GTK_UPDATE_ICON_CACHE=#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache"
    system "make", "install"
  end

  test do
    # This checks that a -symbolic png file generated from svg exists
    # and that a file created late in the install process exists.
    # Someone who understands GTK+3 could probably write better tests that
    # check if GTK+3 can find the icons.
    assert (share/"icons/Adwaita/96x96/status/weather-storm-symbolic.symbolic.png").exist?
    assert (share/"icons/Adwaita/index.theme").exist?
  end
end
