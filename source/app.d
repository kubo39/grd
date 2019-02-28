import std.algorithm;
import std.file;
import std.getopt;
import std.stdio;
import std.string;

void usage()
{
    stderr.writeln(`
USAGE:
    grd <pattern> <path>
`);
}

int main(string[] args)
{
    string output = void;
    auto helpInformation = args.getopt("o|output", &output);
    if (helpInformation.helpWanted)
    {
        usage();
        return 0;
    }
    if (args.length < 2)
    {
        usage();
        return 1;
    }
    string pattern = args[1];
    string path = args[2];

    auto content = path.readText();
    foreach (line; lineSplitter(content))
    {
        if (line.canFind(pattern))
            writeln(line);
    }
    return 0;
}
