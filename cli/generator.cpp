#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>

namespace fs = std::filesystem;
using namespace std;

int main() {
	string theProg = "";
	cout << "The program name: ";
	cin >> theProg;

	ofstream installer("install.sh");
	installer << "#!/bin/bash" << '\n'
		  << "source = " << theProg << '\n'
		  << "sudo cp $source /usr/bin/" << '\n';
	installer.close();

	cout << "INSTALLER GENERATED" << endl;
}
