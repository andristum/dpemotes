Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- You can disable the (F3) menu here / change the keybind
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = true,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgur.com/kgzvDwQ.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = true,
	RagdollKeybind = 303, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	

}

Config.Languages = {
  ['en'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Dance Emotes",
        ['propemotes'] = "📦 Prop Emotes",
        ['keybindemotes'] = "🌟 Keybind",
        ['keybindinfo'] = "Select an emote here to set it as your bound emote.",
        ['rkeybind'] = "Reset Keybind",
        ['prop2info'] = "❓ Prop Emotes can be located at the end",
        ['set'] = "Set (",
        ['setboundemote'] = ") to be your bound emote?",
        ['newsetemote'] = "~w~ is now your bound emote, press ~g~CapsLock~w~ to use it.",
        ['cancelemote'] = "Cancel Emote",
        ['cancelemoteinfo'] = "~r~X~w~ Cancels the currently playing emote",
        ['walkingstyles'] = "Walking Styles",
        ['resetdef'] = "Reset to default",
        ['normalreset'] = "Normal (Reset)",
        ['moods'] = "Moods",
        ['infoupdate'] = "Info / Update notes",
        ['suggestions'] = "Suggestions?",
        ['suggestionsinfo'] = "'dullpear_dev' on FiveM forums for any feature/emote suggestions! ✉️"
  },
  ['fr'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Emotes de danse",
        ['propemotes'] = "📦 Em Prop Emotes",
        ['keybindemotes'] = "🌟 Keybind",
        ['keybindinfo'] = "Sélectionnez une emote ici pour la définir comme emote liée.",
        ['rkeybind'] = "Réinitialiser le raccourci clavier",
        ['prop2info'] = "❓ Prop Emotes peuvent être situés à la fin",
        ['set'] = "Set (",
        ['setboundemote'] = ") pour être votre emote lié?",
        ['newsetemote'] = "~ w ~ est maintenant votre emote liée, appuyez sur ~ g ~ CapsLock ~ w ~ pour l'utiliser.",
        ['cancelemote'] = "Annuler Emote",
        ['cancelemoteinfo'] = "~ r ~ X ~ w ~ Annule l'emote en cours de lecture",
        ['walkingstyles'] = "Styles de marche",
        ['resetdef'] = "Réinitialiser aux valeurs par défaut",
        ['normalreset'] = "Normal (réinitialiser)",
        ['moods'] = "Humeurs",
        ['infoupdate'] = "Info / Notes de mise à jour",
        ['suggestions'] = "Suggestions?",
        ['suggestionsinfo'] = "'dullpear_dev' sur les forums FiveM pour toutes les suggestions de fonction / emote! ✉️"
  },
  ['de'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Tanz-Emotes",
        ['propemotes'] = "📦 Prop-Emotes",
        ['keybindemotes'] = "🌟 Keybind",
        ['keybindinfo'] = "Wählen Sie hier ein Emote aus, um es als gebundenes Emote festzulegen.",
        ['rkeybind'] = "Keybind zurücksetzen",
        ['prop2info'] = "❓ Prop-Emotes können am Ende platziert werden",
        ['set'] = "Set (",
        ['setboundemote'] = ") soll dein gebundenes Emote sein?",
        ['newsetemote'] = "~ w ~ ist jetzt dein gebundenes Emote, drücke ~ g ~ CapsLock ~ w ~, um es zu verwenden.",
        ['cancelemote'] = "Emote abbrechen",
        ['cancelemoteinfo'] = "~ r ~ X ~ w ~ Bricht das aktuell wiedergegebene Emote ab",
        ['walkingstyles'] = "Gehstile",
        ['resetdef'] = "Auf Standard zurücksetzen",
        ['normalreset'] = "Normal (Zurücksetzen)",
        ['moods'] = "Stimmungen",
        ['infoupdate'] = "Info / Update Notizen",
        ['suggestions'] = "Vorschläge?",
        ['suggestionsinfo'] = "'dullpear_dev' in FiveM-Foren für alle Feature- / Emote-Vorschläge! ✉️"
  },
  ['sv'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Dans Emotes",
        ['propemotes'] = "📦 Objekt Emotes",
        ['keybindemotes'] = "🌟 Favorit",
        ['keybindinfo'] = "Välj en emote här för att ställa in den som din favorit emote.",
        ['rkeybind'] = "Återställ Keybind",
        ['prop2info'] = "❓ Objekt Emotes finns längst ner i listan.",
        ['set'] = "Sätt (",
        ['setboundemote'] = ") till din favorit emote?",
        ['newsetemote'] = "~w~ är nu din favorit emote, tryck ~g~CapsLock~w~ för att använda den.",
        ['cancelemote'] = "Avbryt Emote",
        ['cancelemoteinfo'] = "~r~X~w~ Avbryter det emote som för närvarande används.",
        ['walkingstyles'] = "Walking Stil",
        ['resetdef'] = "Återställ till standard",
        ['normalreset'] = "Normal (Återställ)",
        ['moods'] = "Humör",
        ['infoupdate'] = "Info / Updateringar",
        ['suggestions'] = "Förslag?",
        ['suggestionsinfo'] = "'dullpear_dev' på FiveM-forum för alla funktioner/emote-förslag! ✉️"
  },
}