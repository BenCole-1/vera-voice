# The iPhone Shortcut

The Shortcut turns one button press into a text message to yourself. There are two ways to build it.

## With Wispr Flow

Wispr Flow gives cleaner transcripts, but it transcribes in the cloud, so don't dictate anything you wouldn't send to a third party.

1. **Quick Dictation to Clipboard** (Wispr Flow action). Press the Action Button to start and press again to stop.
2. **Count** the characters in the dictation result.
3. **If** the count is greater than 2. Pressing again to stop also launches a second run that returns nothing, and this check keeps that run from sending a blank or a stale clipboard.
4. Inside the If, add **Send Message** with the dictation result, addressed to yourself, with **Show Compose Sheet off**.
5. Still inside, add **Vibrate Device**, then **Show Notification** with the dictation result as the body. Keep the notification last, so the confirmation can never be what gets sent.
6. Leave **Otherwise** empty and end the If.

Keep the Flow keyboard closed when you start, and leave Flow's Live Activities on.

## With Apple dictation

1. Add **Dictate Text**, with *Stop Listening* set to **On Tap**.
2. Add **Send Message** with the dictated text, addressed to yourself, with *Show When Run* off.
3. Add **Vibrate Device**, then **Show Notification** with the title `Sent to Vera ✓` and the dictated text as the body.

## Assign it

Go to **Settings → Action Button**, swipe to **Shortcut** and choose this one. Test it from the lock screen too.
