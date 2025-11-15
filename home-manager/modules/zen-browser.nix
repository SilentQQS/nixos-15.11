{ inputs, ... }:
{
  # home.nix
  imports = [
    inputs.zen-browser.homeModules.twilight-official
    # or inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight-official
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true; # save webs for later reading
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false; 
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
