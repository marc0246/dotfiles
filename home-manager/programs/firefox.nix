{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    policies.DisplayMenuBar = "never";
    profiles.default = {
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          clearurls
          decentraleyes
          sidebery
          sponsorblock
          ublock-origin
        ];
      };
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      settings = {
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "beacon.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.contentblocking.category" = "strict";
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.discovery.enabled" = false;
        "browser.eme.ui.enabled" = false;
        "browser.fixup.alternate.enabled" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "browser.region.network.url" = "";
        "browser.region.update.enabled" = false;
        "browser.safebrowsing.allowOverride" = false;
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.page" = 3;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.tabs.searchclipboardfor.middleclick" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.fakespot.featureGate" = false;
        "browser.urlbar.mdn.featureGate" = false;
        "browser.urlbar.pocket.featureGate" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.quicksuggest.scenario" = "history";
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.trimURLs" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "captivedetect.canonicalURL" = "";
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "dom.disable_open_during_load" = true;
        "dom.disable_window_move_resize" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;
        "extensions.enabledScopes" = 5;
        "extensions.autoDisableScopes" = 14;
        "extensions.getAddons.showPane" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.available" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.postDownloadThirdPartyPrompt" = false;
        "extensions.update.enabled" = false;
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;
        "geo.provider.use_gpsd" = false;
        "identity.fxaccounts.enabled" = false;
        "javascript.use_us_english_locale" = true;
        "media.autoplay.default" = 5;
        "media.eme.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.peerconnection.ice.default_address_only" = true;
        "media.peerconnection.ice.no_host" = true;
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.videocontrols.picture-in-picture.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "network.dns.disablePrefetch" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.speculative-parallel-limit" = 0;
        "network.IDN_show_punycode" = true;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.proxy.socks_remote_dns" = true;
        "pdfjs.enableScripting" = false;
        "permissions.manager.defaultsUrl" = "";
        "privacy.spoof_english" = 1;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "security.cert_pinning.enforcement_level" = true;
        "security.OCSP.require" = true;
        "security.pki.crlite_mode" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.ssl.require_safe_negotiation" = true;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.tls.enable_0rtt_data" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.rememberSignons" = false;
        "startup.homepage_override_url" = "";
        "startup.homepage_welcome_url" = "";
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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
        "webgl.disabled" = true;
      };
      userChrome = with outputs.lib.palette; ''
        #navigator-toolbox[fullscreenShouldAnimate] {
          transition: none !important;
        }

        #TabsToolbar {
          display: none;
        }

        #fullscreen-warning {
          display: none !important;
        }
      '';
    };
  };
}
