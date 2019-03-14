import std.stdio;
import std.json;
import std.csv;

import std.conv;
import std.array;
import std.algorithm.searching;
import std.string;



void main()
{
	// Ask for a file
	writeln("Give me a file to read:");
	string fileStr = readln().strip;


	// Open given file, read it into a string
	auto dataFile = File(fileStr, "r");
	string fileContents, line;
    while ((line = dataFile.readln()) !is null)
        fileContents ~= line;
	dataFile.close();


	// Parse file into JSON, open CSV doc for output
	JSONValue json = parseJSON(fileContents);
	auto csv = File("out.csv", "w");


	// Loop through all entries, export as a line in the CSV document
	foreach (JSONValue matchData; json.array())
	{
		// All the keys per match to be read and output
		string[] json_keys = [
			"match", "team_num", "scout", "teleop-hatch", "teleop-cargo"
		];

		// Loop through all above keys, output that JSON value to CSV file
		foreach(string attrib; json_keys) {
			csv.write("\"" ~ matchData[attrib].str ~ "\",");
		}
		csv.write("\n");
	}
}
