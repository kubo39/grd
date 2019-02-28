import std.algorithm;
import std.file;
import std.getopt;
import std.stdio;
import std.string;

class CustomError : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__)
    {
        super(msg, file, line);
    }
}

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

    string content;
    try
    {
        content = path.readText();
    }
    catch (FileException e)
    {
        throw new CustomError("Error reading " ~ path ~ ": " ~ e.msg);
    }

    foreach (line; lineSplitter(content))
    {
        if (line.canFind(pattern))
            writeln(line);
    }
    return 0;
}
