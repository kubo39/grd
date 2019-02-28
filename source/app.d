import std.file;
import std.getopt;
import std.stdio;

import grd;

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

version (unittest)
{
    void main() {}
}
else
int main(string[] args)
{
    string outputFile;
    auto helpInformation = args.getopt("o|output", &outputFile);
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

    auto output = (outputFile !is null) ? File(outputFile, "w") : stdout;
    findMatches(content, pattern, output.lockingTextWriter());
    return 0;
}
