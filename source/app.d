import core.stdc.stdlib;
import std.exception;
import std.getopt;
import std.stdio;

import grd;

class CustomError : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__)
    @safe pure nothrow
    {
        super(msg, file, line);
    }
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
    string[] outputFiles;
    arraySep = ",";
    scope (exit) arraySep = "";
    auto helpInformation = args.getopt("o|output", &outputFiles);
    if (helpInformation.helpWanted)
    {
        defaultGetoptPrinter("grd <pattern> <path>", helpInformation.options);
        return EXIT_SUCCESS;
    }
    if (args.length < 2)
    {
        defaultGetoptPrinter("grd <pattern> <path>", helpInformation.options);
        return EXIT_FAILURE;
    }

    auto cli = parseArgs(args);

    try
    {
        if (!outputFiles.length)
        {
            findMatches(File(cli.path, "r"), cli.pattern, stdout.lockingTextWriter());
        }
        else
        {
            foreach (outputFile; outputFiles)
            {
                auto output = File(outputFile, "w");
                findMatches(File(cli.path, "r"), cli.pattern, output.lockingTextWriter());
            }
        }
    }
    catch (ErrnoException e)
    {
        throw new CustomError("Error reading " ~ cli.path ~ ": " ~ e.msg);
    }
    return EXIT_SUCCESS;
}
