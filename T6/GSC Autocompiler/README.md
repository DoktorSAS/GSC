# GSC Autocompiler/Fastcompiler for a more convenient gsc modding

The auto compiler gsc is nothing but a simple [powershell](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.1) script that allows you to compile a mod for Black ops II (Plutonium and Redacted).
The script uses three directories:
1. 'src': Folder where is contained the source code to compile
2. 'bin': Folder where the compiled script is placed
3. 'compiler': Folder where the compiler for the gsc scripts is kept

It is also possible to convert the powershell into an .exe. I created one based on the original script (if you don't trust my .exe you can recompile it by yourself).

The script in textual environments such as [Visual Studio Code](https://code.visualstudio.com/), [Notepad](https://notepad-plus-plus.org/downloads/), [Atom](https://atom.io/), etc. ... is very convenient to have the scripts divided into smaller portions of code and easily explorable.

If you have difficulty following the written guide I also leave you a guide in the form of a step-by-step video.
Press [here](https://www.youtube.com/watch?v=Wz0jEqxC0U8) for the video

### The Compiler folder
The gsc compiler is the compiler provided by the Plutonium team. In fact, it will not be provided by default due to security.

### Notification
When the code is executed several windows may be generated that will define a success, an error or a problem.
| Error| Description|
|:---:|:---:|
|![missingcompiler](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/missingcompilerfiles.png)|Unable to run the compiler because the compiler files (compiler.exe and/or Irony.dll) are missing. To solve the problem just download the [compiler files from Plutonium](https://drive.google.com/file/d/1j_ocjFCQsFaWqF2-PfdoJt2nF_EpNL_G/view) and copy them into the compiler folder.|
|![missingmain](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/missingmainfile.png)|The project cannot be completed because the main file (the file that contains the includes and the main and/or init functions) is missing. To solve the problem, just add a main.gsc file or rename your main file.|
|![projecterror](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/projecterror.png)|The source code of the project has an error, the compiler will report in the form of an error the line where the error is located while the windows notification will confirm the failure of the compilation.|
|![compliedsuccess](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/compiledsuccess.png)|The source code has been compiled correctly.|
|![unknownissue](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/unknownerror.png)|Unrecognized error, possible problem of any other type. (In case of this report the problem so that we can create a more complete script in catching errors).|

# Download
To download just press [here](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/GSC%20Autocompiler%20by%20DoktorSAS.rar?raw=true) or on the .rar file on this github page.




