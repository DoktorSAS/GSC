# GSC Autocompiler

The auto compiler gsc is nothing but a simple [powershell](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.1) script that allows you to compile a mod for Black ops II (Plutonium and Redacted).
The script uses three directories:
1. 'src': Folder where is contained the source code to compile
2. 'bin': Folder where the compiled script is placed
3. 'compiler': Folder where the compiler for the gsc scripts is kept


### The Compiler folder
The gsc compiler is the compiler provided by the Plutonium team. In fact, it will not be provided by default due to security.


### Notification
When the code is executed several windows may be generated that will define a success, an error or a problem.
| Error| Description|
|:---:|:---:|
|![missingcompiler](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/missingcompilerfiles.png)|Unable to run the compiler because the compiler files (compiler.exe and/or Irony.dll) are missing. To solve the problem just download the [compiler files from Plutonium](https://drive.google.com/file/d/1j_ocjFCQsFaWqF2-PfdoJt2nF_EpNL_G/view) and copy them into the compiler folder.|
|![missingmain](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/missingmainfile.png)|The project cannot be completed because the main file (the file that contains the includes and the main and/or init functions) is missing. To solve the problem, just add a main.gsc file or rename your main file.|
|![projecterror](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/projecterror.png)|The source code of the project has an error, the compiler will report in the form of an error the line where the error is located while the windows notification will confirm the failure of the compilation.|
|![compliedsuccess](https://github.com/DoktorSAS/GSC/blob/main/T6/GSC%20Autocompiler/assets/compiledsucces.png)|The source code has been compiled correctly.|
