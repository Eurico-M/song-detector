# Song Detector Script

Little script to enhance my live music streaming.

When run, the script continuously looks at a browser's active window, and if the window title fits into a certain pattern, outputs the formatted contents to a text file.
We can then use that simple .txt file as a source for OBS to display the current song being played. 
(by, for example, adding a new Text Source to OBS, ticking Read from file, and specifying the path to the .txt file.

So, for instance, when looking at the window called:

`YOUR DECISION CHORDS (ver 2) by Alice In Chains @ Ultimate-Guitar.Com`

The script would output:

`"Your Decision" by Alice in Chains`

to the file current_song.txt located in the same directory as the script.

A shortcut can be created, using in the Target option (Right-click shortcut, Properties):

`C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File "YOUR_PATH_TO_song_detector.ps1"`


Some notes:
- Windows doesn't like you running scripts willy nilly, so make sure you unblock the .ps1 file by Right-clicking -> Properties -> General -> Tick "Unblock".
- The script was made to check for Zen Browser windows, because that's the browser I'm currently using, but it should be easy to change this.
