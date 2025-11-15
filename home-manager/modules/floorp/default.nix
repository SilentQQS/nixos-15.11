{
  pkgs,
  inputs,
  user,
  ...
}:
# let
# addons = inputs.firefox-addons.packages.${pkgs.system};
# in
{
  home.file = {
    ".floorp/icon.png".source = ./icon.png;
  };

  xdg.desktopEntries.floorp = {
    name = "Floorp";
    genericName = "Web Browser";
    exec = "floorp --name floorp %U";
    terminal = false;
    categories = ["Network" "WebBrowser"];
    icon = "/home/${user}/.floorp/icon.png";
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    startupNotify = true;
    actions = {
      new-window = {
        name = "New Window";
        exec = "floorp --new-window %U";
      };
      new-private-window = {
        name = "New Private Window";
        exec = "floorp --private-window %U";
      };
      profile-manager-window = {
        name = "Profile Manager";
        exec = "floorp --ProfileManager";
      };
    };
  };

  programs.floorp = {
    enable = true;
    # package = pkgs.floorp;
    policies = {
      # BlockAboutConfig = true;
      # DefaultDownloadDirectory = "\${home}/Downloads/floorp/";
    };
    profiles.default = {
      id = 0;
      isDefault = true;
      userChrome = ''
        #sidebar-box[sidebarcommand^="containertabs"] #sidebar-header { display: none; }
        #navigator-toolbox[fullscreenShouldAnimate] { transition: none !important; }
        .tabbrowser-tab > .tab-stack > .tab-content[pinned][titlechanged] { background-image: none !important; }
        .tabbrowser-tab > .tab-stack > .tab-background { flex-direction: row !important; }

        #tabbrowser-tabs {
          counter-reset: tab-counter;
        }
        .tabbrowser-tab .tab-label::before {
          counter-increment: tab-counter;
          content: counter(tab-counter) " ";
        }
      '';

      # extensions.packages = with addons; [
      #   # browserpass
      #   canvasblocker
      #   decentraleyes
      #   # enhancer-for-youtube
      #   nighttab
      #   noscript
      #   # popup-blocker
      #   proton-vpn
      #   translate-web-pages
      #   clearurls
      #   # containerise
      #   darkreader
      #   istilldontcareaboutcookies
      #   # multi-account-containers
      #   privacy-badger
      #   # refined-github
      #   sponsorblock
      #   ublock-origin
      #   # temporary-containers-plus
      #   # open-external-links-in-a-container
      # ];

      settings = {
        "floorp.download.notification" = 3;
        "floorp.legacy.dlui.enable" = true;
        "floorp.lepton.interface" = 1;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.engagement.ctrlTab.has-used" = true;
        "floorp.tabsleep.enabled" = true;
        "services.sync.prefs.sync.floorp.browser.note.memos" = false;
        "general.autoScroll" = true;
        "general.smoothScroll" = true;
        "floorp.disable.fullscreen.notification" = true;
        "floorp.browser.sidebar.enable" = false;
        "browser.newtabpage.activity-stream.floorp.background.type" = 0;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.disk.capacity" = 0;

        "accessibility.force_disabled" = 1;
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "apz.gtk.kinetic_scroll.enabled" = false;
        "apz.overscroll.enabled" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.contentblocking.category" = "strict";
        "browser.discovery.enabled" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.formfill.enable" = false;
        "browser.gesture.swipe.left" = "";
        "browser.gesture.swipe.right" = "";
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.search.suggest.enabled" = false;
        "browser.sessionstore.warnOnQuit" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.startup.page" = 3;
        "browser.tabs.inTitlebar" = 0;
        "browser.download.useDownloadDir" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.theme.dark-private-windows" = true;
        "browser.toolbars.bookmarks.visibility" = false;
        "browser.urlbar.trimURLs" = false;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "cookiebanners.ui.desktop.enabled" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "devtools.theme" = "auto";
        "devtools.toolbox.host" = "bottom";
        "dom.disable_window_move_resize" = true;
        "dom.forms.autocomplete.formautofill" = false;
        "dom.payments.defaults.saveAddress" = false;
        "dom.security.https_only_mode" = true;
        "dom.storage.next_gen" = true;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.available" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "gfx.webrender.all" = true;
        "layout.css.visited_links_enabled" = false;
        "media.memory_cache_max_size" = 65536;
        "media.peerconnection.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "network.gio.supported-protocols" = "";
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.protocol-handler.external.mailto" = false;
        "network.proxy.socks_remote_dns" = true;
        # "network.trr.mode" = 0;
        "network.trr.uri" = "https://dns.nextdns.io/dns-query";
        "permissions.delegation.enabled" = false;
        "privacy.clearOnShutdown.cache" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;
        "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.window.name.update.enabled" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.mixed_content.block_display_content" = true;
        "security.OCSP.require" = true;
        "security.pki.crlite_mode" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.ssl.require_safe_negotiation" = true;
        "services.sync.engine.addons" = false;
        "services.sync.engine.creditcards" = false;
        "services.sync.engine.passwords" = false;
        "sidebar.verticalTabs" = true;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.rememberSignons" = false;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.scrollbox.smoothScroll" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "widget.non-native-theme.enabled" = true;
      };
    };
  };
}
