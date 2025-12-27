{
  programs.firefox = {
    enable = true;
    policies = {
      # privacy
      DisableEncryptedClientHello = false;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Enabled = true;
        Locked = true;
      };
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      HttpsOnlyMode = "force_enabled";

      # nixos specific settings
      AppAutoUpdate = false;
      DisableAppUpdate = true;
      DisableSystemAddonUpdate = true;
      ExtensionUpdate = false;

      # convenient stuff
      NoDefaultBookmarks = true;

      # !!! my own settings (not sure if they fits you). source: https://mozilla.github.io/policy-templates/
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAccounts = true;
      DisplayBookmarksToolbar = "never";
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisplayMenuBar = "never";
      DontCheckDefaultBrowser = true;
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      GenerativeAI = {
        Enabled = false;
        Chatbot = false;
        LinkPreviews = false;
        TabGroups = false;
        Locked = false;
      };
      # NewTabPage = false;
      OfferToSaveLogins = false;
      Preferences = {
        # privacy
        "toolkit.crashreporter.infoURL" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.previousBuildID" = "";
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.server_owner" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "browser.tabs.crashReporting.email" = false;
        "browser.tabs.crashReporting.emailMe" = false;
        "browser.tabs.crashReporting.sendReport" = false;

        "datareporting.healthreport.infoURL" = "";
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.firstRunURL" = "";

        "dom.ipc.plugins.flash.subprocess.crashreporter.enabled" = false;
        "dom.ipc.plugins.reportCrashURL" = false;


        # !!! my own settings (not sure if they fits you). source: https://mozilla.github.io/policy-templates/#preferences
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.search.region" = "US";
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.urlbar.autoFill" = true;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.topsites" = false;

        "extensions.unifiedExtensions.enabled" = false;

        "dom.forms.autocomplete.formautofill" = false;

      };
      SanitizeOnShutdown = {
        History = true;
        Locked = true;
      };
      SearchEngines = {
        Default = "DuckDuckGo";
      };
      TranslateEnabled = false;

      # mozilla addons
      ExtensionSettings = {
        # ublock
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        # privacy badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        # decentraleyes
        "jid1-BoFifL9Vbdl2zQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        # i still don't care about cookies
        "idcac-pub@guus.ninja" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        # bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        # vimium
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        # gruvbox-material theme
        "{1e01c787-99d2-4826-86df-0003da8e88cd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/gruvbox-material-theme/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };
}
