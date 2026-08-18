{ ... }: {
  # REMOVED:
  # "BlockExternalExtensions": true
  home.file.".config/chromium/policies/managed/policy-hardened-guide-autogen-config.json".text = ''
    {
        "AIModeSettings": 1,
        "AlternateErrorPagesEnabled": false,
        "AudioSandboxEnabled": true,
        "AutofillAddressEnabled": false,
        "AutofillCreditCardEnabled": false,
        "AutofillPredictionSettings": 2,
        "AutomatedPasswordChangeSettings": 2,
        "BackgroundModeEnabled": false,
        "BlockThirdPartyCookies": true,
        "BrowserLabsEnabled": false,
        "BrowserSignin": 0,
        "BuiltInAIAPIsEnabled": false,
        "ChromeSuggestionsSettings": 1,
        "ChromeVariations": 2,
        "ClearBrowsingDataOnExitList": [
            "download_history",
            "cached_images_and_files",
            "autofill"
        ],
        "ClickToCallEnabled": false,
        "CreateThemesSettings": 2,
        "DefaultBrowserSettingEnabled": false,
        "DefaultSensorsSetting": 2,
        "DesktopSharingHubEnabled": false,
        "DevToolsGenAiSettings": 2,
        "Disable3DAPIs": true,
        "DnsOverHttpsMode": "secure",
        "DnsOverHttpsTemplates": "https://family.dns.mullvad.net/dns-query",
        "EnableMediaRouter": false,
        "ExtensionAllowedTypes": [
            "extension",
            "theme"
        ],
        "ExtensionDeveloperModeSettings": 1,
        "ExtensionInstallAllowlist": [
            "ddkjiahejlhfcafbddmgiahcphecmpfh",
            "nngceckbapebfimnlniiiahkandclblb",
            "oboonakemofpalcgghocfoadofidjkkk"
        ],
        "GeminiActOnWebSettings": 1,
        "GeminiSettings": 1,
        "GeminiSparkSettings": 1,
        "GenAILocalFoundationalModelSettings": 1,
        "GoogleSearchSidePanelEnabled": false,
        "HelpMeWriteSettings": 2,
        "HistoryClustersVisible": false,
        "HistorySearchSettings": 2,
        "HttpsOnlyMode": "force_enabled",
        "LiveTranslateEnabled": false,
        "MediaRecommendationsEnabled": false,
        "MetricsReportingEnabled": false,
        "NTPCardsVisible": false,
        "NativeMessagingBlocklist": [
            "*"
        ],
        "NetworkPredictionOptions": 2,
        "NetworkServiceSandboxEnabled": true,
        "PasswordLeakDetectionEnabled": false,
        "PasswordManagerEnabled": false,
        "PaymentMethodQueryEnabled": false,
        "PrivacySandboxAdMeasurementEnabled": false,
        "PrivacySandboxAdTopicsEnabled": false,
        "PrivacySandboxPromptEnabled": false,
        "PrivacySandboxSiteEnabledAdsEnabled": false,
        "PromotionsEnabled": false,
        "PromptForDownloadLocation": true,
        "RelatedWebsiteSetsEnabled": false,
        "RemoteAccessHostAllowRemoteAccessConnections": false,
        "RemoteAccessHostFirewallTraversal": false,
        "RemoteDebuggingAllowed": false,
        "SafeBrowsingDeepScanningEnabled": false,
        "SafeBrowsingExtendedReportingEnabled": false,
        "SafeBrowsingSurveysEnabled": false,
        "SearchContentSharingSettings": 1,
        "SearchSuggestEnabled": false,
        "SharedClipboardEnabled": false,
        "ShoppingListEnabled": false,
        "ShowFullUrlsInAddressBar": true,
        "SitePerProcess": true,
        "SpellCheckServiceEnabled": false,
        "SyncDisabled": true,
        "TabCompareSettings": 2,
        "TranslateEnabled": false,
        "TranslatorAPIAllowed": false,
        "UrlKeyedAnonymizedDataCollectionEnabled": false,
        "UserFeedbackAllowed": false,
        "WebRtcIPHandling": "disable_non_proxied_udp",
        "WebRtcTextLogCollectionAllowed": false
    }
  '';

  programs.chromium = {
    enable = true;

    extensions = [
      {
        # Ublock Origin Lite
        id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
      }
      {
        # Bitwarden Password Manager
        id = "nngceckbapebfimnlniiiahkandclblb";
      }
    ];

    commandLineArgs = [
      "--use-fake-device-for-media-stream"
      "--component-updater=disable-pings"
      "--disable-breakpad"
      "--disable-crash-reporter"
      # "--disable-extensions"
      "--no-pings"
      "--propagate-iph-for-testing"
      "--js-flags=--jitless"
      "--disable-webgl"
      "--disable-3d-apis"
      "--extension-content-verification=enforce_strict"
      "--extensions-install-verification=enforce_strict"
      "--enable-features=ClearCrossSiteCrossBrowsingContextGroupWindowName,CertificateTransparencyAskBeforeEnabling,IsolateSandboxedIframes:grouping/per-document,ExtensionsManifestV3Only,AllowWithholdingExtensionPermissionsOnInstall,DebuggerAPIRestrictedToDevMode,SearchEngineUnconditionalDialog,CapReferrerToOriginOnCrossOrigin,LocalNetworkAccessChecksWebRTC,PartitionAllocWithAdvancedChecks:enabled-processes/all-processes,OriginKeyedProcessesByDefault,HstsTopLevelNavigationsOnly,PartitionConnectionsByNetworkIsolationKey,ScopeMemoryCachePerContext,SplitCacheByIncludeCredentials,SplitCacheByNetworkIsolationKey,SplitCodeCacheByNetworkIsolationKey,ReduceAcceptLanguage,StrictOriginIsolation"
      "--disable-features=AimEnabled,LensStandalone,StarterPackExpansion,AutofillServerCommunication,InterestFeedV2,NTPPopularSitesBakedInContent,Journeys,MediaDrmPreprovisioning,OptimizationHints,OptimizationHintsFetchingSRP,BrowsingTopics,BrowsingTopicsDocumentAPI,BrowsingTopicsParameters,PrivacySandboxSettings4,Reporting,CrashReporting,DocumentReporting,AllowSwiftShaderFallback,AllowSoftwareGLFallbackDueToCrash,TabHoverCardImages,WebGPUBlobCache,WebGPUService"
    ];
  };
}
