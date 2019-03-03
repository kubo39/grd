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

struct Cli
{
    string pattern;
    string path;

    this(string pattern, string path)
    {
        this.pattern = pattern;
        this.path = path;
    }
}

Cli parseArgs(string[] args)
{
    return Cli(args[1], args[2]);
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

    auto cli = parseArgs(args);

    string content;
    try
    {
        content = cli.path.readText();
    }
    catch (FileException e)
    {
        throw new CustomError("Error reading " ~ cli.path ~ ": " ~ e.msg);
    }

    auto output = (outputFile !is null) ? File(outputFile, "w") : stdout;
    findMatches(content, cli.pattern, output.lockingTextWriter());
    return 0;
}
